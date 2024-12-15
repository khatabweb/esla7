class AllChatsModel {
  String? msg;
  List<Data>? data;

  AllChatsModel({this.msg, this.data});

  AllChatsModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  int? senderId;
  int? receiverId;
  String? createdAt;
  String? updatedAt;
  Sender? sender;
  Receiver? receiver;
  SenderOwner? senderOwner;
  ReceiverOwner? receiverOwner;
  Lastchat? lastchat;

  Data(
      {this.id,
      this.senderId,
      this.receiverId,
      this.createdAt,
      this.updatedAt,
      this.sender,
      this.receiver,
      this.senderOwner,
      this.receiverOwner,
      this.lastchat});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    senderId = json['sender_id'];
    receiverId = json['receiver_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    sender =
        json['sender'] != null ? new Sender.fromJson(json['sender']) : null;
    receiver = json['receiver'] != null
        ? new Receiver.fromJson(json['receiver'])
        : null;
    senderOwner = json['sender_owner'] != null
        ? new SenderOwner.fromJson(json['sender_owner'])
        : null;
    receiverOwner = json['receiver_owner'] != null
        ? new ReceiverOwner.fromJson(json['receiver_owner'])
        : null;
    lastchat = json['lastchat'] != null
        ? new Lastchat.fromJson(json['lastchat'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sender_id'] = this.senderId;
    data['receiver_id'] = this.receiverId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.sender != null) {
      data['sender'] = this.sender!.toJson();
    }
    if (this.receiver != null) {
      data['receiver'] = this.receiver!.toJson();
    }
    if (this.senderOwner != null) {
      data['sender_owner'] = this.senderOwner!.toJson();
    }
    if (this.receiverOwner != null) {
      data['receiver_owner'] = this.receiverOwner!.toJson();
    }
    if (this.lastchat != null) {
      data['lastchat'] = this.lastchat!.toJson();
    }
    return data;
  }
}

class Sender {
  int? id;
  String? name;
  String? nameEn;
  String? email;
  var emailVerifiedAt;
  String? password;
  String? url;
  var website;
  String? commericalIdnumber;
  String? storeName;
  String? storeNameEn;
  String? typeOfGoods;
  String? typeOfGoodsEn;
  String? phone;
  String? type;
  int? isSuperAdmin;
  int? confirm;
  int? accept;
  int? online;
  var cityId;
  var carId;
  String? image;
  int? rate;
  var lat;
  var lng;
  var address;
  var googleToken;
  String? apiToken;
  int? points;
  int? block;
  int? paymentOrder;
  int? complete;
  int? kilometer;
  var commericalNumber;
  int? editCommericalIdnumber;
  String? createdAt;
  String? updatedAt;

  Sender(
      {this.id,
      this.name,
      this.nameEn,
      this.email,
      this.emailVerifiedAt,
      this.password,
      this.url,
      this.website,
      this.commericalIdnumber,
      this.storeName,
      this.storeNameEn,
      this.typeOfGoods,
      this.typeOfGoodsEn,
      this.phone,
      this.type,
      this.isSuperAdmin,
      this.confirm,
      this.accept,
      this.online,
      this.cityId,
      this.carId,
      this.image,
      this.rate,
      this.lat,
      this.lng,
      this.address,
      this.googleToken,
      this.apiToken,
      this.points,
      this.block,
      this.paymentOrder,
      this.complete,
      this.kilometer,
      this.commericalNumber,
      this.editCommericalIdnumber,
      this.createdAt,
      this.updatedAt});

  Sender.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameEn = json['name_en'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    password = json['password'];
    url = json['url'];
    website = json['website'];
    commericalIdnumber = json['commerical_idnumber'];
    storeName = json['store_name'];
    storeNameEn = json['store_name_en'];
    typeOfGoods = json['type_of_goods'];
    typeOfGoodsEn = json['type_of_goods_en'];
    phone = json['phone'];
    type = json['type'];
    isSuperAdmin = json['is_superAdmin'];
    confirm = json['confirm'];
    accept = json['accept'];
    online = json['online'];
    cityId = json['city_id'];
    carId = json['car_id'];
    image = json['image'];
    rate = json['rate'];
    lat = json['lat'];
    lng = json['lng'];
    address = json['address'];
    googleToken = json['google_token'];
    apiToken = json['api_token'];
    points = json['points'];
    block = json['block'];
    paymentOrder = json['paymentOrder'];
    complete = json['complete'];
    kilometer = json['kilometer'];
    commericalNumber = json['commerical_number'];
    editCommericalIdnumber = json['edit_commerical_idnumber'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['name_en'] = this.nameEn;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['password'] = this.password;
    data['url'] = this.url;
    data['website'] = this.website;
    data['commerical_idnumber'] = this.commericalIdnumber;
    data['store_name'] = this.storeName;
    data['store_name_en'] = this.storeNameEn;
    data['type_of_goods'] = this.typeOfGoods;
    data['type_of_goods_en'] = this.typeOfGoodsEn;
    data['phone'] = this.phone;
    data['type'] = this.type;
    data['is_superAdmin'] = this.isSuperAdmin;
    data['confirm'] = this.confirm;
    data['accept'] = this.accept;
    data['online'] = this.online;
    data['city_id'] = this.cityId;
    data['car_id'] = this.carId;
    data['image'] = this.image;
    data['rate'] = this.rate;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['address'] = this.address;
    data['google_token'] = this.googleToken;
    data['api_token'] = this.apiToken;
    data['points'] = this.points;
    data['block'] = this.block;
    data['paymentOrder'] = this.paymentOrder;
    data['complete'] = this.complete;
    data['kilometer'] = this.kilometer;
    data['commerical_number'] = this.commericalNumber;
    data['edit_commerical_idnumber'] = this.editCommericalIdnumber;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Receiver {
  int? id;
  String? name;
  String? nameEn;
  String? email;
  var emailVerifiedAt;
  String? password;
  var url;
  var website;
  var commericalIdnumber;
  var storeName;
  var storeNameEn;
  var typeOfGoods;
  var typeOfGoodsEn;
  String? phone;
  String? type;
  int? isSuperAdmin;
  int? confirm;
  int? accept;
  int? online;
  int? cityId;
  int? carId;
  String? image;
  int? rate;
  String? lat;
  String? lng;
  String? address;
  String? googleToken;
  String? apiToken;
  int? points;
  int? block;
  int? paymentOrder;
  int? complete;
  int? kilometer;
  var commericalNumber;
  int? editCommericalIdnumber;
  String? createdAt;
  String? updatedAt;

  Receiver(
      {this.id,
      this.name,
      this.nameEn,
      this.email,
      this.emailVerifiedAt,
      this.password,
      this.url,
      this.website,
      this.commericalIdnumber,
      this.storeName,
      this.storeNameEn,
      this.typeOfGoods,
      this.typeOfGoodsEn,
      this.phone,
      this.type,
      this.isSuperAdmin,
      this.confirm,
      this.accept,
      this.online,
      this.cityId,
      this.carId,
      this.image,
      this.rate,
      this.lat,
      this.lng,
      this.address,
      this.googleToken,
      this.apiToken,
      this.points,
      this.block,
      this.paymentOrder,
      this.complete,
      this.kilometer,
      this.commericalNumber,
      this.editCommericalIdnumber,
      this.createdAt,
      this.updatedAt});

  Receiver.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameEn = json['name_en'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    password = json['password'];
    url = json['url'];
    website = json['website'];
    commericalIdnumber = json['commerical_idnumber'];
    storeName = json['store_name'];
    storeNameEn = json['store_name_en'];
    typeOfGoods = json['type_of_goods'];
    typeOfGoodsEn = json['type_of_goods_en'];
    phone = json['phone'];
    type = json['type'];
    isSuperAdmin = json['is_superAdmin'];
    confirm = json['confirm'];
    accept = json['accept'];
    online = json['online'];
    cityId = json['city_id'];
    carId = json['car_id'];
    image = json['image'];
    rate = json['rate'];
    lat = json['lat'];
    lng = json['lng'];
    address = json['address'];
    googleToken = json['google_token'];
    apiToken = json['api_token'];
    points = json['points'];
    block = json['block'];
    paymentOrder = json['paymentOrder'];
    complete = json['complete'];
    kilometer = json['kilometer'];
    commericalNumber = json['commerical_number'];
    editCommericalIdnumber = json['edit_commerical_idnumber'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['name_en'] = this.nameEn;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['password'] = this.password;
    data['url'] = this.url;
    data['website'] = this.website;
    data['commerical_idnumber'] = this.commericalIdnumber;
    data['store_name'] = this.storeName;
    data['store_name_en'] = this.storeNameEn;
    data['type_of_goods'] = this.typeOfGoods;
    data['type_of_goods_en'] = this.typeOfGoodsEn;
    data['phone'] = this.phone;
    data['type'] = this.type;
    data['is_superAdmin'] = this.isSuperAdmin;
    data['confirm'] = this.confirm;
    data['accept'] = this.accept;
    data['online'] = this.online;
    data['city_id'] = this.cityId;
    data['car_id'] = this.carId;
    data['image'] = this.image;
    data['rate'] = this.rate;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['address'] = this.address;
    data['google_token'] = this.googleToken;
    data['api_token'] = this.apiToken;
    data['points'] = this.points;
    data['block'] = this.block;
    data['paymentOrder'] = this.paymentOrder;
    data['complete'] = this.complete;
    data['kilometer'] = this.kilometer;
    data['commerical_number'] = this.commericalNumber;
    data['edit_commerical_idnumber'] = this.editCommericalIdnumber;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class SenderOwner {
  int? id;
  String? name;
  String? nameEn;
  String? email;
  var emailVerifiedAt;
  String? password;
  String? url;
  var website;
  String? commericalIdnumber;
  String? storeName;
  String? storeNameEn;
  String? typeOfGoods;
  String? typeOfGoodsEn;
  String? phone;
  String? type;
  int? isSuperAdmin;
  int? confirm;
  int? accept;
  int? online;
  var cityId;
  var carId;
  String? image;
  int? rate;
  var lat;
  var lng;
  var address;
  var googleToken;
  String? apiToken;
  int? points;
  int? block;
  int? paymentOrder;
  int? complete;
  int? kilometer;
  var commericalNumber;
  int? editCommericalIdnumber;
  String? createdAt;
  String? updatedAt;

  SenderOwner(
      {this.id,
      this.name,
      this.nameEn,
      this.email,
      this.emailVerifiedAt,
      this.password,
      this.url,
      this.website,
      this.commericalIdnumber,
      this.storeName,
      this.storeNameEn,
      this.typeOfGoods,
      this.typeOfGoodsEn,
      this.phone,
      this.type,
      this.isSuperAdmin,
      this.confirm,
      this.accept,
      this.online,
      this.cityId,
      this.carId,
      this.image,
      this.rate,
      this.lat,
      this.lng,
      this.address,
      this.googleToken,
      this.apiToken,
      this.points,
      this.block,
      this.paymentOrder,
      this.complete,
      this.kilometer,
      this.commericalNumber,
      this.editCommericalIdnumber,
      this.createdAt,
      this.updatedAt});

  SenderOwner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameEn = json['name_en'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    password = json['password'];
    url = json['url'];
    website = json['website'];
    commericalIdnumber = json['commerical_idnumber'];
    storeName = json['store_name'];
    storeNameEn = json['store_name_en'];
    typeOfGoods = json['type_of_goods'];
    typeOfGoodsEn = json['type_of_goods_en'];
    phone = json['phone'];
    type = json['type'];
    isSuperAdmin = json['is_superAdmin'];
    confirm = json['confirm'];
    accept = json['accept'];
    online = json['online'];
    cityId = json['city_id'];
    carId = json['car_id'];
    image = json['image'];
    rate = json['rate'];
    lat = json['lat'];
    lng = json['lng'];
    address = json['address'];
    googleToken = json['google_token'];
    apiToken = json['api_token'];
    points = json['points'];
    block = json['block'];
    paymentOrder = json['paymentOrder'];
    complete = json['complete'];
    kilometer = json['kilometer'];
    commericalNumber = json['commerical_number'];
    editCommericalIdnumber = json['edit_commerical_idnumber'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['name_en'] = this.nameEn;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['password'] = this.password;
    data['url'] = this.url;
    data['website'] = this.website;
    data['commerical_idnumber'] = this.commericalIdnumber;
    data['store_name'] = this.storeName;
    data['store_name_en'] = this.storeNameEn;
    data['type_of_goods'] = this.typeOfGoods;
    data['type_of_goods_en'] = this.typeOfGoodsEn;
    data['phone'] = this.phone;
    data['type'] = this.type;
    data['is_superAdmin'] = this.isSuperAdmin;
    data['confirm'] = this.confirm;
    data['accept'] = this.accept;
    data['online'] = this.online;
    data['city_id'] = this.cityId;
    data['car_id'] = this.carId;
    data['image'] = this.image;
    data['rate'] = this.rate;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['address'] = this.address;
    data['google_token'] = this.googleToken;
    data['api_token'] = this.apiToken;
    data['points'] = this.points;
    data['block'] = this.block;
    data['paymentOrder'] = this.paymentOrder;
    data['complete'] = this.complete;
    data['kilometer'] = this.kilometer;
    data['commerical_number'] = this.commericalNumber;
    data['edit_commerical_idnumber'] = this.editCommericalIdnumber;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class ReceiverOwner {
  int? id;
  String? name;
  String? nameEn;
  String? email;
  var emailVerifiedAt;
  String? password;
  var url;
  var website;
  var commericalIdnumber;
  var storeName;
  var storeNameEn;
  var typeOfGoods;
  var typeOfGoodsEn;
  String? phone;
  String? type;
  int? isSuperAdmin;
  int? confirm;
  int? accept;
  int? online;
  int? cityId;
  int? carId;
  String? image;
  int? rate;
  String? lat;
  String? lng;
  String? address;
  String? googleToken;
  String? apiToken;
  int? points;
  int? block;
  int? paymentOrder;
  int? complete;
  int? kilometer;
  var commericalNumber;
  int? editCommericalIdnumber;
  String? createdAt;
  String? updatedAt;

  ReceiverOwner(
      {this.id,
      this.name,
      this.nameEn,
      this.email,
      this.emailVerifiedAt,
      this.password,
      this.url,
      this.website,
      this.commericalIdnumber,
      this.storeName,
      this.storeNameEn,
      this.typeOfGoods,
      this.typeOfGoodsEn,
      this.phone,
      this.type,
      this.isSuperAdmin,
      this.confirm,
      this.accept,
      this.online,
      this.cityId,
      this.carId,
      this.image,
      this.rate,
      this.lat,
      this.lng,
      this.address,
      this.googleToken,
      this.apiToken,
      this.points,
      this.block,
      this.paymentOrder,
      this.complete,
      this.kilometer,
      this.commericalNumber,
      this.editCommericalIdnumber,
      this.createdAt,
      this.updatedAt});

  ReceiverOwner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameEn = json['name_en'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    password = json['password'];
    url = json['url'];
    website = json['website'];
    commericalIdnumber = json['commerical_idnumber'];
    storeName = json['store_name'];
    storeNameEn = json['store_name_en'];
    typeOfGoods = json['type_of_goods'];
    typeOfGoodsEn = json['type_of_goods_en'];
    phone = json['phone'];
    type = json['type'];
    isSuperAdmin = json['is_superAdmin'];
    confirm = json['confirm'];
    accept = json['accept'];
    online = json['online'];
    cityId = json['city_id'];
    carId = json['car_id'];
    image = json['image'];
    rate = json['rate'];
    lat = json['lat'];
    lng = json['lng'];
    address = json['address'];
    googleToken = json['google_token'];
    apiToken = json['api_token'];
    points = json['points'];
    block = json['block'];
    paymentOrder = json['paymentOrder'];
    complete = json['complete'];
    kilometer = json['kilometer'];
    commericalNumber = json['commerical_number'];
    editCommericalIdnumber = json['edit_commerical_idnumber'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['name_en'] = this.nameEn;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['password'] = this.password;
    data['url'] = this.url;
    data['website'] = this.website;
    data['commerical_idnumber'] = this.commericalIdnumber;
    data['store_name'] = this.storeName;
    data['store_name_en'] = this.storeNameEn;
    data['type_of_goods'] = this.typeOfGoods;
    data['type_of_goods_en'] = this.typeOfGoodsEn;
    data['phone'] = this.phone;
    data['type'] = this.type;
    data['is_superAdmin'] = this.isSuperAdmin;
    data['confirm'] = this.confirm;
    data['accept'] = this.accept;
    data['online'] = this.online;
    data['city_id'] = this.cityId;
    data['car_id'] = this.carId;
    data['image'] = this.image;
    data['rate'] = this.rate;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['address'] = this.address;
    data['google_token'] = this.googleToken;
    data['api_token'] = this.apiToken;
    data['points'] = this.points;
    data['block'] = this.block;
    data['paymentOrder'] = this.paymentOrder;
    data['complete'] = this.complete;
    data['kilometer'] = this.kilometer;
    data['commerical_number'] = this.commericalNumber;
    data['edit_commerical_idnumber'] = this.editCommericalIdnumber;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Lastchat {
  int? id;
  String? massage;
  var file;
  int? type;
  int? conversationId;
  int? senderId;
  int? receiverId;
  // int? view;
  String? createdAt;
  String? updatedAt;

  Lastchat(
      {this.id,
      this.massage,
      this.file,
      this.type,
      this.conversationId,
      this.senderId,
      this.receiverId,
      // this.view,
      this.createdAt,
      this.updatedAt});

  Lastchat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    massage = json['massage'];
    file = json['file'];
    type = json['type'];
    conversationId = json['conversation_id'];
    senderId = json['sender_id'];
    receiverId = json['receiver_id'];
    // view = json['view'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['massage'] = this.massage;
    data['file'] = this.file;
    data['type'] = this.type;
    data['conversation_id'] = this.conversationId;
    data['sender_id'] = this.senderId;
    data['receiver_id'] = this.receiverId;
    // data['view'] = this.view;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
