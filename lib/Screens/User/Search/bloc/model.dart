class SearchModel {
  String? message;
  List<Owners?>? owners;

  SearchModel({
    this.message,
    this.owners,
  });
  SearchModel.fromJson(Map<String, dynamic> json) {
    message = json["message"]?.toString();
    if (json["owners"] != null) {
      final v = json["owners"];
      final arr0 = <Owners>[];
      v.forEach((v) {
        arr0.add(Owners.fromJson(v));
      });
      owners = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["message"] = message;
    if (owners != null) {
      final v = owners;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data["owners"] = arr0;
    }
    return data;
  }
}

class Owners {
  int? id;
  String? ownerName;
  String? ownerImage;
  String? address;
  OwnersService? service;
  OwnersCity? city;
  double? rate;

  Owners({
    this.id,
    this.ownerName,
    this.ownerImage,
    this.address,
    this.service,
    this.city,
    this.rate,
  });
  Owners.fromJson(Map<String, dynamic> json) {
    id = json["id"]?.toInt();
    ownerName = json["owner_name"]?.toString();
    ownerImage = json["owner_image"]?.toString();
    address = json["address"]?.toString();
    service = (json["service"] != null) ? OwnersService.fromJson(json["service"]) : null;
    city = (json["city"] != null) ? OwnersCity.fromJson(json["city"]) : null;
    rate = json["rate"]?.toDouble();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;
    data["owner_name"] = ownerName;
    data["owner_image"] = ownerImage;
    data["address"] = address;
    if (service != null) {
      data["service"] = service!.toJson();
    }
    if (city != null) {
      data["city"] = city!.toJson();
    }
    data["rate"] = rate;
    return data;
  }
}


class OwnersCity {
  int? id;
  String? nameAr;
  String? nameEn;

  OwnersCity({
    this.id,
    this.nameAr,
    this.nameEn,
  });
  OwnersCity.fromJson(Map<String, dynamic> json) {
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

class OwnersService {
  int? id;
  String? nameAr;
  String? nameEn;
  String? image;
  String? price;
  String? descreption;

  OwnersService({
    this.id,
    this.nameAr,
    this.nameEn,
    this.image,
    this.price,
    this.descreption,
  });
  OwnersService.fromJson(Map<String, dynamic> json) {
    id = json["id"]?.toInt();
    nameAr = json["name_ar"]?.toString();
    nameEn = json["name_en"]?.toString();
    image = json["image"]?.toString();
    price = json["price"]?.toString();
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