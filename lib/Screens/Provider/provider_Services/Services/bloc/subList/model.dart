class SubServiceListModel {
  String? status;
  List<Services?>? services;

  SubServiceListModel({
    this.status,
    this.services,
  });
  SubServiceListModel.fromJson(Map<String, dynamic> json) {
    status = json['status']?.toString();
    if (json['services'] != null) {
      final v = json['services'];
      final arr0 = <Services>[];
      v.forEach((v) {
        arr0.add(Services.fromJson(v));
      });
      services = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    if (services != null) {
      final v = services;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['services'] = arr0;
    }
    return data;
  }
}


class Services {
  int? id;
  String? nameAr;
  String? nameEn;

  Services({
    this.id,
    this.nameAr,
    this.nameEn,
  });
  Services.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    nameAr = json['name_ar']?.toString();
    nameEn = json['name_en']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name_ar'] = nameAr;
    data['name_en'] = nameEn;
    return data;
  }
}