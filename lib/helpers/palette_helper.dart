import 'dart:ui';

enum AppColorId{
  textTitle("0xFFFAFAFA"),
  textHeadLine("0xFFFAFAFA"),
  textBody("0xFF060A0D"),
  textLabel("0xFF060A0D"),
  textLabelNormal("0xFF2D2D2D"),
  fieldError("0xFFCE6A25"),
  fieldColor("0xFF2D2D2D"),
  decoratedBoxCardNegativeLight("0xFFFFFFFF"),
  primaryColor("0xFF152D44"),
  primaryCardColor("0xFF2D2D2D"),
  selectedField("0xFFFAFAFA"),
  unSelectedField("0xFFFAFAFA");

  const AppColorId(this.value);
  final String value;
}


class PaletteHelper {
  static const double disabledOpacity = 0.45;

  static Color getColor(String colorId) {
    return Color(int.parse(colorId));
  }
}
