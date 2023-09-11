import 'package:get/get.dart';

enum PlatformDesign {
  cupertino,
  material,
}

extension PlatformStyleExtensions on PlatformDesign {
  bool get isCupertino => this == PlatformDesign.cupertino;
  bool get isMaterial => this == PlatformDesign.material;
}

PlatformDesign getPlatformStyle() {
  if (GetPlatform.isIOS || GetPlatform.isMacOS) {
    return PlatformDesign.cupertino;
  } else {
    return PlatformDesign.material;
  }
}
