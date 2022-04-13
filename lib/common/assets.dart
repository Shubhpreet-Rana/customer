enum Assets { logo, splash, splashPng, backImage, fb, google, camera, filters, menu, home, selectedHome, car, selectedCar, calender, selectedCalender, settings }

const String svgDir = "assets/svg";
const String tabsDir = "assets/svg/tabs";
const String pngDir = "assets/png";

extension AssetsName on Assets {
  String get name {
    switch (this) {
      case Assets.logo:
        return "$svgDir/logo.svg";
      case Assets.splash:
        return "$svgDir/splash.svg";
      case Assets.splashPng:
        return "$pngDir/splash.png";
      case Assets.backImage:
        return "$pngDir/back.png";
      case Assets.fb:
        return "$svgDir/fb.svg";
      case Assets.google:
        return "$svgDir/google.svg";
      case Assets.camera:
        return "$svgDir/camera.svg";
      case Assets.filters:
        return "$svgDir/filters.svg";
      case Assets.menu:
        return "$svgDir/menu.svg";
      case Assets.home:
        return "$tabsDir/home1.svg";
      case Assets.selectedHome:
        return "$tabsDir/home.svg";
      case Assets.car:
        return "$tabsDir/car1.svg";
      case Assets.selectedCar:
        return "$tabsDir/car.svg";
      case Assets.calender:
        return "$tabsDir/calender1.svg";
      case Assets.selectedCalender:
        return "$tabsDir/calender.svg";
      case Assets.settings:
        return "$tabsDir/settings1.svg";
      default:
        return "$svgDir/logo.svg";
    }
  }
}
