class ApiErrorModel {
  final String? message;
  final int? code;

  ApiErrorModel({
    required this.message,
    this.code,
  });

  // Factory constructor to create an instance from JSON
  factory ApiErrorModel.fromJson(Map<String, dynamic> json) {
    return ApiErrorModel(
      message: json['message'] as String?, // Safely cast to String
      code: json['code'] as int?, // Safely cast to int
    );
  }

  // Method to convert the instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'code': code,
    };
  }
}
