class UserOrderDetailsModel {
  String? status;
  int? ownerId;
  String? ownerName;
  String? servicesNameAr;
  String? servicesNameEn;
  String? minSalary;
  int? price;
  int? quantity;
  int? orderNumber;
  int? totalPrice;
  String? address;
  String? resTime;
  String? resDate;
  String? image;
  String? serviceDesc;
  String? imageOwner;
  String? notes;

  UserOrderDetailsModel({
    this.status,
    this.ownerId,
    this.ownerName,
    this.servicesNameAr,
    this.servicesNameEn,
    this.minSalary,
    this.price,
    this.quantity,
    this.orderNumber,
    this.totalPrice,
    this.address,
    this.resTime,
    this.resDate,
    this.image,
    this.serviceDesc,
    this.imageOwner,
    this.notes,
  });
  UserOrderDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status']?.toString();
    ownerId = json['owner_id']?.toInt();
    ownerName = json['owner_name']?.toString();
    servicesNameAr = json['services_name_ar']?.toString();
    servicesNameEn = json['services_name_en']?.toString();
    minSalary = json['min_salary']?.toString();
    price = json['price']?.toInt();
    quantity = json['quantity']?.toInt();
    orderNumber = json['order_number']?.toInt();
    totalPrice = json['total_price']?.toInt();
    address = json['address']?.toString();
    resTime = json['res_time']?.toString();
    resDate = json['res_date']?.toString();
    image = json['image']?.toString();
    serviceDesc = json['service_desc']?.toString();
    imageOwner = json['imageOwner']?.toString();
    notes = json['notes']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['owner_id'] = ownerId;
    data['owner_name'] = ownerName;
    data['services_name_ar'] = servicesNameAr;
    data['services_name_en'] = servicesNameEn;
    data['min_salary'] = minSalary;
    data['price'] = price;
    data['quantity'] = quantity;
    data['order_number'] = orderNumber;
    data['total_price'] = totalPrice;
    data['address'] = address;
    data['res_time'] = resTime;
    data['res_date'] = resDate;
    data['image'] = image;
    data['service_desc'] = serviceDesc;
    data['imageOwner'] = imageOwner;
    data['notes'] = notes;
    return data;
  }
}
