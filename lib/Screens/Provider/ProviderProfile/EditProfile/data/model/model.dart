class OwnerUpdateModel {
  String? status;
  String? message;
  OwnerUpdateModelData? data;

  OwnerUpdateModel({
    this.status,
    this.message,
    this.data,
  });
  OwnerUpdateModel.fromJson(Map<String, dynamic> json) {
    status = json["status"]?.toString();
    message = json["message"]?.toString();
    data = (json["data"] != null)
        ? OwnerUpdateModelData.fromJson(json["data"])
        : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["status"] = status;
    data["message"] = message;
    data["data"] = this.data!.toJson();
    return data;
  }
}

class OwnerUpdateModelData {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? commerical;
  String? bankName;
  String? bankAccountOwner;
  String? accountNumber;
  int? serviceId;
  int? cityId;
  int? code;
  String? type;
  String? from;
  String? to;
  String? address;
  int? isVerified;
  String? minSalary;
  String? image;
  String? imageOwner;
  String? location;
  int? active;
  String? googleToken;
  String? imagePath;

  OwnerUpdateModelData({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.commerical,
    this.bankName,
    this.bankAccountOwner,
    this.accountNumber,
    this.serviceId,
    this.cityId,
    this.code,
    this.type,
    this.from,
    this.to,
    this.address,
    this.isVerified,
    this.minSalary,
    this.image,
    this.imageOwner,
    this.location,
    this.active,
    this.googleToken,
    this.imagePath,
  });
  OwnerUpdateModelData.fromJson(Map<String, dynamic> json) {
    id = json["id"]?.toInt();
    name = json["name"]?.toString();
    email = json["email"]?.toString();
    phone = json["phone"]?.toString();
    commerical = json["commerical"]?.toString();
    bankName = json["bank_name"]?.toString();
    bankAccountOwner = json["bank_account_owner"]?.toString();
    accountNumber = json["account_number"]?.toString();
    serviceId = json["service_id"]?.toInt();
    cityId = json["city_id"]?.toInt();
    code = json["code"]?.toInt();
    type = json["type"]?.toString();
    from = json["from"]?.toString();
    to = json["to"]?.toString();
    address = json["address"]?.toString();
    isVerified = json["isVerified"]?.toInt();
    minSalary = json["min_salary"]?.toString();
    image = json["image"]?.toString();
    imageOwner = json["image_owner"]?.toString();
    location = json["location"]?.toString();
    active = json["active"]?.toInt();
    googleToken = json["google_token"]?.toString();
    imagePath = json["image_path"]?.toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;
    data["name"] = name;
    data["email"] = email;
    data["phone"] = phone;
    data["commerical"] = commerical;
    data["bank_name"] = bankName;
    data["bank_account_owner"] = bankAccountOwner;
    data["account_number"] = accountNumber;
    data["service_id"] = serviceId;
    data["city_id"] = cityId;
    data["code"] = code;
    data["type"] = type;
    data["from"] = from;
    data["to"] = to;
    data["address"] = address;
    data["isVerified"] = isVerified;
    data["min_salary"] = minSalary;
    data["image"] = image;
    data["image_owner"] = imageOwner;
    data["location"] = location;
    data["active"] = active;
    data["google_token"] = googleToken;
    data["image_path"] = imagePath;
    return data;
  }
}
