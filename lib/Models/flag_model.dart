class FlagModel {
  final String? image;
  final String? name;
  final String? languageCode;
  bool isSelected;

  FlagModel({
    this.image,
    this.name,
    this.isSelected = false,
    this.languageCode,
  });
}
