class EndListModel {
  List<Services>? services;

  EndListModel({this.services});

  EndListModel.fromJson(Map<String, dynamic> json) {
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(new Services.fromJson(v));
      });
    }
  }
}

class Services {
  int? id;
  String? nameAr;
  String? nameEn;
  String? image;
  int? price;
  String? descreption;

  Services(
      {this.id,
      this.nameAr,
      this.nameEn,
      this.image,
      this.price,
      this.descreption});

  Services.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    image = json['image'];
    price = int.tryParse(json['price']?.split('.')?.first ?? '0') ?? 0;
    descreption = json['descreption'];
  }
}
