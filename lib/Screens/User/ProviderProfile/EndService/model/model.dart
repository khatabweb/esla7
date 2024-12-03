import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

class CartItemModel extends Equatable{
  String? name;
  int? price;
  String? serviceDesc = "fs";
  String? note;
  int? quantity = 1;
  XFile? image;
  int? ownerId;
  int? serviceId;

  CartItemModel({this.name,this.price,this.serviceDesc,this.note,this.quantity,this.image,this.ownerId,this.serviceId});

  CartItemModel copyWith({
    String? name,
    int? price,
    String? serviceDesc,
    String? note,
    int? quantity,
    XFile? image,
    int? ownerId,
    int? serviceId,
  }) =>
      CartItemModel(
        name: name ?? this.name,
        price: price ?? this.price,
        serviceDesc: serviceDesc ?? this.serviceDesc,
        note: note ?? this.note,
        quantity: quantity ?? this.quantity,
        image: image ?? this.image,
        ownerId: ownerId ?? this.ownerId,
        serviceId: serviceId ?? this.serviceId,

      );


  CartItemModel.fromJson(Map<String, dynamic> json) {
    name = json["name"]?.toString();
    price = json["price"];
    serviceDesc = json["service_desc"]?.toString();
    note = json["note"]?.toString();
    quantity = json["quantity"];
    image = json["image"];
    ownerId = json["owner_id"];
    serviceId = json["service_id"];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["name"] = name;
    data["price"] = price;
    data["service_desc"] = serviceDesc;
    data["note"] = note;
    data["quantity"] = quantity;
    data["image"] = image;
    data["owner_id"] = ownerId;
    data["service_id"] = serviceId;
    return data;
  }

  @override
  List<Object?> get props => [
    this.name,
    this.price,
    this.serviceDesc,
    this.note,
    this.quantity,
    this.image,
    this.ownerId,
    this.serviceId,
  ];

  @override
  bool? get stringify => true;
}
