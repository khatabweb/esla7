class UserFinishedModel {
  String? status;
  List<Order?>? order;

  UserFinishedModel({
    this.status,
    this.order,
  });
  UserFinishedModel.fromJson(Map<String, dynamic> json) {
    status = json["status"]?.toString();
    if (json["order"] != null) {
      final v = json["order"];
      final arr0 = <Order>[];
      v.forEach((v) {
        arr0.add(Order.fromJson(v));
      });
      order = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["status"] = status;
    if (order != null) {
      final v = order;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data["order"] = arr0;
    }
    return data;
  }
}


class Order {
  int? id;
  int? userId;
  int? ownerId;
  int? serviceId;
  String? action;
  String? refuseReason;
  int? price;
  int? quantity;
  int? totalPrice;
  String? lat;
  String? lang;
  String? address;
  String? note;
  String? resTime;
  String? resDate;
  String? image;
  String? createdAt;
  String? updatedAt;
  String? imagePath;

  Order({
    this.id,
    this.userId,
    this.ownerId,
    this.serviceId,
    this.action,
    this.refuseReason,
    this.price,
    this.quantity,
    this.totalPrice,
    this.lat,
    this.lang,
    this.address,
    this.note,
    this.resTime,
    this.resDate,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.imagePath,
  });
  Order.fromJson(Map<String, dynamic> json) {
    id = json["id"]?.toInt();
    userId = json["user_id"]?.toInt();
    ownerId = json["owner_id"]?.toInt();
    serviceId = json["service_id"]?.toInt();
    action = json["action"]?.toString();
    refuseReason = json["refuse_reason"]?.toString();
    price = json["price"]?.toInt();
    quantity = json["quantity"]?.toInt();
    totalPrice = json["total_price"]?.toInt();
    lat = json["lat"]?.toString();
    lang = json["lang"]?.toString();
    address = json["address"]?.toString();
    note = json["note"]?.toString();
    resTime = json["res_time"]?.toString();
    resDate = json["res_date"]?.toString();
    image = json["image"]?.toString();
    createdAt = json["created_at"]?.toString();
    updatedAt = json["updated_at"]?.toString();
    imagePath = json["image_path"]?.toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;
    data["user_id"] = userId;
    data["owner_id"] = ownerId;
    data["service_id"] = serviceId;
    data["action"] = action;
    data["refuse_reason"] = refuseReason;
    data["price"] = price;
    data["quantity"] = quantity;
    data["total_price"] = totalPrice;
    data["lat"] = lat;
    data["lang"] = lang;
    data["address"] = address;
    data["note"] = note;
    data["res_time"] = resTime;
    data["res_date"] = resDate;
    data["image"] = image;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;
    data["image_path"] = imagePath;
    return data;
  }
}