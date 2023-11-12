package com.taobao.power_image_example.glide;

import java.io.File;

public class Base64File {

    private File file;

    public Base64File(File file) {
        this.file = file;
    }

    public File getFile() {
        return file;
    }

    public void setFile(File file) {
        this.file = file;
    }
}