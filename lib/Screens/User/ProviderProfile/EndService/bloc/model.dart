class EndListModel {
  String? status;
  List<Services?>? services;

  EndListModel({
    this.status,
    this.services,
  });
  EndListModel.fromJson(Map<String, dynamic> json) {
    status = json["status"]?.toString();
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
    data["status"] = status;
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
  int? price;
  String? descreption;

  Services({
    this.id,
    this.nameAr,
    this.nameEn,
    this.image,
    this.price,
    this.descreption,
  });
  Services.fromJson(Map<String, dynamic> json) {
    id = json["id"]?.toInt();
    nameAr = json["name_ar"]?.toString();
    nameEn = json["name_en"]?.toString();
    image = json["image"]?.toString();
    price = json["price"]?.toInt();
    descreption = json["descreption"]?.toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;
    data["name_ar"] = nameAr;
    data["name_en"] = nameEn;
    data["image"] = image;
    data["price"] = price;
    data["descreption"] = descreption;
    return data;
  }
}