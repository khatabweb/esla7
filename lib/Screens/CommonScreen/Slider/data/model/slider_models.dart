class SliderModel {
  String? message;
  List<Banners?>? banners;

  SliderModel({
    this.message,
    this.banners,
  });
  SliderModel.fromJson(Map<String, dynamic> json) {
    message = json["message"]?.toString();
    if (json["banners"] != null) {
      final v = json["banners"];
      final arr0 = <Banners>[];
      v.forEach((v) {
        arr0.add(Banners.fromJson(v));
      });
      banners = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["message"] = message;
    if (banners != null) {
      final v = banners;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data["banners"] = arr0;
    }
    return data;
  }
}


class Banners {
  int? id;
  String? bannerUrl;
  String? image;

  Banners({
    this.id,
    this.bannerUrl,
    this.image,
  });
  Banners.fromJson(Map<String, dynamic> json) {
    id = json["id"]?.toInt();
    bannerUrl = json["banner_url"]?.toString();
    image = json["image"]?.toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;
    data["banner_url"] = bannerUrl;
    data["image"] = image;
    return data;
  }
}


