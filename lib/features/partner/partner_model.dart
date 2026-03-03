class PartnerModel {
  String name;
  List<String> services;
  int experience;
  String? imagePath;

  PartnerModel({
    required this.name,
    required this.services,
    required this.experience,
    this.imagePath,
  });
}