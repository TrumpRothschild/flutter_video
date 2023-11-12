package com.example.flutter_uni_client

 import android.os.Bundle
import android.os.PersistableBundle
import android.util.Log
import com.taobao.power_image_example.power_image_loader.PowerImageFileLoader
import com.taobao.power_image_example.power_image_loader.PowerImageFlutterAssetLoader
import com.taobao.power_image_example.power_image_loader.PowerImageNativeAssetLoader
import com.taobao.power_image_example.power_image_loader.PowerImageNetworkLoader
import com.taobao.power_image.loader.PowerImageLoader
import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        PowerImageLoader.getInstance().registerImageLoader(
            PowerImageNetworkLoader(this.applicationContext), "network"
        )
        PowerImageLoader.getInstance().registerImageLoader(
            PowerImageNativeAssetLoader(this.applicationContext), "nativeAsset"
        )
        PowerImageLoader.getInstance().registerImageLoader(
            PowerImageFlutterAssetLoader(this.applicationContext), "asset"
        )
        PowerImageLoader.getInstance().registerImageLoader(
            PowerImageFileLoader(this.applicationContext), "file"
        )
    }
}
