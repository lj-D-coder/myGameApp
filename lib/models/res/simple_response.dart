class SimpleResponse {
  int? status;
  String? message;
  SimpleResponse({this.status, this.message});
  factory SimpleResponse.fromJson(Map<String, dynamic> json) {
    return SimpleResponse(status: json['status'], message: json['message']);
  }
}
