class OwnerNotificationModel {
  List<Notification?>? notification;
  String? message;

  OwnerNotificationModel({
    this.notification,
    this.message,
  });
  OwnerNotificationModel.fromJson(Map<String, dynamic> json) {
    if (json["nots"] != null) {
      final v = json["nots"];
      final arr0 = <Notification>[];
      v.forEach((v) {
        arr0.add(Notification.fromJson(v));
      });
      this.notification = arr0;
    }
    message = json["message"]?.toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.notification != null) {
      final v = this.notification;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data["data"] = arr0;
    }
    data["message"] = message;
    return data;
  }
}

class Notification {
  int? id;
  String? userId;
  int? ownerId;
  int? orderId;
  String? title;
  String? body;
  String? titleEn;
  String? bodyEn;
  String? createdAt;
  String? updatedAt;

  Notification({
    this.id,
    this.userId,
    this.ownerId,
    this.orderId,
    this.title,
    this.body,
    this.titleEn,
    this.bodyEn,
    this.createdAt,
    this.updatedAt,
  });
  Notification.fromJson(Map<String, dynamic> json) {
    id = json["id"]?.toInt();
    userId = json["user_id"]?.toString();
    ownerId = json["owner_id"]?.toInt();
    orderId = json["order_id"]?.toInt();
    title = json["title"]?.toString();
    body = json["body"]?.toString();
    titleEn = json["title_en"]?.toString();
    bodyEn = json["body_en"]?.toString();
    createdAt = json["created_at"]?.toString();
    updatedAt = json["updated_at"]?.toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;
    data["user_id"] = userId;
    data["owner_id"] = ownerId;
    data["order_id"] = orderId;
    data["title"] = title;
    data["body"] = body;
    data["title_en"] = titleEn;
    data["body_en"] = bodyEn;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;
    return data;
  }
}
