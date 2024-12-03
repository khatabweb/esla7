class ServiceTypeModel {
  String? message;
  List<Services?>? services;

  ServiceTypeModel({
    this.message,
    this.services,
  });
  ServiceTypeModel.fromJson(Map<String, dynamic> json) {
    message = json["message"]?.toString();
    if (json["services"] != null) {
      final v = json["services"];
      final arr0 = <Services>[];
      v.forEach((v) {
        arr0.add(Services.fromJson(v));
      });
      services = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["message"] = message;
    if (services != null) {
      final v = services;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data["services"] = arr0;
    }
    return data;
  }
}


class Services {
  int? id;
  String? nameAr;
  String? nameEn;
  String? image;

  Services({
    this.id,
    this.nameAr,
    this.nameEn,
    this.image,
  });
  Services.fromJson(Map<String, dynamic> json) {
    id = json["id"]?.toInt();
    nameAr = json["name_ar"]?.toString();
    nameEn = json["name_en"]?.toString();
    image = json["image"]?.toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;
    data["name_ar"] = nameAr;
    data["name_en"] = nameEn;
    data["image"] = image;
    return data;
  }
}