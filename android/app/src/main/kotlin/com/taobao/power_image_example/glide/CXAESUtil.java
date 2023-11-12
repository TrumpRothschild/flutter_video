package com.taobao.power_image_example.glide;

import android.annotation.TargetApi;
import android.os.Build;
import android.util.Base64;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.ByteBuffer;
import java.nio.charset.StandardCharsets;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;

import javax.crypto.Cipher;
import javax.crypto.CipherInputStream;
import javax.crypto.CipherOutputStream;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

public class CXAESUtil {

    public static final String AES_KEY ="qs0fIlSFMMZxOuzD";

    private final static String HEX = "0123456789ABCDEF";
    private static final int keyLenght = 16;
    private static final String defaultV = "0";

    /**
     * 加密
     *
     * @param key
     *            密钥
     * @param src
     *            加密文本
     * @return
     * @throws Exception
     */
    public static String encrypt(String key, String src) throws Exception {
        // /src = Base64.encodeToString(src.getBytes(), Base64.DEFAULT);
        byte[] rawKey = AES_KEY.getBytes();// key.getBytes();
        byte[] result = encrypt(rawKey, src.getBytes("utf-8"));
        // result = Base64.encode(result, Base64.DEFAULT);
        return toHex(result);
    }
    public static String getPath(String key, String src) throws Exception {
        // /src = Base64.encodeToString(src.getBytes(), Base64.DEFAULT);
        byte[] rawKey = AES_KEY.getBytes();// key.getBytes();
        byte[] result = encrypt(rawKey, src.getBytes("utf-8"));
        // result = Base64.encode(result, Base64.DEFAULT);
        return toHex(result);
    }
    /**
     * 加密
     *
     * @param key
     *            密钥
     * @param src
     *            加密文本
     * @return
     * @throws Exception
     */
    public static String encrypt2Java(String key, String src) throws Exception {
        // /src = Base64.encodeToString(src.getBytes(), Base64.DEFAULT);
        byte[] rawKey = AES_KEY.getBytes();// key.getBytes();
        byte[] result = encrypt2Java(rawKey, src.getBytes("utf-8"));
        // result = Base64.encode(result, Base64.DEFAULT);
        return toHex(result);
    }

    /**
     * 解密
     *
     * @param key
     *            密钥
     * @param encrypted
     *            待揭秘文本
     * @return
     * @throws Exception
     */
    public static String decrypt(String key, String encrypted) throws Exception {
        byte[] rawKey = AES_KEY.getBytes();// key.getBytes();
        byte[] enc = toByte(encrypted);
        // enc = Base64.decode(enc, Base64.DEFAULT);
        byte[] result = decrypt(rawKey, enc);
        // /result = Base64.decode(result, Base64.DEFAULT);
        return new String(result, "utf-8");
    }


    private static byte[] encrypt(byte[] key, byte[] src) throws Exception {
        SecretKeySpec skeySpec = new SecretKeySpec(key, "AES");
        Cipher cipher = Cipher.getInstance("AES");
        // TODO: 2021/7/19
//        cipher.init(Cipher.ENCRYPT_MODE, skeySpec, new IvParameterSpec(new byte[cipher.getBlockSize()]));
        cipher.init(Cipher.ENCRYPT_MODE, skeySpec);
        byte[] encrypted = cipher.doFinal(src);
        return encrypted;
    }

    /**
     * 真正的加密过程
     *
     * @param key
     * @param src
     * @return
     * @throws Exception
     */
    private static byte[] encrypt2Java(byte[] key, byte[] src) throws Exception {
        SecretKeySpec skeySpec = new SecretKeySpec(key, "AES");
        Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
        cipher.init(Cipher.ENCRYPT_MODE, skeySpec, new IvParameterSpec(new byte[cipher.getBlockSize()]));
        byte[] encrypted = cipher.doFinal(src);
        return encrypted;
    }
    private static String getBase64SectionOfModel(String model) {
        // See https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/Data_URIs.
        int startOfBase64Section = model.indexOf(',');
        return model.substring(startOfBase64Section + 1);
    }
    //创建cipher对象，
    static Cipher cipher = initAESCipher(CXAESUtil.AES_KEY, Cipher.DECRYPT_MODE);
    @TargetApi(Build.VERSION_CODES.FROYO)
    public static ByteBuffer decryptBase64ToInputStream(File sourceFile ){
        String data = readStream(sourceFile);
        String base64Section = getBase64SectionOfModel(data);
        byte[] dataImg = Base64.decode(base64Section, Base64.DEFAULT);
        ByteBuffer byteBuffer = ByteBuffer.wrap(dataImg);
        return byteBuffer;
    }
    public static String readStream(File file)  {
        FileInputStream fileInputStream = null;
        try {
            fileInputStream = new FileInputStream(file);
            //定义一个内存输出流
            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            int len = -1;
            byte[] buffer = new byte[512]; //1kb
            while((len=fileInputStream.read(buffer))!=-1){
                baos.write(buffer, 0, len);
            }


            String content = new String(baos.toByteArray());
            baos.close();
            fileInputStream.close();
            return content;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    /**
     * 真正的解密过程
     *
     * @param key
     * @param encrypted
     * @return
     * @throws Exception
     */
    private static byte[] decrypt(byte[] key, byte[] encrypted) throws Exception {
        SecretKeySpec skeySpec = new SecretKeySpec(key, "AES");
        Cipher cipher = Cipher.getInstance("AES");
        // TODO: 2021/7/19
//        cipher.init(Cipher.DECRYPT_MODE, skeySpec, new IvParameterSpec(new byte[cipher.getBlockSize()]));
        cipher.init(Cipher.DECRYPT_MODE, skeySpec);
        byte[] decrypted = cipher.doFinal(encrypted);
        return decrypted;
    }

    public static String toHex(String txt) {
        return toHex(txt.getBytes());
    }

    public static String fromHex(String hex) {
        return new String(toByte(hex));
    }


    /**
     * 把16进制转化为字节数组
     * @param hexString
     * @return
     */
    public static byte[] toByte(String hexString) {
        int len = hexString.length() / 2;
        byte[] result = new byte[len];
        for (int i = 0; i < len; i++)
            result[i] = Integer.valueOf(hexString.substring(2 * i, 2 * i + 2), 16).byteValue();
        return result;
    }


    /**
     * 二进制转字符,转成了16进制
     * 0123456789abcdefg
     * @param buf
     * @return
     */
    public static String toHex(byte[] buf) {
        if (buf == null)
            return "";
        StringBuffer result = new StringBuffer(2 * buf.length);
        for (int i = 0; i < buf.length; i++) {
            appendHex(result, buf[i]);
        }
        return result.toString();
    }

    private static void appendHex(StringBuffer sb, byte b) {
        sb.append(HEX.charAt((b >> 4) & 0x0f)).append(HEX.charAt(b & 0x0f));
    }

    /**
     * 初始化 AES Cipher
     * @param sKey
     * @param cipherMode
     * @return
     */
    public static Cipher initAESCipher(String sKey, int cipherMode) {
        // 创建Key gen
        // KeyGenerator keyGenerator = null;
        Cipher cipher = null;
        try {
            /*
             * keyGenerator = KeyGenerator.getInstance("AES");
             * keyGenerator.init(128, new SecureRandom(sKey.getBytes()));
             * SecretKey secretKey = keyGenerator.generateKey(); byte[]
             * codeFormat = secretKey.getEncoded(); SecretKeySpec key = new
             * SecretKeySpec(codeFormat, "AES"); cipher =
             * Cipher.getInstance("AES"); //初始化 cipher.init(cipherMode, key);
             */
            byte[] rawKey = AES_KEY.getBytes();
            SecretKeySpec skeySpec = new SecretKeySpec(rawKey, "AES");
            cipher = Cipher.getInstance("AES");
            // TODO: 2021/7/19
//            cipher.init(cipherMode, skeySpec, new IvParameterSpec(new byte[cipher.getBlockSize()]));
            cipher.init(cipherMode, skeySpec);
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();  // To change body of catch statement use File |
            // Settings | File Templates.
        } catch (NoSuchPaddingException e) {
            e.printStackTrace();  // To change body of catch statement use File |
            // Settings | File Templates.
        } catch (InvalidKeyException e) {
            e.printStackTrace();  // To change body of catch statement use File |
            // Settings | File Templates.
        }
//        catch (InvalidAlgorithmParameterException e) {
//            // TODO Auto-generated catch block
//            e.printStackTrace();
//        }
        return cipher;
    }

    /**
     * 对文件进行AES加密
     * @param sourceFile
     * @param toFilePath 加密到文件的全路径
     * @param sKey
     * @return
     */
    public static File encryptFile(File sourceFile, String toFilePath, String sKey) {
        // 新建临时加密文件
        File encrypfile = null;
        InputStream inputStream = null;
        OutputStream outputStream = null;
        try {
            inputStream = new FileInputStream(sourceFile);
            encrypfile = new File(toFilePath);
            outputStream = new FileOutputStream(encrypfile);
            Cipher cipher = initAESCipher(sKey, Cipher.ENCRYPT_MODE);
            // 以加密流写入文件
            CipherInputStream cipherInputStream = new CipherInputStream(inputStream, cipher);
            byte[] cache = new byte[1024];
            int nRead = 0;
            while ((nRead = cipherInputStream.read(cache)) != -1) {
                outputStream.write(cache, 0, nRead);
                outputStream.flush();
            }
            cipherInputStream.close();
        } catch (FileNotFoundException e) {
            e.printStackTrace();  // To change body of catch statement use File |
            // Settings | File Templates.
        } catch (IOException e) {
            e.printStackTrace();  // To change body of catch statement use File |
            // Settings | File Templates.
        } finally {
            try {
                inputStream.close();
            } catch (IOException e) {
                e.printStackTrace();  // To change body of catch statement use
                // File | Settings | File Templates.
            }
            try {
                outputStream.close();
            } catch (IOException e) {
                e.printStackTrace();  // To change body of catch statement use
                // File | Settings | File Templates.
            }
        }
        return encrypfile;
    }

    public static InputStream decryptFileToInputStream(File sourceFile ){
        InputStream inputStream = null;

        //从源文件中读取，生成输入流
        try {
            inputStream = new FileInputStream(sourceFile);
            //根据输出流创建可以加密的输出流
            CipherInputStream cipherInputStream = new CipherInputStream(inputStream, cipher);
            return cipherInputStream;
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
        return inputStream;
    }
    public static File base64File(File sourceFile, String toFilePath) {
        byte[] dataImg = null;
        String data = null;
        try {
             data = readStream(sourceFile);
            dataImg = Base64.decode(data, Base64.DEFAULT);
        } catch (Exception e) {
            android.util.Log.i("biden", "data:  "+data);
        }
        if (dataImg == null) {
            return null;
        }

        OutputStream outputStream = null;
        try {
            outputStream = new FileOutputStream(toFilePath);
            outputStream.write(dataImg);
        } catch (Exception e) {
            e.printStackTrace();
            try {
                outputStream.close();
            } catch (IOException ex) {
                ex.printStackTrace();
            }
        }
        return new File(toFilePath);
    }
    /**
     * AES方式解密文件
     * @param sourceFile
     * @param toFilePath
     * @return
     */
    public static File decryptFile(File sourceFile, String toFilePath, String sKey) {
        File decryptFile = null;
        InputStream inputStream = null;
        OutputStream outputStream = null;
        try {
            //解密后存放的目标文件
            decryptFile = new File(toFilePath);
            //创建cipher对象，
            Cipher cipher = initAESCipher(sKey, Cipher.DECRYPT_MODE);
            //从源文件中读取，生成输入流
            inputStream = new FileInputStream(sourceFile);
            //从目标文件中获取输出流
            outputStream = new FileOutputStream(decryptFile);
            //根据输出流创建可以加密的输出流
            CipherOutputStream cipherOutputStream = new CipherOutputStream(outputStream, cipher);
            //创建缓存
            byte[] buffer = new byte[1024];
            int r;
            //从输入流读取
            while ((r = inputStream.read(buffer)) >= 0) {
                //写入到输出流中
                cipherOutputStream.write(buffer, 0, r);
            }
            cipherOutputStream.close();
        } catch (IOException e) {
            e.printStackTrace();  // To change body of catch statement use File |
            // Settings | File Templates.
        } finally {
            try {
                inputStream.close();
            } catch (IOException e) {
                e.printStackTrace();  // To change body of catch statement use
                // File | Settings | File Templates.
            }
            try {
                outputStream.close();
            } catch (IOException e) {
                e.printStackTrace();  // To change body of catch statement use
                // File | Settings | File Templates.
            }
        }
        return decryptFile;
    }

}