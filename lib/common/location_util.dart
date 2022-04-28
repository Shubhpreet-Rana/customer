import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

class LocationUtil {
  static Future<Position?> getLocation() async {
    if (![LocationPermission.whileInUse, LocationPermission.always].contains(await requestLocationPermission())) return null;
    return await Geolocator.getCurrentPosition();
  }

  static Future<Stream<Position>?> getLocationStream() async {
    if (![LocationPermission.whileInUse, LocationPermission.always].contains(await requestLocationPermission())) return null;

    return Geolocator.getPositionStream();
  }

  static Future<LocationPermission> requestLocationPermission({bool forceAlwaysEnabled = false}) async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (kDebugMode) {
        print('Location !serviceEnabled');
      }
      await Geolocator.openLocationSettings();
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      if (kDebugMode) {
        print('Location deniedForever');
      }
      await Geolocator.openAppSettings();
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      if (kDebugMode) {
        print('Location denied... requesting');
      }
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) return permission;
    }

    if (forceAlwaysEnabled && permission != LocationPermission.always) {
      await Geolocator.openAppSettings();
    }
    permission = await Geolocator.checkPermission();

    return permission;
  }
}
