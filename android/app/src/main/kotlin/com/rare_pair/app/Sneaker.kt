package com.rare_pair.app

import io.vyking.vykingtracker.VykingAccessorySource
import io.vyking.vykingtracker.VykingTrackerJNI
import kotlinx.coroutines.Deferred

data class Sneaker(
        val shortShoeDescription: String,
        val longShoeDescription: String,
        val sneakerKitReference: String,
        val parts: List<Part>
) {
    data class Part(
            val type: VykingTrackerJNI.TrackingData.DetectedObjectType,
            val name: String,
            val deferredSources: Deferred<List<VykingAccessorySource>>
    )
}