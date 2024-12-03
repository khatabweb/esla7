class OwnerProfileModel {
  String? status;
  String? companyName;
  String? companyPhone;
  String? companyEmail;
  String? companyMinSalary;
  String? companyCommerical;
  String? commericalImage;
  String? companyImage;
  String? from;
  String? to;
  String? bankName;
  String? bankAccountOwner;
  String? accountNumber;
  String? serviceNameAr;
  String? serviceNameEn;

  OwnerProfileModel({
    this.status,
    this.companyName,
    this.companyPhone,
    this.companyEmail,
    this.companyMinSalary,
    this.companyCommerical,
    this.commericalImage,
    this.companyImage,
    this.from,
    this.to,
    this.bankName,
    this.bankAccountOwner,
    this.accountNumber,
    this.serviceNameAr,
    this.serviceNameEn,
  });
  OwnerProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status']?.toString();
    companyName = json['company_name']?.toString();
    companyPhone = json['company_phone']?.toString();
    companyEmail = json['company_email']?.toString();
    companyMinSalary = json['company_min_salary']?.toString();
    companyCommerical = json['company_commerical']?.toString();
    commericalImage = json['commerical_image']?.toString();
    companyImage = json['company_image']?.toString();
    from = json['from']?.toString();
    to = json['to']?.toString();
    bankName = json['bank_name']?.toString();
    bankAccountOwner = json['bank_account_owner']?.toString();
    accountNumber = json['account_number']?.toString();
    serviceNameAr = json['service_name_ar']?.toString();
    serviceNameEn = json['service_name_en']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['company_name'] = companyName;
    data['company_phone'] = companyPhone;
    data['company_email'] = companyEmail;
    data['company_min_salary'] = companyMinSalary;
    data['company_commerical'] = companyCommerical;
    data['commerical_image'] = commericalImage;
    data['company_image'] = companyImage;
    data['from'] = from;
    data['to'] = to;
    data['bank_name'] = bankName;
    data['bank_account_owner'] = bankAccountOwner;
    data['account_number'] = accountNumber;
    data['service_name_ar'] = serviceNameAr;
    data['service_name_en'] = serviceNameEn;
    return data;
  }
}
