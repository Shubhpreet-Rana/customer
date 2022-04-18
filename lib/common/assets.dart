enum Assets {
  logo,
  splash,
  splashPng,
  backImage,
  fb,
  google,
  camera,
  filters,
  menu,
  home,
  selectedHome,
  car,
  selectedCar,
  calender,
  selectedCalender,
  settings,
  banner,
  banner1,
  periodic,
  ac,
  tyre,
  battery,
  service,
  service1,
  blueDot,
  thumb,
  card,
  bank,
}

const String svgDir = "assets/svg";
const String tabsDir = "assets/svg/tabs";
const String pngDir = "assets/png";
const String serviceDir = "assets/png/services";

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
      case Assets.banner:
        return "$pngDir/banner.png";
      case Assets.banner1:
        return "$pngDir/banner1.png";
      case Assets.service:
        return "$serviceDir/service.png";
      case Assets.service1:
        return "$serviceDir/service1.png";
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
      case Assets.periodic:
        return "$svgDir/periodic.svg";
      case Assets.ac:
        return "$svgDir/ac.svg";
      case Assets.tyre:
        return "$svgDir/tyre.svg";
      case Assets.battery:
        return "$svgDir/battery.svg";
      case Assets.blueDot:
        return "$svgDir/ellipse.svg";
      case Assets.thumb:
        return "$svgDir/thumb.svg";
      case Assets.card:
        return "$svgDir/card.svg";
      case Assets.bank:
        return "$svgDir/bank.svg";

      default:
        return "$svgDir/logo.svg";
    }
  }
}
