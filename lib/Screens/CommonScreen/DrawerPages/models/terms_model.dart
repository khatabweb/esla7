class TermsModel {
  String? status;
  int? id;
  String? termsAr;
  String? termsEn;

  TermsModel({
    this.status,
    this.id,
    this.termsAr,
    this.termsEn,
  });
  TermsModel.fromJson(Map<String, dynamic> json) {
    status = json["status"]?.toString();
    id = json["id"]?.toInt();
    termsAr = json["terms_ar"]?.toString();
    termsEn = json["terms_en"]?.toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["status"] = status;
    data["id"] = id;
    data["terms_ar"] = termsAr;
    data["terms_en"] = termsEn;
    return data;
  }
}
