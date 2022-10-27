import 'dart:io';

import 'package:app/common/services/NavigationService.dart';
import 'package:app/screens/notifications/notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:images_picker/images_picker.dart';
import '../../screens/filters/filters.dart';

class CommonMethods {
  static GetIt? _locator;
  final ImagePicker _picker = ImagePicker();

  static Future<GetIt> get _instance async => _locator ??= GetIt.instance;

  static Future<GetIt> init() async {
    _locator = await _instance;
    return _locator!;
  }

  static BuildContext currentContext() => _locator!<NavigationService>().navigatorKey.currentContext!;

  static double deviceHeight() => MediaQuery.of(currentContext()).size.height;

  static double deviceWidth() => MediaQuery.of(currentContext()).size.width;

  openFilters(BuildContext context) {
    Navigator.of(context, rootNavigator: false).push(CupertinoPageRoute(builder: (context) => const ApplyFilters()));
  }

  openNotifications(BuildContext context) {
    Navigator.of(context, rootNavigator: false).push(CupertinoPageRoute(builder: (context) => const Notifications()));
  }

  Future<File?> showAlertDialog(BuildContext context, {int imageQuality = 85}) async {
    File? selectedImage;
    await showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
              title: const Text("Upload Image!"),
              content: const Text("Where do you want to select the image?"),
              actions: <Widget>[
                CupertinoDialogAction(
                    isDefaultAction: true,
                    onPressed: () async {
                      selectedImage = await pickOrCaptureImage(false, imageQuality: imageQuality);

                      /*var status = await PermissionHandler.requestGalleryPermission();
                      if (status.isGranted) {
                        selectedImage = await pickOrCaptureImage(false, imageQuality: imageQuality);
                        print(selectedImage);
                      } else {
                        openAppSettings();
                      }*/
                      Navigator.pop(context);
                    },
                    child: const Text("Gallery")),
                CupertinoDialogAction(
                    textStyle: const TextStyle(color: Colors.red),
                    isDefaultAction: true,
                    onPressed: () async {
                      selectedImage = await pickOrCaptureImage(true, imageQuality: imageQuality);
/*

                      var status = await PermissionHandler.requestCameraPermission();
                      if (status.isGranted) {
                      } else {
                        openAppSettings();
                      }
*/

                      Navigator.pop(context);
                    },
                    child: const Text("Camera")),
              ],
            ));
    return selectedImage;
  }

  Future<File?> pickOrCaptureImage(bool isCamera, {int imageQuality = 85}) async {
    // Pick an image
    if (!isCamera) {
      var image = await ImagesPicker.pick(pickType: PickType.image,
      count: 1,
      maxSize: imageQuality); /*_picker.getImage(source: ImageSource.gallery, imageQuality: imageQuality);*/
      return File(image!.first.path);
    }
    // Capture a photo
    if (isCamera) {
      var photo = await ImagesPicker.openCamera(pickType: PickType.image,maxSize: imageQuality) /*_picker.getImage(source: ImageSource.camera)*/;
      return File(photo!.first.path);
    }
    return null;
  }

  showToast({required BuildContext context, String? message}) {
    return Fluttertoast.showToast(
        msg: message!, toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.TOP, timeInSecForIosWeb: 1, backgroundColor: Colors.red, textColor: Colors.white, fontSize: 16.0);
  }
}
