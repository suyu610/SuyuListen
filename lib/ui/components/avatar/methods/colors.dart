import '../enums.dart';

String makeColor(String hex, String maskId) {
  return """
  <g
          id='Color/Palette/Gray-01'
          mask='url(#${maskId})'
          fill-rule='evenodd'
          fill='${hex}'>
          <rect id='pen-Color' x='0' y='0' width='264' height='110' />
        </g>""";
}

String facialHairColor(FacialHairColor color, String maskId) {
  return makeColor(facialHairColorHex(color), maskId);
}

String hairColor(HairColor color, String maskId) {
  return makeColor(hairColorHex(color), maskId);
}

String hatColor(HatColor color, String maskId) {
  return makeColor(hatColorHex(color), maskId);
}

String skinSvg(Skin skin, String maskId) {
  return makeColor(skinColorHex(skin), maskId);
}

clothColor(ClothColor color, String maskId) {
  return makeColor(clothColorHex(color), maskId);
}

// App wide Hex

String facialHairColorHex(FacialHairColor color) {
  switch (color) {
    case FacialHairColor.auburn:
      return "#A55728";
    case FacialHairColor.black:
      return "#2C1B18";
    case FacialHairColor.blonde:
      return "#B58143";
    case FacialHairColor.blondeGolden:
      return "#D6B370";
    case FacialHairColor.brown:
      return "#724133";
    case FacialHairColor.brownDark:
      return "#4A312C";
    case FacialHairColor.platinum:
      return "#ECDCBF";
    case FacialHairColor.red:
      return "#C93305";
    case FacialHairColor.pastelPink:
      return "#F59797";
    default:
      return "";
  }
}

String hairColorHex(HairColor color) {
  switch (color) {
    case HairColor.aurburn:
      return "#A55728";
    case HairColor.black:
      return "#2C1B18";
    case HairColor.blonde:
      return "#B58143";
    case HairColor.blondeGolden:
      return "#D6B370";
    case HairColor.brown:
      return "#724133";
    case HairColor.brownDark:
      return "#4A312C";
    case HairColor.pastelPink:
      return "#F59797";
    case HairColor.platinum:
      return "#ECDCBF";
    case HairColor.red:
      return "#C93305";
    case HairColor.silverGray:
      return "#E8E1E1";
    default:
      return "";
  }
}

String hatColorHex(HatColor color) {
  switch (color) {
    case HatColor.black:
      return "#262E33";
    case HatColor.blue01:
      return "#65C9FF";
    case HatColor.blue02:
      return "#5199E4";
    case HatColor.blue03:
      return "#25557C";
    case HatColor.gray01:
      return "#E6E6E6";
    case HatColor.gray02:
      return "#929598";
    case HatColor.heather:
      return "#3C4F5C";
    case HatColor.pastelblue:
      return "#B1E2FF";
    case HatColor.pastelgreen:
      return "#A7FFC4";
    case HatColor.pastelorange:
      return "#FFDEB5";
    case HatColor.pastelred:
      return "#FFAFB9";
    case HatColor.pastelyellow:
      return "#FFFFB1";
    case HatColor.pink:
      return "#FF488E";
    case HatColor.red:
      return "#FF5C5C";
    case HatColor.white:
      return "#FFFFFF";
    default:
      return "";
  }
}

String skinColorHex(Skin skin) {
  switch (skin) {
    case Skin.tanned:
      return "#FD9841";
    case Skin.yellow:
      return "#F8D25C";
    case Skin.pale:
      return "#FFDBB4";
    case Skin.light:
      return "#EDB98A";
    case Skin.brown:
      return "#D08B5B";
    case Skin.darkBrown:
      return "#AE5D29";
    case Skin.black:
      return "#614335";
    default:
      return "";
  }
}

String clothColorHex(ClothColor color) {
  switch (color) {
    case ClothColor.black:
      return "#262E33";
    case ClothColor.blue1:
      return "#65C9FF";
    case ClothColor.blue2:
      return "#5199E4";
    case ClothColor.blue3:
      return "#25557C";
    case ClothColor.gray1:
      return "#E6E6E6";
    case ClothColor.gray2:
      return "#929598";
    case ClothColor.heather:
      return "#3C4F5C";
    case ClothColor.pastelBlue:
      return "#B1E2FF";
    case ClothColor.pastelGreen:
      return "#A7FFC4";
    case ClothColor.pastelOrange:
      return "#FFDEB5";
    case ClothColor.pastelRed:
      return "#FFAFB9";
    case ClothColor.pastelYellow:
      return "#FFFFB1";
    case ClothColor.pink:
      return "#FF488E";
    case ClothColor.red:
      return "#FF5C5C";
    case ClothColor.white:
      return "#FFFFFF";
    default:
      return "";
  }
}
