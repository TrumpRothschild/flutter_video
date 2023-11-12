#import "CommonAesPlugin.h"
#import <CommonCrypto/CommonCryptor.h>
#import <Foundation/Foundation.h>

@implementation CommonAesPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"common_aes"
            binaryMessenger:[registrar messenger]];
  CommonAesPlugin* instance = [[CommonAesPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

NSString const *kInitVector2 = @"4e92604801cc4d11";
size_t const kKeySize2 = kCCKeySizeAES128;

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  }
  if ([@"encrypt" isEqualToString:call.method]) {

          NSDictionary *argsMap  = call.arguments;
          id input = [argsMap objectForKey:@"input"];
          id key = [argsMap objectForKey:@"key"];

          NSData *contentData = [input dataUsingEncoding:NSUTF8StringEncoding];
          NSData *keyData     = [key     dataUsingEncoding:NSUTF8StringEncoding];
          NSData *encrptedData = [CommonAesPlugin aesEncryptData:contentData keyData:keyData];
          NSString *encode = [encrptedData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];

          result(encode);
      } else if ([@"decrypt" isEqualToString:call.method]) {

           NSDictionary *argsMap  = call.arguments;
          id input = [argsMap objectForKey:@"input"];
          //NSLog(@"obj = %@", input);
          id key = [argsMap objectForKey:@"key"];
          //NSLog(@"obj = %@", key);

           //NSData *contentData = [input dataUsingEncoding:NSUTF8StringEncoding];
          // NSData *keyData     = [key     dataUsingEncoding:NSUTF8StringEncoding];

          NSData *contentData = [[NSData alloc] initWithBase64EncodedString:input options:NSDataBase64DecodingIgnoreUnknownCharacters];
              NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
              if (contentData == nil) {
                  result(@"");
              }

           NSData *decryptedData = [CommonAesPlugin deAesEncryptData:contentData keyData:keyData];
           NSString *encode = [[NSString alloc] initWithData:decryptedData encoding:NSUTF8StringEncoding];
          //NSLog(@"结果=%@",encode);
          result(encode);

      }
   else {
    result(FlutterMethodNotImplemented);
  }
}




+ (NSData *)aesEncryptData:(NSData *)contentData keyData:(NSData *)keyData {

    NSCParameterAssert(contentData);
    NSCParameterAssert(keyData);

    NSString *hint = [NSString stringWithFormat:@"The key size of AES-%lu should be %lu bytes!", kKeySize2 * 8, kKeySize2];
    NSCAssert(keyData.length == kKeySize2, hint);
    return [self cipherOperationWithcontenDate:contentData key:keyData operation:kCCEncrypt];
}


+ (NSData *)deAesEncryptData:(NSData *)contentData keyData:(NSData *)keyData {

    NSCParameterAssert(contentData);
    NSCParameterAssert(keyData);
    NSString *hint = [NSString stringWithFormat:@"The key size of AES-%lu should be %lu bytes!", kKeySize2 * 8, kKeySize2];
    NSCAssert(keyData.length == kKeySize2, hint);
    return [self cipherOperationWithcontenDate:contentData key:keyData operation:kCCDecrypt];
}



+ (NSData *)cipherOperationWithcontenDate:(NSData *)contentData key:(NSData *)keyData operation:(CCOperation)operation {

    NSUInteger dataLength = contentData.length;
    void const *initVectorBytes = nil;
//    void const *initVectorBytes = [kInitVector2 dataUsingEncoding:NSUTF8StringEncoding].bytes;
    void const *contentBytes = contentData.bytes;
    void const *keyBytes = keyData.bytes;


    size_t operationSize = dataLength + kCCBlockSizeAES128;
    void *operationBytes = malloc(operationSize);
    if (operationBytes == NULL) {
        return nil;
    }
    size_t actualOutSize = 0;

    CCCryptorStatus cryptStatus = CCCrypt(operation,    //加密/解密方式
                                          0,            //加密算法 0:aes
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,  //补码方式，以及是否选择ECB模式，默认是CBC模式

                                          keyBytes,   //传入的密钥，经过从cstring utf8转成字节类型
                                          kKeySize2,  //真正决定密钥长度
                                          initVectorBytes, //iv 初始化向量值 CBC模式下需要，不传默认16位0，ECB不需要
                                          contentBytes,   // dataIn 要加解密的数据data.bytes
                                          dataLength,     //dataInLength
                                          operationBytes, //dataOut  Result is written here
                                          operationSize,  //dataOutAvailable
                                          &actualOutSize  //dataOutMoved 操作成功之后，被写入dataout的字节长度  所以最后我们根据dataOutMoved从dataout截取我们最后获得的数据
                                          );

    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:operationBytes length:actualOutSize];
    }
    free(operationBytes);
    operationBytes = NULL;
    return nil;
}



@end
