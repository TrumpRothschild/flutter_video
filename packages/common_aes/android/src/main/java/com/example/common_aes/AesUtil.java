
package com.example.common_aes;


import android.util.Base64;
import android.util.Log;

import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.spec.SecretKeySpec;

import java.nio.charset.StandardCharsets;


/**
 * ios、安卓、h5、fluter各端端通用加密工具类
 */
public class AesUtil {

    // 加密模式ECB  填充方式PKCS5Padding
    private static final String ALGORITHMSTR = "AES/ECB/PKCS5Padding";

    //data加密
    public static byte[] aesEncryptToBytes(String content, String encryptKey) throws Exception {
        KeyGenerator kgen = KeyGenerator.getInstance("AES");
        kgen.init(128);    //密钥长度 128
        Cipher cipher = Cipher.getInstance(ALGORITHMSTR);
        cipher.init(Cipher.ENCRYPT_MODE, new SecretKeySpec(encryptKey.getBytes(), "AES"));
        return cipher.doFinal(content.getBytes(StandardCharsets.UTF_8));
    }

    //data解密
    public static String aesDecryptByBytes(byte[] encryptBytes, String decryptKey) throws Exception {
        KeyGenerator kgen = KeyGenerator.getInstance("AES");
        kgen.init(128);
        Cipher cipher = Cipher.getInstance(ALGORITHMSTR);
        cipher.init(Cipher.DECRYPT_MODE, new SecretKeySpec(decryptKey.getBytes(), "AES"));
        byte[] decryptBytes = cipher.doFinal(encryptBytes);
        return new String(decryptBytes, StandardCharsets.UTF_8);
    }

    //字节加密
    public static String base64Encode(byte[] input) {
        byte[] encode = Base64.encode(input, Base64.NO_WRAP);
        return new String(encode, StandardCharsets.UTF_8);
    }

    //字节解密
    public static byte[] base64Decode(String base64Code) throws Exception {
        return Base64.decode(base64Code, Base64.NO_WRAP);
    }

    //字符串加密
    public static String aesEncrypt(String content, String encryptKey) {
        try {
            return base64Encode(aesEncryptToBytes(content, encryptKey));
        } catch (Exception e) {
            Log.e("AesUtil", "AES加密失败 ", e);
        }
        return null;
    }

    //字符串解密
    public static String aesDecrypt(String encryptStr, String decryptKey) {
        try {
            return aesDecryptByBytes(base64Decode(encryptStr), decryptKey);
        } catch (Exception e) {
            Log.e("AesUtil", "AES解密密失败 ", e);
        }
        return null;
    }

}
