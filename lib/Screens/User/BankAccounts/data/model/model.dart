class BankAccountsModel {
  String? status;
  int? id;
  String? bankName;
  String? bankAccountOwner;
  String? accountNumber;

  BankAccountsModel(
      {this.status,
      this.id,
      this.bankName,
      this.bankAccountOwner,
      this.accountNumber});

  BankAccountsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    id = json['id'];
    bankName = json['bank_name'];
    bankAccountOwner = json['bank_account_owner'];
    accountNumber = json['account_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['id'] = this.id;
    data['bank_name'] = this.bankName;
    data['bank_account_owner'] = this.bankAccountOwner;
    data['account_number'] = this.accountNumber;
    return data;
  }
}

// class BankAccountsModel {
//   String? status;
//   List<BanksList?>? banksList;

//   BankAccountsModel({
//     this.status,
//     this.banksList,
//   });

//   BankAccountsModel.fromJson(Map<String, dynamic> json) {
//     status = json["status"]?.toString();
//     if (json["banks list"] != null) {
//       final v = json["banks list"];
//       final arr0 = <BanksList>[];
//       v.forEach((v) {
//         arr0.add(BanksList.fromJson(v));
//       });
//       banksList = arr0;
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data["status"] = status;
//     if (banksList != null) {
//       final v = banksList;
//       final arr0 = [];
//       v!.forEach((v) {
//         arr0.add(v!.toJson());
//       });
//       data["banks list"] = arr0;
//     }
//     return data;
//   }
// }

// class BanksList {
//   int? id;
//   String? ownerName;
//   String? bankName;
//   String? number;
//   String? image;
//   String? createdAt;
//   String? updatedAt;
//   String? imagePath;

//   BanksList({
//     this.id,
//     this.ownerName,
//     this.bankName,
//     this.number,
//     this.image,
//     this.createdAt,
//     this.updatedAt,
//     this.imagePath,
//   });

//   BanksList.fromJson(Map<String, dynamic> json) {
//     id = json["id"]?.toInt();
//     ownerName = json["owner_name"]?.toString();
//     bankName = json["bank_name"]?.toString();
//     number = json["number"]?.toString();
//     image = json["image"]?.toString();
//     createdAt = json["created_at"]?.toString();
//     updatedAt = json["updated_at"]?.toString();
//     imagePath = json["image_path"]?.toString();
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data["id"] = id;
//     data["owner_name"] = ownerName;
//     data["bank_name"] = bankName;
//     data["number"] = number;
//     data["image"] = image;
//     data["created_at"] = createdAt;
//     data["updated_at"] = updatedAt;
//     data["image_path"] = imagePath;
//     return data;
//   }
// }
