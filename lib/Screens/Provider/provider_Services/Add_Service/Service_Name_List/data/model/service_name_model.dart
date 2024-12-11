class ServiceNameModel {
  String? status;
  List<Endservices?>? endservices;

  ServiceNameModel({
    this.status,
    this.endservices,
  });
  ServiceNameModel.fromJson(Map<String, dynamic> json) {
    status = json["status"]?.toString();
    if (json["endservices"] != null) {
      final v = json["endservices"];
      final arr0 = <Endservices>[];
      v.forEach((v) {
        arr0.add(Endservices.fromJson(v));
      });
      endservices = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["status"] = status;
    if (endservices != null) {
      final v = endservices;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data["endservices"] = arr0;
    }
    return data;
  }
}


class Endservices {
  int? id;
  String? nameAr;
  String? nameEn;

  Endservices({
    this.id,
    this.nameAr,
    this.nameEn,
  });
  Endservices.fromJson(Map<String, dynamic> json) {
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
