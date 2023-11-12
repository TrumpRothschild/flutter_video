package com.taobao.power_image_example.glide;


import android.util.Log;

import com.bumptech.glide.Priority;
import com.bumptech.glide.load.DataSource;
import com.bumptech.glide.load.Options;
import com.bumptech.glide.load.data.DataFetcher;
import com.bumptech.glide.load.model.ModelLoader;
import com.bumptech.glide.load.model.ModelLoaderFactory;
import com.bumptech.glide.load.model.MultiModelLoaderFactory;
import com.bumptech.glide.signature.ObjectKey;
import java.nio.ByteBuffer;

public class Base64ModelLoader implements ModelLoader<Base64File, ByteBuffer> {

    private static final String TAG="mylog_DptModelLoader";

    @Override
    public LoadData<ByteBuffer> buildLoadData( Base64File base64File, int width, int height,  Options options) {
        Log.i(TAG,"biden：-------> 开始加载bae64  "+base64File.getFile().getAbsolutePath());
        return new LoadData<ByteBuffer>(new ObjectKey(base64File),new DPtDataFetcher(base64File));
    }

    @Override
    public boolean handles( Base64File base64File) {
        return true;
    }

    public static class Base64LoaderFactory implements ModelLoaderFactory<Base64File, ByteBuffer> {

        
        @Override
        public ModelLoader<Base64File, ByteBuffer> build( MultiModelLoaderFactory multiFactory) {
            return new Base64ModelLoader();
        }

        @Override
        public void teardown() {
        }
    }

    public static class DPtDataFetcher implements DataFetcher<ByteBuffer> {
        private Base64File file;

        public DPtDataFetcher(Base64File file) {
            this.file = file;
        }

        @Override
        public void loadData( Priority priority,  DataCallback<? super ByteBuffer> callback) {
            if (file==null){
                return;
            }
            //读取文件流，直接把文件流AES解密
            callback.onDataReady(CXAESUtil.decryptBase64ToInputStream(file.getFile()));
        }
        /** 这里是用来释放IO流的*/
        @Override
        public void cleanup() {

        }

        @Override
        public void cancel() {

        }

        @Override
        public Class<ByteBuffer> getDataClass() {
            return ByteBuffer.class;
        }

        @Override
        public DataSource getDataSource() {
            return DataSource.LOCAL;
        }
    }

}