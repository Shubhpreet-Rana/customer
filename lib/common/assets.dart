enum Assets {
  logo,
  splash,
  splashPng,
  backImage,
  fb,
  google,
  camera
}

const String svgDir = "assets/svg";
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
      default:
        return "$svgDir/logo.svg";
    }
  }
}
