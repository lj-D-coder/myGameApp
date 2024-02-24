class GetRangesResponse {
  int? status;
  bool? success;
  String? message;
  List<String>? timeRanges;

  GetRangesResponse({this.status, this.success, this.message, this.timeRanges});

  GetRangesResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    message = json['message'];
    timeRanges = json['timeRanges'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['success'] = this.success;
    data['message'] = this.message;
    data['timeRanges'] = this.timeRanges;
    return data;
  }
}
