package com.taobao.power_image_example.glide;


import android.content.Context;

import com.bumptech.glide.Glide;
import com.bumptech.glide.Registry;
import com.bumptech.glide.annotation.GlideModule;
import com.bumptech.glide.module.AppGlideModule;

import java.io.InputStream;
import java.nio.ByteBuffer;

@GlideModule
public class MyGlideModule extends AppGlideModule {

    @Override
    public void registerComponents( Context context,  Glide glide,  Registry registry) {
        super.registerComponents(context, glide, registry);
        //这是关键
        registry.append(MyDptFile.class, InputStream.class,new DptModelLoader.DptLoaderFactory());
        registry.append(Base64File.class, ByteBuffer.class,new Base64ModelLoader.Base64LoaderFactory());
    }

    /**
     * 这里不开启，避免添加相同的modules两次
     * @return
     */
    @Override
    public boolean isManifestParsingEnabled() {
        return false;
    }
}