class SubServiceModel {
  String? status;
  List<Subservices?>? subservices;

  SubServiceModel({
    this.status,
    this.subservices,
  });
  SubServiceModel.fromJson(Map<String, dynamic> json) {
    status = json["status"]?.toString();
    if (json["subservices"] != null) {
      final v = json["subservices"];
      final arr0 = <Subservices>[];
      v.forEach((v) {
        arr0.add(Subservices.fromJson(v));
      });
      subservices = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["status"] = status;
    if (subservices != null) {
      final v = subservices;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data["subservices"] = arr0;
    }
    return data;
  }
}

class Subservices {
  int? id;
  String? nameAr;
  String? nameEn;

  Subservices({
    this.id,
    this.nameAr,
    this.nameEn,
  });
  Subservices.fromJson(Map<String, dynamic> json) {
    id = json["id"]?.toInt();
    nameAr = json["name_ar"]?.toString();
    nameEn = json["name_en"]?.toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;
    data["name_ar"] = nameAr;
    data["name_en"] = nameEn;
    return data;
  }
}