class GenericResponse {
  int? status;
  String? message;

  GenericResponse({this.status, this.message});

  GenericResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
