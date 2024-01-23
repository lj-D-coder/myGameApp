import 'package:mygame/models/res/single_biz_info.dart';

class AllBusinessInfoResponse {
  int? status;
  String? message;
  List<SingleBusinessInfo>? data;

  AllBusinessInfoResponse({this.message, this.status, this.data});

  AllBusinessInfoResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <SingleBusinessInfo>[];
      json['data'].forEach((v) {
        data!.add(new SingleBusinessInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
