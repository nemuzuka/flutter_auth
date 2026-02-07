package com.example.flutter_auth

import android.content.Intent
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {
    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        setIntent(intent) // これにより Flutter 側が新しいインテントを検知できるようになる
    }
}
