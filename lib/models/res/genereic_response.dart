import 'package:mygame/models/res/serializable.dart';

class GenericResponse<T extends Serializable> {
  int? status;
  String? message;
  T data;

  GenericResponse({this.status, this.message, required this.data});

  factory GenericResponse.fromJson(
      Map<String, dynamic> json, Function(Map<String, dynamic>) create) {
    return GenericResponse<T>(
      status: json['status'],
      message: json['message'],
      data: create(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "status": this.status,
        "message": this.message,
        "data": this.data.toJson(),
      };
}
