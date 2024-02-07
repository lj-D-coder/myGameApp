class GetRangesResponse {
  int? status;
  bool? success;
  String? message;
  TimeRanges? timeRanges;

  GetRangesResponse({this.status, this.success, this.message, this.timeRanges});

  GetRangesResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    message = json['message'];
    timeRanges = json['timeRanges'] != null
        ? new TimeRanges.fromJson(json['timeRanges'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.timeRanges != null) {
      data['timeRanges'] = this.timeRanges!.toJson();
    }
    return data;
  }
}

class TimeRanges {
  String? s900AM1000AM;
  String? s1000AM1100AM;
  String? s1100AM1200PM;
  String? s1200PM100PM;
  String? s100PM200PM;
  String? s200PM300PM;
  String? s300PM400PM;
  String? s400PM500PM;
  String? s500PM600PM;
  String? s600PM700PM;
  String? s700PM800PM;
  String? s800PM900PM;

  TimeRanges(
      {this.s900AM1000AM,
      this.s1000AM1100AM,
      this.s1100AM1200PM,
      this.s1200PM100PM,
      this.s100PM200PM,
      this.s200PM300PM,
      this.s300PM400PM,
      this.s400PM500PM,
      this.s500PM600PM,
      this.s600PM700PM,
      this.s700PM800PM,
      this.s800PM900PM});

  TimeRanges.fromJson(Map<String, dynamic> json) {
    s900AM1000AM = json['9:00 AM - 10:00 AM'];
    s1000AM1100AM = json['10:00 AM - 11:00 AM'];
    s1100AM1200PM = json['11:00 AM - 12:00 PM'];
    s1200PM100PM = json['12:00 PM - 1:00 PM'];
    s100PM200PM = json['1:00 PM - 2:00 PM'];
    s200PM300PM = json['2:00 PM - 3:00 PM'];
    s300PM400PM = json['3:00 PM - 4:00 PM'];
    s400PM500PM = json['4:00 PM - 5:00 PM'];
    s500PM600PM = json['5:00 PM - 6:00 PM'];
    s600PM700PM = json['6:00 PM - 7:00 PM'];
    s700PM800PM = json['7:00 PM - 8:00 PM'];
    s800PM900PM = json['8:00 PM - 9:00 PM'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['9:00 AM - 10:00 AM'] = this.s900AM1000AM;
    data['10:00 AM - 11:00 AM'] = this.s1000AM1100AM;
    data['11:00 AM - 12:00 PM'] = this.s1100AM1200PM;
    data['12:00 PM - 1:00 PM'] = this.s1200PM100PM;
    data['1:00 PM - 2:00 PM'] = this.s100PM200PM;
    data['2:00 PM - 3:00 PM'] = this.s200PM300PM;
    data['3:00 PM - 4:00 PM'] = this.s300PM400PM;
    data['4:00 PM - 5:00 PM'] = this.s400PM500PM;
    data['5:00 PM - 6:00 PM'] = this.s500PM600PM;
    data['6:00 PM - 7:00 PM'] = this.s600PM700PM;
    data['7:00 PM - 8:00 PM'] = this.s700PM800PM;
    data['8:00 PM - 9:00 PM'] = this.s800PM900PM;
    return data;
  }
}
