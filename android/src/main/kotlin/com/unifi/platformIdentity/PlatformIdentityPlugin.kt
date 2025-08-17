package com.unifi.platformIdentity

import android.content.Context
import android.content.pm.PackageManager
import android.util.Base64
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.security.MessageDigest

class PlatformIdentityPlugin : FlutterPlugin, MethodChannel.MethodCallHandler {

    private lateinit var context: Context
    private lateinit var channel: MethodChannel

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        context = binding.applicationContext
        channel = MethodChannel(binding.binaryMessenger, "platform_identity")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "getPlatformVersion" -> {
                result.success(android.os.Build.VERSION.RELEASE)
            }

            "getAppVersion" -> {
                val pm = context.packageManager
                val versionName = pm.getPackageInfo(context.packageName, 0).versionName
                result.success(versionName)
            }

            "getPackageName" -> {
                result.success(context.packageName)
            }

            "getSHA1" -> {
                result.success(getSignatureDigest("SHA1"))
            }

            "getSHA256" -> {
                result.success(getSignatureDigest("SHA-256"))
            }

            else -> {
                result.notImplemented()
            }
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    private fun getSignatureDigest(algorithm: String): String? {
        return try {
            val pm = context.packageManager
            val packageName = context.packageName
            val md = MessageDigest.getInstance(algorithm)

            val digestBytes: ByteArray? =
                if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.P) {
                    val packageInfo =
                        pm.getPackageInfo(packageName, PackageManager.GET_SIGNING_CERTIFICATES)
                    val signingInfo = packageInfo.signingInfo
                    val cert = signingInfo?.apkContentsSigners?.firstOrNull()
                    cert?.toByteArray()
                } else {
                    val packageInfo = pm.getPackageInfo(packageName, PackageManager.GET_SIGNATURES)
                    val signatures = packageInfo.signatures
                    signatures?.firstOrNull()?.toByteArray()
                }

            if (digestBytes == null) return null

            val digest = md.digest(digestBytes)
            Base64.encodeToString(digest, Base64.NO_WRAP)

        } catch (e: Exception) {
            null
        }
    }

}
