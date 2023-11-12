import 'package:base/commons/widgets/ol_loading_widget.dart';
import 'package:base/themes/custom_theme.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:services/api/video_apis.dart';
import 'package:services/models/res/base_response.dart';

class PhotoChoiceSheet extends StatelessWidget {
  const PhotoChoiceSheet({
    Key? key,
    required this.customTheme,
  }) : super(key: key);

  final CustomTheme customTheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: customTheme.colors0xFFFFFF,
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () async {
                final ImagePicker _picker = ImagePicker();
                final pickedFile = await _picker.pickImage(
                  source: ImageSource.camera,
                  imageQuality: 80,
                );
                if (pickedFile != null) {
                  _upload(pickedFile);
                }
              },
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 13),
                child: Text(
                  '拍照',
                  style: TextStyle(
                    color: customTheme.colors0x9F44FF,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Divider(
              color: customTheme.colors0xD6D6D6,
            ),
            InkWell(
              onTap: () async {
                final ImagePicker _picker = ImagePicker();
                final pickedFile = await _picker.pickImage(
                  source: ImageSource.gallery,
                  imageQuality: 80,
                );
                if (pickedFile != null) {
                  _upload(pickedFile);
                }
              },
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 13),
                child: Text(
                  '从相册选择',
                  style: TextStyle(
                    color: customTheme.colors0x9F44FF,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Divider(
              color: customTheme.colors0xD6D6D6,
            ),
            InkWell(
              onTap: Get.back,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 13),
                child: Text(
                  '取消',
                  style: TextStyle(
                    color: customTheme.colors0x7D7C7C,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _upload(XFile image) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: image.path,
      maxHeight: 65,
      maxWidth: 65,
      aspectRatio: const CropAspectRatio(ratioX: 65, ratioY: 65),
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: '图片裁剪',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true,
        ),
        IOSUiSettings(
          title: '图片裁剪',
          aspectRatioLockEnabled: true,
          resetAspectRatioEnabled: false,
          aspectRatioPickerButtonHidden: true,
          cancelButtonTitle: '取消',
          doneButtonTitle: '完成',
        ),
      ],
    );
    if (croppedFile == null) return;
    OLEasyLoading.showLoading('');
    String path = croppedFile.path;
    var name = path.substring(path.lastIndexOf("/") + 1, path.length);
    FormData formdata = FormData.fromMap(
        {"file": await MultipartFile.fromFile(path, filename: name)});

    try {
      BaseResponse response = await VideoApis.of.call().uploadPicture(formdata);
      OLEasyLoading.dismiss();
      if (response.code == 200) {
        final filekeyurl = response.data['filekeyurl'];
        Get.back(result: filekeyurl);
      } else {
        OLEasyLoading.showToast(response.msg.toString());
        Get.back();
      }
    } catch (e) {
      OLEasyLoading.dismiss();
      Get.back();
    }
  }
}
