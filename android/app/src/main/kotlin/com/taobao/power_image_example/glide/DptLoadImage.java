package com.taobao.power_image_example.glide;


import android.content.Context;
import android.os.Handler;
import android.os.Looper;
import android.text.TextUtils;
import android.util.Log;
import android.widget.ImageView;

import com.bumptech.glide.Glide;

import java.io.File;
import java.io.IOException;

public class DptLoadImage {
    boolean isAes(String imgUrl) {
        return (imgUrl.contains(".w"));
    }

    boolean isBase64(String imgUrl) {
        return (imgUrl.contains(".ced"));
    }

    ;

    boolean isXor(String imgUrl) {
        return (imgUrl.contains(".p."));
    }

    ;
    private final String TAG = "mylog_DptLoadImage";
    /**
     * 缓存文件夹的名称，清除缓存时可以指定这个文件夹
     */
    private final String DPT_CACHE_DIR = "dpcache";
    private File dptFileCacheDir;

    public interface DownloadInterface {
        void downSucess(File file);

        void loadSucess(File file);

        void onFail();
    }

    public DptLoadImage(Context context) {
        initDir(context);
    }

    private void initDir(Context context) {
        String externalCacheDirPath = context.getExternalCacheDir().getAbsolutePath();
        dptFileCacheDir = new File(externalCacheDirPath + File.separator + DPT_CACHE_DIR);
        if (!dptFileCacheDir.exists()) {
            Log.i(TAG, "不存在缓存文件夹，进行创建");
            dptFileCacheDir.mkdir();
        }
    }

    public String getEncodePath(String imgUrl) {
        String fileNameUrl = imgUrl;
        if (imgUrl.contains("?auth_key=")) {
            fileNameUrl = imgUrl.split("/?auth_key=")[0];
        }
        Log.i(TAG, "load: fileNameUrl  截取之后" + fileNameUrl);
        String fileName = null;
        try {
            fileName = CXAESUtil.encrypt(CXAESUtil.AES_KEY, fileNameUrl);
        } catch (Exception e) {
            e.printStackTrace();
        }
        Log.i(TAG, "load: fileName  " + fileName);
        if (fileName.length() > 15) {
            fileName = fileName.substring(fileName.length() - 15);
            Log.i(TAG, "load: 截取 fileName  " + fileName);
        }
        if (imgUrl.contains(".ced")) {
            fileName += ".ced";
        } else if (imgUrl.contains(".w.")) {
            fileName += ".w.";
        }
        return fileName;
    }

    public void load(Context context, String imgUrl, final DownloadInterface downloadInterface) {
        if (TextUtils.isEmpty(imgUrl)) {
            return;
        }
        String fileName = getEncodePath(imgUrl);
        //判断解密之后的本地文件是否存在
        File bitmapFile = new File(dptFileCacheDir, fileName + ".jpg");
        try {
            Log.i("biden", "解密之后的路径 : " + bitmapFile.getAbsolutePath());
            if (bitmapFile.exists()) {
                Log.i("biden", "路径 : " + bitmapFile.getAbsolutePath() + "  路径存在 直接加载");
                //文件存在，直接加载文件，不用网络下载，直接进行解密成文件流
                if (downloadInterface != null) {
                    downloadInterface.loadSucess(bitmapFile);
                    return;
                }
            }
        } catch (Exception e) {
            Log.i(TAG, "load: 加载原始图片失败  " + e.getMessage());
        }

        DptDownload.okHttpDownloadFile(imgUrl, dptFileCacheDir.getAbsolutePath(), fileName, new DptDownload.CallBackDownloadFile() {
            @Override
            public void onDownloadOk(final String str) {
                Log.i("biden", "路径 : " + str + "  下载成功");
                if (isAes(imgUrl)) {
                    CXAESUtil.decryptFile(new File(str), bitmapFile.getAbsolutePath(), CXAESUtil.AES_KEY);
                } else if (isBase64(imgUrl)) {
                    CXAESUtil.base64File(new File(str), bitmapFile.getAbsolutePath());
                }
                if (downloadInterface != null) {
                    downloadInterface.loadSucess(bitmapFile);
                }
            }

            @Override
            public void onFailure(IOException e) {
                if (downloadInterface != null) {
                    downloadInterface.onFail();
                }

            }
        });

    }

    public void load(String imgUrl, final ImageView imageView) {
        final Context context = imageView.getContext();
        String externalCacheDirPath = context.getExternalCacheDir().getAbsolutePath();
        File dptFileCacheDir = new File(externalCacheDirPath + File.separator + DPT_CACHE_DIR);
        if (!dptFileCacheDir.exists()) {
            Log.i(TAG, "不存在缓存文件夹，进行创建");
            dptFileCacheDir.mkdir();
        }
        //根据图片url获取存储的文件名称，防止地址泄露
        try {
            String fileName = CXAESUtil.encrypt(CXAESUtil.AES_KEY, imgUrl).substring(0, 5);
            //判断这个文件本地是否存在
            File imageFile = new File(dptFileCacheDir, fileName);
            if (imageFile.exists()) {
                //文件存在，直接加载文件，不用网络下载，直接进行解密成文件流
//                Glide.with(context).load(new MyDptFile(imageFile)).placeholder(R.drawable.ic_launcher_background).into(imageView);
            } else {
                DptDownload.okHttpDownloadFile(imgUrl, dptFileCacheDir.getAbsolutePath(), fileName, new DptDownload.CallBackDownloadFile() {
                    @Override
                    public void onDownloadOk(final String str) {
                        Glide.with(context).load(new MyDptFile(new File(str))).into(imageView);
                    }

                    @Override
                    public void onFailure(IOException e) {
                        showErrorImage(imageView);
                    }
                });
            }
        } catch (Exception e) {
            e.printStackTrace();
            showErrorImage(imageView);
        }
    }

    /**
     * 显示错误图片
     */
    private void showErrorImage(ImageView imageView) {
        Handler handler = new Handler(Looper.getMainLooper());
        handler.post(new Runnable() {
            @Override
            public void run() {
//                Glide.with(imageView).load(R.drawable.ic_launcher_background).into(imageView);
            }
        });

    }

    /**
     * 获取缓存存在的路径
     */
    public File getEptCachePath(Context context) {
        String externalCacheDirPath = context.getExternalCacheDir().getAbsolutePath();
        return new File(externalCacheDirPath + File.separator + DPT_CACHE_DIR);
    }

}