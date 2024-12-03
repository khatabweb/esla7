class HelpingModel {
  String? status;
  int? id;
  String? supportNumber;
  String? vedioLink;
  String? questionAr;
  String? questionEn;

  HelpingModel({
    this.status,
    this.id,
    this.supportNumber,
    this.vedioLink,
    this.questionAr,
    this.questionEn,
  });
  HelpingModel.fromJson(Map<String, dynamic> json) {
    status = json["status"]?.toString();
    id = json["id"]?.toInt();
    supportNumber = json["support_number"]?.toString();
    vedioLink = json["vedio_link"]?.toString();
    questionAr = json["question_ar"]?.toString();
    questionEn = json["question_en"]?.toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["status"] = status;
    data["id"] = id;
    data["support_number"] = supportNumber;
    data["vedio_link"] = vedioLink;
    data["question_ar"] = questionAr;
    data["question_en"] = questionEn;
    return data;
  }
}
