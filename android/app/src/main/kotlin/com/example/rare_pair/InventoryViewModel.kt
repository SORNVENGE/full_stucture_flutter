/*
 * Copyright (c) 2020. Vyking.io. All rights reserved.
 */
package com.example.rare_pair

import android.app.Application
import android.content.SharedPreferences
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.net.Uri
import android.util.Log
import androidx.lifecycle.AndroidViewModel
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.preference.PreferenceManager
import com.google.android.filament.utils.*
import io.vyking.vykingtracker.*
import kotlinx.coroutines.*
import org.json.JSONObject
import java.io.*
import java.net.URL
import java.util.regex.Pattern
import io.vyking.vykingfilamentdemo.R

class InventoryViewModel constructor(
    application: Application
) : AndroidViewModel(application), SharedPreferences.OnSharedPreferenceChangeListener {
    private val tag: (String) -> String = { it -> "${this.javaClass.name}.$it" }

    data class Item(
        val shortShoeDescription: String,
        val longShoeDescription: String,
        val sneakerKitReference: String,
        val icon: Bitmap?,
        val parts: List<Part>
    ) {
        data class Part(
            val type: VykingTrackerJNI.TrackingData.DetectedObjectType,
            val name: String,
            val deferredSources: Deferred<List<VykingAccessorySource>>
        )
    }

    private val loadInventorySupervisoryJob: CompletableJob by lazy { SupervisorJob() }
    private val parser = VykingDescriptionJsonParser(getApplication())

    private val inventoryIsLoading = MutableLiveData<Boolean>()
    fun getInventory(): LiveData<List<Item>> = inventory
    private val inventory: MutableLiveData<List<Item>> by lazy { MutableLiveData<List<Item>>() }
    fun getInventoryIsLoading(): LiveData<Boolean> = inventoryIsLoading
    private val error = MutableLiveData<String>()
    fun getError(): LiveData<String> = error

    init {
        Log.d(tag("init"), "()")

        PreferenceManager.getDefaultSharedPreferences(getApplication()).apply {
            getString(
                getApplication<Application>().resources.getString(R.string.setting_vykingAccessoriesInventoryUri_key),
                getApplication<Application>().resources.getString(R.string.setting_vykingAccessoriesInventoryUri_defaultValue)
            )?.also {
                loadInventoryAsync(it)
            }
            registerOnSharedPreferenceChangeListener(this@InventoryViewModel)
        }
    }

    private fun loadInventoryAsync(inventoryAString: String) {
        // Use a supervisory job so a failed child job does not cancel other child jobs
        CoroutineScope(loadInventorySupervisoryJob).also { coroutineScope ->
            coroutineScope.launch(Dispatchers.IO) {
                try {
                    inventoryIsLoading.postValue(true)

                    inventory.postValue(withTimeout(30000) {
                        fun loadJson(bufferedReader: BufferedReader): JSONObject = bufferedReader.use { reader ->
                            JSONObject(
                                    StringBuilder().apply {
                                        while (reader.readLine().let {
                                                    append(it ?: "")
                                                    it != null
                                                }
                                        ) {
                                            append("\n")
                                        }
                                    }.toString()
                            )
                        }

                        fun loadJson(uri: Uri): JSONObject = when ((uri.scheme ?: "").isEmpty()) {
                            true -> loadJson(
                                    getApplication<Application>().assets.open(uri.path!!).run { bufferedReader() }
                            )
                            false -> loadJson(
                                    BufferedReader(
                                            InputStreamReader(
                                                    URL(uri.toString()).openStream()
                                            )
                                    )
                            )
                        }

                        listOf(
                            *loadJson(Uri.parse(inventoryAString)).let { jsonObject ->
                                yield()
                                val list: MutableList<Item> = ArrayList()
                                jsonObject.getJSONArray("assetsURLs").let { inventory ->
                                    for (i in 0 until inventory.length()) {
                                        yield()
                                        inventory.getString(i).let { itemUriAsString ->
                                            // Process each SneakerKit description file
                                            loadJson(Uri.parse(itemUriAsString)).also { jsonObject ->
                                                list.add(
                                                    Item(
                                                        jsonObject.optString("shortShoeDescription"),
                                                        jsonObject.optString("longShoeDescription"),
                                                        jsonObject.optString("sneakerKitReference"),
                                                        try {
                                                            URL(jsonObject.getUri(itemUriAsString, "icon_uri").toString())
                                                                    .openStream().use { BitmapFactory.decodeStream(it) }
                                                        } catch (e: Exception) {
                                                            Log.d(tag("getInventory"), "Failed to find icon for $itemUriAsString: $e")
                                                            null
                                                        },
                                                        listOf(
                                                            Item.Part(
                                                                VykingTrackerJNI.TrackingData.DetectedObjectType.LEFT_FOOT,
                                                                "footLeft",
                                                                coroutineScope.async(Dispatchers.IO, CoroutineStart.LAZY) {
                                                                    parser.extractAccessorySources(
                                                                        "footLeft",
                                                                        jsonObject,
                                                                        Uri.parse(itemUriAsString)
                                                                    )
                                                                }
                                                            ),
                                                            Item.Part(
                                                                VykingTrackerJNI.TrackingData.DetectedObjectType.RIGHT_FOOT,
                                                                "footRight",
                                                                coroutineScope.async(Dispatchers.IO, CoroutineStart.LAZY) {
                                                                    parser.extractAccessorySources(
                                                                        "footRight",
                                                                        jsonObject,
                                                                        Uri.parse(itemUriAsString)
                                                                    )
                                                                }
                                                            )
                                                        )
                                                    )
                                                )
                                            }
                                        }
                                    }
                                }
                                list
                            }.toTypedArray()
                        )
                    })
                } catch (cause: Throwable) {
                    Log.e(tag("loadInventory"), "Exception $cause")
                    error.postValue("Failed to load complete inventory (${cause.message ?: cause})")

                    cause.printStackTrace()
                } finally {
                    inventoryIsLoading.postValue(false)
                }
            }
        }
    }

    override fun onSharedPreferenceChanged(sharedPreferences: SharedPreferences?, key: String?) {
        sharedPreferences?.apply {
            getString(
                    getApplication<Application>().resources.getString(  R.string.setting_vykingAccessoriesInventoryUri_key),
                    getApplication<Application>().resources.getString(R.string.setting_vykingAccessoriesInventoryUri_defaultValue)
            )?.let { loadInventoryAsync(it) }
        }
    }

    override fun onCleared() {
        Log.d(tag("onCleared"), "()")

        // loadInventoryJob runs using Dispatchers.IO, so we are ok to block the main thread
        // here without risk of a deadlock
        runBlocking {
            loadInventorySupervisoryJob.cancelAndJoin()
        }
    }

    private companion object {
        private fun JSONObject.getUri(parentUri: String, name: String): Uri =
                Uri.parse(getString(name)).let { uri ->
                    val uriSplitter = Pattern.compile("(.+/)(.+)")
                    uriSplitter.matcher(parentUri).let {
                        when (it.matches() && uri.isRelative) {
                            true -> Uri.parse((it.group(1) ?: "") + uri)
                            false -> uri
                        }
                    }
                }
    }
}