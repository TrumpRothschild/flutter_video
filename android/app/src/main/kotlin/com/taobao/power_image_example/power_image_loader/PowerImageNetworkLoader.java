package com.taobao.power_image_example.power_image_loader;
import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.drawable.BitmapDrawable;
import android.graphics.drawable.Drawable;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import  com.taobao.power_image.loader.PowerImageLoaderProtocol;
import com.bumptech.glide.Glide;
import com.bumptech.glide.load.DataSource;
import com.bumptech.glide.load.Transformation;
import com.bumptech.glide.load.engine.GlideException;
import com.bumptech.glide.load.engine.Resource;
import com.bumptech.glide.load.resource.gif.GifDrawable;
import com.bumptech.glide.request.RequestListener;
import com.bumptech.glide.request.target.CustomTarget;
import com.bumptech.glide.request.target.SimpleTarget;
import com.bumptech.glide.request.target.Target;
import com.bumptech.glide.request.transition.Transition;
import com.taobao.power_image_example.GlideMultiFrameImage;
import com.taobao.power_image_example.glide.Base64File;
import com.taobao.power_image_example.glide.DptLoadImage;
import com.taobao.power_image_example.glide.MyDptFile;
import com.taobao.power_image.request.*;
import com.taobao.power_image.loader.*;
import java.security.MessageDigest;
import java.io.File;
/**
 * created by Muke on 2021/7/25
 */

public class PowerImageNetworkLoader implements PowerImageLoaderProtocol {
    boolean isAes (String imgUrl){
        return (imgUrl.contains(".w."));
    };


    private Context context;
    DptLoadImage dptLoadImage;
    public PowerImageNetworkLoader(Context context) {
        this.context = context;
        dptLoadImage = new DptLoadImage(context);
    }

    @Override
    public void handleRequest(PowerImageRequestConfig request, PowerImageResponse response) {
        Log.i("biden", "handleRequest:请求  1 "+request.srcString());
        dptLoadImage.load(context, request.srcString(), new DptLoadImage.DownloadInterface() {
            @Override
            public void downSucess(File file) {
                Log.i("biden", "handleRequest:下载成功 : "+file.getAbsolutePath());
             }

            @Override
            public void loadSucess(File file) {
                Glide.with(context).asDrawable().load(file).listener(new RequestListener<Drawable>() {
                    @Override
                    public boolean onLoadFailed(@Nullable GlideException e, Object model, Target<Drawable> target, boolean isFirstResource) {
                        Log.i("biden", "加载失败  url:  "+request.srcString()+ "  message:   "+e.getMessage());
                        response.onResult(PowerImageResult.genFailRet("Native加载失败: " + (e != null ? e.getMessage() : "null")));
                        return true;
                    }
                    @Override
                    public boolean onResourceReady(Drawable resource, Object model, Target<Drawable> target, DataSource dataSource, boolean isFirstResource) {
                        Log.i("biden", "glide加载成功,传递数据 ");
                        if (resource instanceof GifDrawable) {
                            response.onResult(PowerImageResult.genSucRet(new GlideMultiFrameImage((GifDrawable) resource, false)));
                        } else {
                            if (resource instanceof BitmapDrawable) {
                                response.onResult(PowerImageResult.genSucRet(new FlutterSingleFrameImage((BitmapDrawable) resource)));
                            } else {
                                response.onResult(PowerImageResult.genFailRet("Native加载失败:  resource : " + String.valueOf(resource)));
                            }
                        }
                        return true;
                    }
                }).submit(request.width <= 0 ? Target.SIZE_ORIGINAL : request.width,
                        request.height <= 0 ? Target.SIZE_ORIGINAL : request.height);
            }

            @Override
            public void onFail() {
                Log.i("biden", "加载失败3 路径 :  "+request.srcString());
//                response.onResult(PowerImageResult.genFailRet("Native加载失败: " + (e != null ? e.getMessage() : "null")));
            }
        });
    }
}
