/*
import 'package:permission_handler/permission_handler.dart';

class PermissionHandler {
  PermissionHandler._();

static Future<PermissionStatus> requestCameraPermission() async {

    final serviceStatus = await Permission.camera.isGranted ;

    bool isCameraOn = serviceStatus == ServiceStatus.enabled;

    final status = await Permission.camera.request();

    if (status == PermissionStatus.granted) {
      print('Permission Granted');
    } else if (status == PermissionStatus.denied) {
      print('Permission denied');
    } else if (status == PermissionStatus.permanentlyDenied) {
      print('Permission Permanently Denied');
      await openAppSettings();
    }
    return status;
  }

  static Future<PermissionStatus> requestGalleryPermission() async {

    final serviceStatus = await Permission.phone.isGranted ;

    bool isCameraOn = serviceStatus == ServiceStatus.enabled;

    final status = await Permission.camera.request();

    if (status == PermissionStatus.granted) {
      print('Permission Granted');
    } else if (status == PermissionStatus.denied) {
      print('Permission denied');
    } else if (status == PermissionStatus.permanentlyDenied) {
      print('Permission Permanently Denied');
      await openAppSettings();
    }
    return status;
  }

  static Future<PermissionStatus> checkGalleryPermission() async {
    var status = await Permission.phone.status;
    if (status.isGranted) {
    } else {
      openAppSettings();
    }
    return status;
  }
}
*/
