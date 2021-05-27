package com.rare_pair.app

import android.app.Application
import android.content.Context
import android.content.SharedPreferences
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
//import com.rare_pair.app.R

class SneakerViewModel constructor(
        application: Application
) : AndroidViewModel(application), SharedPreferences.OnSharedPreferenceChangeListener {

    val PREFS_NAME= "RarePairSneakerModel"
    val KEY_URL = "key.urlModel"
    private var currentUrlModel = ""
    lateinit var sharedPreferences: SharedPreferences

    private val tag: (String) -> String = { it -> "${this.javaClass.name}.$it" }

    private val loadInventorySupervisoryJob: CompletableJob by lazy { SupervisorJob() }
    private val parser = VykingDescriptionJsonParser(getApplication())

    private val inventoryIsLoading = MutableLiveData<Boolean>()
    fun getInventory(): LiveData<Sneaker> = sneaker
    private val sneaker: MutableLiveData<Sneaker> by lazy { MutableLiveData<Sneaker>() }
    fun getInventoryIsLoading(): LiveData<Boolean> = inventoryIsLoading
    private val error = MutableLiveData<String>()
    fun getError(): LiveData<String> = error

    init {
        Log.d(tag("init"), "()")
        sharedPreferences = getApplication<Application>().getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE)
        currentUrlModel = getCurrentUrlModel().toString()
        PreferenceManager.getDefaultSharedPreferences(getApplication()).apply {
            getString(
                    currentUrlModel, currentUrlModel
            )?.also {
                loadSneakerAsync(it)
            }
            registerOnSharedPreferenceChangeListener(this@SneakerViewModel)
        }
    }

    private fun getCurrentUrlModel(): String? {
        return sharedPreferences.getString(KEY_URL, "")
    }

    private fun loadSneakerAsync(inventoryAString: String) {
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

        CoroutineScope(loadInventorySupervisoryJob).also { coroutineScope ->
            coroutineScope.launch(Dispatchers.IO) {
                try {
                    inventoryIsLoading.postValue(true)
                    sneaker.postValue(withTimeout(30000) {
                        loadJson(Uri.parse(inventoryAString)).let { jsonObject ->
                            yield()
                            Sneaker(
                                    jsonObject.optString("shortShoeDescription"),
                                    jsonObject.optString("longShoeDescription"),
                                    jsonObject.optString("sneakerKitReference"),
                                    listOf(
                                            Sneaker.Part(
                                                    VykingTrackerJNI.TrackingData.DetectedObjectType.LEFT_FOOT,
                                                    "footLeft",
                                                    coroutineScope.async(Dispatchers.IO, CoroutineStart.LAZY) {
                                                        parser.extractAccessorySources(
                                                                "footLeft",
                                                                jsonObject,
                                                                Uri.parse(inventoryAString)
                                                        )
                                                    }
                                            ),
                                            Sneaker.Part(
                                                    VykingTrackerJNI.TrackingData.DetectedObjectType.RIGHT_FOOT,
                                                    "footRight",
                                                    coroutineScope.async(Dispatchers.IO, CoroutineStart.LAZY) {
                                                        parser.extractAccessorySources(
                                                                "footRight",
                                                                jsonObject,
                                                                Uri.parse(inventoryAString)
                                                        )
                                                    }
                                            )
                                    )
                            )
                        }

                    })
                }
                catch (cause: Throwable) {
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
                    currentUrlModel, currentUrlModel
            )?.let { loadSneakerAsync(it) }
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

