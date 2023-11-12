package com.taobao.power_image_example.glide;


import java.io.File;
import java.io.IOException;

import okhttp3.Call;
import okhttp3.Callback;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;
import okio.BufferedSink;
import okio.Okio;
import okio.Sink;

public class DptDownload {

    /**
     * 下载文件
     * @param url      文件网络路径
     * @param fileDir 文件下载本地路径(肯定是存储在的)
     * @param fileName 文件名称（包含后缀）
     * @param callBack 回调
     */
    public static void okHttpDownloadFile(String url, String fileDir, String fileName, final CallBackDownloadFile callBack) {
        final File incompleteFile = new File(fileDir, fileName);
        final File completeFile = new File(fileDir, fileName);
        if (!incompleteFile.exists()) {
            try {
                incompleteFile.createNewFile();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        Request request = new Request.Builder().url(url).build();
        new OkHttpClient().newCall(request).enqueue(new Callback() {
            @Override
            public void onFailure( Call call,  IOException e) {
                incompleteFile.delete();
                callBack.onFailure(e);
            }

            @Override
            public void onResponse( Call call,  Response response) throws IOException {
                Sink sink = Okio.sink(incompleteFile);
                BufferedSink bufferedSink = Okio.buffer(sink);
                bufferedSink.writeAll(response.body().source());
                bufferedSink.close();
                incompleteFile.renameTo(completeFile);
                if (bufferedSink != null) {
                    bufferedSink.close();
                }
//                callBack.onDownloadOk(response.body().string());
                callBack.onDownloadOk(completeFile.getAbsolutePath());
            }
        });
    }

    public interface CallBackDownloadFile{
        void onDownloadOk(String str);
        void onFailure(IOException e);
    }

}