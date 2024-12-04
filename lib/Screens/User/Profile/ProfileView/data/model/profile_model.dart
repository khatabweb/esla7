class ProfileModel {
  int? id;
  String? name;
  String? phone;
  String? image;
  String? email;
  int? isVerified;
  int? code;
  String? emailVerifiedAt;
  String? googleToken;
  int? active;
  String? imagePath;

  ProfileModel({
    this.id,
    this.name,
    this.phone,
    this.image,
    this.email,
    this.isVerified,
    this.code,
    this.emailVerifiedAt,
    this.googleToken,
    this.active,
    this.imagePath,
  });
  ProfileModel.fromJson(Map<String, dynamic> json) {
    id = json["id"]?.toInt();
    name = json["name"]?.toString();
    phone = json["phone"]?.toString();
    image = json["image"]?.toString();
    email = json["email"]?.toString();
    isVerified = json["isVerified"]?.toInt();
    code = json["code"]?.toInt();
    emailVerifiedAt = json["email_verified_at"]?.toString();
    googleToken = json["google_token"]?.toString();
    active = json["active"]?.toInt();
    imagePath = json["image_path"]?.toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;
    data["name"] = name;
    data["phone"] = phone;
    data["image"] = image;
    data["email"] = email;
    data["isVerified"] = isVerified;
    data["code"] = code;
    data["email_verified_at"] = emailVerifiedAt;
    data["google_token"] = googleToken;
    data["active"] = active;
    data["image_path"] = imagePath;
    return data;
  }
}
