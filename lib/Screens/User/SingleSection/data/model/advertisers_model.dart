class AdvertisersModel {
  String? status;
  List<Advertisers?>? advertisers;

  AdvertisersModel({
    this.status,
    this.advertisers,
  });
  AdvertisersModel.fromJson(Map<String, dynamic> json) {
    status = json["status"]?.toString();
    if (json["advertisers"] != null) {
      final v = json["advertisers"];
      final arr0 = <Advertisers>[];
      v.forEach((v) {
        arr0.add(Advertisers.fromJson(v));
      });
      advertisers = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["status"] = status;
    if (advertisers != null) {
      final v = advertisers;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data["advertisers"] = arr0;
    }
    return data;
  }
}

class Advertisers {
  int? id;
  String? ownerName;
  String? ownerImage;
  String? address;
  AdvertisersService? service;
  AdvertisersCity? city;
  int? rate;

  Advertisers({
    this.id,
    this.ownerName,
    this.ownerImage,
    this.address,
    this.service,
    this.city,
    this.rate,
  });
  Advertisers.fromJson(Map<String, dynamic> json) {
    id = json["id"]?.toInt();
    ownerName = json["owner_name"]?.toString();
    ownerImage = json["owner_image"]?.toString();
    address = json["address"]?.toString();
    service = (json["service"] != null) ? AdvertisersService.fromJson(json["service"]) : null;
    city = (json["city"] != null) ? AdvertisersCity.fromJson(json["city"]) : null;
    rate = json["rate"]?.toInt();
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



class AdvertisersCity {
  int? id;
  String? nameAr;
  String? nameEn;

  AdvertisersCity({
    this.id,
    this.nameAr,
    this.nameEn,
  });
  AdvertisersCity.fromJson(Map<String, dynamic> json) {
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


class AdvertisersService {
  int? id;
  String? nameAr;
  String? nameEn;
  String? image;

  AdvertisersService({
    this.id,
    this.nameAr,
    this.nameEn,
    this.image,
  });
  AdvertisersService.fromJson(Map<String, dynamic> json) {
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


