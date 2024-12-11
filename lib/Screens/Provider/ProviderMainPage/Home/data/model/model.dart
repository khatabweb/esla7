class OwnerServiceModel {
  String? status;
  OwnerMainService? ownerMainService;

  OwnerServiceModel({
    this.status,
    this.ownerMainService,
  });
  OwnerServiceModel.fromJson(Map<String, dynamic> json) {
    status = json["status"]?.toString();
    ownerMainService = (json["owner_main_service"] != null) ? OwnerMainService.fromJson(json["owner_main_service"]) : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["status"] = status;
    if (ownerMainService != null) {
      data["owner_main_service"] = ownerMainService!.toJson();
    }
    return data;
  }
}


class OwnerMainService {
  int? id;
  String? image;
  String? nameAr;
  String? nameEn;

  OwnerMainService({
    this.id,
    this.image,
    this.nameAr,
    this.nameEn,
  });
  OwnerMainService.fromJson(Map<String, dynamic> json) {
    id = json["id"]?.toInt();
    image = json["image"]?.toString();
    nameAr = json["name_ar"]?.toString();
    nameEn = json["name_en"]?.toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;
    data["image"] = image;
    data["name_ar"] = nameAr;
    data["name_en"] = nameEn;
    return data;
  }
}

