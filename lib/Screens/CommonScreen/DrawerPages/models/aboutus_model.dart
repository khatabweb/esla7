class AboutusModel {
  String? status;
  int? id;
  String? aboutusesAr;
  String? aboutusesEn;

  AboutusModel({
    this.status,
    this.id,
    this.aboutusesAr,
    this.aboutusesEn,
  });
  AboutusModel.fromJson(Map<String, dynamic> json) {
    status = json["status"]?.toString();
    id = json["id"]?.toInt();
    aboutusesAr = json["aboutuses_ar"]?.toString();
    aboutusesEn = json["aboutuses_en"]?.toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["status"] = status;
    data["id"] = id;
    data["aboutuses_ar"] = aboutusesAr;
    data["aboutuses_en"] = aboutusesEn;
    return data;
  }
}
