class OwnerOrderDetailsModel {
  String? status;
  String? userName;
  String? userImage;
  String? servicesNameAr;
  String? servicesNameEn;
  String? minSalary;
  int? orderNumber;
  int? totalPrice;
  String? address;
  int? quantity;
  int? price;
  String? image;
  String? resTime;
  String? resDate;
  String? serviceDesc;
  String? notes;

  OwnerOrderDetailsModel({
    this.status,
    this.userName,
    this.userImage,
    this.servicesNameAr,
    this.servicesNameEn,
    this.minSalary,
    this.orderNumber,
    this.totalPrice,
    this.address,
    this.quantity,
    this.price,
    this.image,
    this.resTime,
    this.resDate,
    this.serviceDesc,
    this.notes,
  });
  OwnerOrderDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status']?.toString();
    userName = json['user_name']?.toString();
    userImage = json['user_image']?.toString();
    servicesNameAr = json['services_name_ar']?.toString();
    servicesNameEn = json['services_name_en']?.toString();
    minSalary = json['min_salary']?.toString();
    orderNumber = json['order_number']?.toInt();
    totalPrice = json['total_price']?.toInt();
    address = json['address']?.toString();
    quantity = json['quantity']?.toInt();
    price = json['price']?.toInt();
    image = json['image']?.toString();
    resTime = json['res_time']?.toString();
    resDate = json['res_date']?.toString();
    serviceDesc = json['service_desc']?.toString();
    notes = json['notes']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['user_name'] = userName;
    data['user_image'] = userImage;
    data['services_name_ar'] = servicesNameAr;
    data['services_name_en'] = servicesNameEn;
    data['min_salary'] = minSalary;
    data['order_number'] = orderNumber;
    data['total_price'] = totalPrice;
    data['address'] = address;
    data['quantity'] = quantity;
    data['price'] = price;
    data['image'] = image;
    data['res_time'] = resTime;
    data['res_date'] = resDate;
    data['service_desc'] = serviceDesc;
    data['notes'] = notes;
    return data;
  }
}
