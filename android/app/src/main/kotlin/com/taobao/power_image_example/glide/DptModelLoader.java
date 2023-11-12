package com.taobao.power_image_example.glide;


import com.bumptech.glide.Priority;
import com.bumptech.glide.load.DataSource;
import com.bumptech.glide.load.Options;
import com.bumptech.glide.load.data.DataFetcher;
import com.bumptech.glide.load.model.ModelLoader;
import com.bumptech.glide.load.model.ModelLoaderFactory;
import com.bumptech.glide.load.model.MultiModelLoaderFactory;
import com.bumptech.glide.signature.ObjectKey;

import java.io.InputStream;

public class DptModelLoader implements ModelLoader<MyDptFile, InputStream> {

    private static final String TAG="mylog_DptModelLoader";

    @Override
    public LoadData<InputStream> buildLoadData(MyDptFile myDptFile, int width, int height, Options options) {
//        Log.i(TAG,"buildLoadData："+myDptFile.getFile().getAbsolutePath());
        return new LoadData<InputStream>(new ObjectKey(myDptFile),new DPtDataFetcher(myDptFile));
    }

    @Override
    public boolean handles( MyDptFile myDptFile) {
        return true;
    }

    public static class DptLoaderFactory implements ModelLoaderFactory<MyDptFile, InputStream> {

        
        @Override
        public ModelLoader<MyDptFile, InputStream> build(MultiModelLoaderFactory multiFactory) {
            return new DptModelLoader();
        }

        @Override
        public void teardown() {
        }
    }

    public static class DPtDataFetcher implements DataFetcher<InputStream> {
        private MyDptFile file;

        public DPtDataFetcher(MyDptFile file) {
            this.file = file;
        }

        @Override
        public void loadData( Priority priority,  DataCallback<? super InputStream> callback) {
//            Log.i(TAG,"图片解密--1, file= "+file.getFile().getAbsolutePath());
            if (file==null){
                return;
            }
            //读取文件流，直接把文件流AES解密
            callback.onDataReady(CXAESUtil.decryptFileToInputStream(file.getFile()));
        }
        /** 这里是用来释放IO流的*/
        @Override
        public void cleanup() {

        }

        @Override
        public void cancel() {

        }

        @Override
        public Class<InputStream> getDataClass() {
            return InputStream.class;
        }

        @Override
        public DataSource getDataSource() {
            return DataSource.LOCAL;
        }
    }

}