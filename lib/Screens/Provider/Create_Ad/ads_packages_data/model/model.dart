class AdsPackagesModel {
  String? status;
  List<Packages?>? packages;

  AdsPackagesModel({
    this.status,
    this.packages,
  });
  AdsPackagesModel.fromJson(Map<String, dynamic> json) {
    status = json["status"]?.toString();
    if (json["packageslist"] != null) {
      final v = json["packageslist"];
      final arr0 = <Packages>[];
      v.forEach((v) {
        arr0.add(Packages.fromJson(v));
      });
      packages = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["status"] = status;
    if (packages != null) {
      final v = packages;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data["packageslist"] = arr0;
    }
    return data;
  }
}

class Packages {
  int? id;
  String? period;
  String? price;
  int? active;
  String? createdAt;
  String? updatedAt;

  Packages({
    this.id,
    this.period,
    this.price,
    this.active,
    this.createdAt,
    this.updatedAt,
  });
  Packages.fromJson(Map<String, dynamic> json) {
    id = json["id"]?.toInt();
    period = json["period"]?.toString();
    price = json["price"]?.toString();
    active = json["active"]?.toInt();
    createdAt = json["created_at"]?.toString();
    updatedAt = json["updated_at"]?.toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;
    data["period"] = period;
    data["price"] = price;
    data["active"] = active;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;
    return data;
  }
}