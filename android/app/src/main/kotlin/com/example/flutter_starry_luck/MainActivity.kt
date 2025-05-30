package com.hxtools.starryluck

import android.os.Bundle
import androidx.lifecycle.lifecycleScope
import com.appsflyerext.ext.FireBaseApp
import io.flutter.embedding.android.FlutterFragmentActivity

class MainActivity : FlutterFragmentActivity() {
    private val app: FireBaseApp = FireBaseApp(this, lifecycleScope)

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        app.onCreate()
    }

    override fun onDestroy() {
        super.onDestroy()
        app.onDestroy()
    }
}
