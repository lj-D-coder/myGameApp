class SignUpResponse {
  final bool? success;
  final String? message;
  final String? JWT_token;
  SignUpResponse(
      {required this.success, required this.JWT_token, this.message});
  factory SignUpResponse.fromJson(Map<String, dynamic> json) {
    return SignUpResponse(
        success: json['success'],
        JWT_token: json['JWT_token'],
        message: json['message']);
  }

  // Named constructor for creating an instance from a map
  factory SignUpResponse.fromMap(Map<String, dynamic> map) {
    return SignUpResponse(
        success: map['success'],
        JWT_token: map['JWT_token'],
        message: map['message']);
  }

  // Convert the object to a JSON map
  Map<String, dynamic> toJson() {
    return {'success': success, 'JWT_token': JWT_token, 'message': message};
  }
}
