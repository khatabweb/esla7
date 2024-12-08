class OwnerDetailsModel {
  String? status;
  int? ownerId;
  String? ownerImage;
  String? ownerName;
  String? ownerPhone;
  OwnerService? ownerService;
  OwnerCity? ownerCity;
  String? avilableFrom;
  String? avilableTo;
  String? minSalary;
  int? rate;

  OwnerDetailsModel({
    this.status,
    this.ownerId,
    this.ownerImage,
    this.ownerName,
    this.ownerPhone,
    this.ownerService,
    this.ownerCity,
    this.avilableFrom,
    this.avilableTo,
    this.minSalary,
    this.rate,
  });
  OwnerDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json["status"]?.toString();
    ownerId = json["owner_id"]?.toInt();
    ownerImage = json["owner_image"]?.toString();
    ownerName = json["owner_name"]?.toString();
    ownerPhone = json["owner_phone"]?.toString();
    ownerService = (json["owner_service"] != null) ? OwnerService.fromJson(json["owner_service"]) : null;
    ownerCity = (json["owner_city"] != null) ? OwnerCity.fromJson(json["owner_city"]) : null;
    avilableFrom = json["avilable_from"]?.toString();
    avilableTo = json["avilable_to"]?.toString();
    minSalary = json["min_salary"]?.toString();
    rate = json["rate"]?.toInt();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["status"] = status;
    data["owner_id"] = ownerId;
    data["owner_image"] = ownerImage;
    data["owner_name"] = ownerName;
    data["owner_phone"] = ownerPhone;
    if (ownerService != null) {
      data["owner_service"] = ownerService!.toJson();
    }
    if (ownerCity != null) {
      data["owner_city"] = ownerCity!.toJson();
    }
    data["avilable_from"] = avilableFrom;
    data["avilable_to"] = avilableTo;
    data["min_salary"] = minSalary;
    data["rate"] = rate;
    return data;
  }
}


class OwnerService {
  int? id;
  String? nameAr;
  String? nameEn;

  OwnerService({
    this.id,
    this.nameAr,
    this.nameEn,
  });
  OwnerService.fromJson(Map<String, dynamic> json) {
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



class OwnerCity {
  int? id;
  String? nameAr;
  String? nameEn;

  OwnerCity({
    this.id,
    this.nameAr,
    this.nameEn,
  });
  OwnerCity.fromJson(Map<String, dynamic> json) {
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


