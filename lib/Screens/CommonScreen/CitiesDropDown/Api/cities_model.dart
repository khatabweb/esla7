class CitiesModel {
  String? status;
  List<Cities?>? cities;

  CitiesModel({
    this.status,
    this.cities,
  });
  CitiesModel.fromJson(Map<String, dynamic> json) {
    status = json["status"]?.toString();
    if (json["cities"] != null) {
      final v = json["cities"];
      final arr0 = <Cities>[];
      v.forEach((v) {
        arr0.add(Cities.fromJson(v));
      });
      cities = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["status"] = status;
    if (cities != null) {
      final v = cities;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data["cities"] = arr0;
    }
    return data;
  }
}

class Cities {
  int? id;
  String? nameAr;
  String? nameEn;

  Cities({
    this.id,
    this.nameAr,
    this.nameEn,
  });
  Cities.fromJson(Map<String, dynamic> json) {
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

