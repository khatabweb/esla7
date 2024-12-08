class AdFeaturesTermsModel {
  String? status;
  int? id;
  String? propagandasAr;
  String? propagandasEn;

  AdFeaturesTermsModel({
    this.status,
    this.id,
    this.propagandasAr,
    this.propagandasEn,
  });
  AdFeaturesTermsModel.fromJson(Map<String, dynamic> json) {
    status = json["status"]?.toString();
    id = json["id"]?.toInt();
    propagandasAr = json["propagandas_ar"]?.toString();
    propagandasEn = json["propagandas_en"]?.toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["status"] = status;
    data["id"] = id;
    data["propagandas_ar"] = propagandasAr;
    data["propagandas_en"] = propagandasEn;
    return data;
  }
}
