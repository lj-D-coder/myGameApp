class MyBookingResponse {
  int? status;
  bool? success;
  String? message;
  List<Data>? data;

  MyBookingResponse({this.status, this.success, this.message, this.data});

  MyBookingResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? bookingId;
  String? userId;
  String? businessName;
  String? businessID;
  String? matchId;
  String? bookingType;
  String? bookingStatus;
  String? bookingDate;
  int? receiptNo;
  int? matchStartTime;
  int? matchEndTime;
  PaymentInfo? paymentInfo;

  Data(
      {this.bookingId,
      this.userId,
      this.businessName,
      this.businessID,
      this.matchId,
      this.bookingType,
      this.bookingStatus,
      this.bookingDate,
      this.receiptNo,
      this.matchStartTime,
      this.matchEndTime,
      this.paymentInfo});

  Data.fromJson(Map<String, dynamic> json) {
    bookingId = json['bookingId'];
    businessName = json['businessName'];

    userId = json['userId'];
    businessID = json['businessID'];
    matchId = json['matchId'];
    bookingType = json['bookingType'];
    bookingStatus = json['bookingStatus'];
    bookingDate = json['bookingDate'];
    receiptNo = json['receiptNo'];
    matchStartTime = json["matchStartTime"];
    matchEndTime = json["matchEndTime"];
    paymentInfo =
        json['paymentInfo'] != null ? new PaymentInfo.fromJson(json['paymentInfo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bookingId'] = this.bookingId;
    data['userId'] = this.userId;
    data['businessID'] = this.businessID;
    data['matchId'] = this.matchId;
    data['bookingType'] = this.bookingType;
    data['bookingStatus'] = this.bookingStatus;
    data['bookingDate'] = this.bookingDate;
    data['receiptNo'] = this.receiptNo;
    if (this.paymentInfo != null) {
      data['paymentInfo'] = this.paymentInfo!.toJson();
    }
    return data;
  }
}

class PaymentInfo {
  int? quantity;
  int? discount;
  int? amountPaid;
  String? couponId;
  String? paymentId;
  String? paymentMode;
  String? paymentStatus;

  PaymentInfo(
      {this.quantity,
      this.discount,
      this.amountPaid,
      this.couponId,
      this.paymentId,
      this.paymentMode,
      this.paymentStatus});

  PaymentInfo.fromJson(Map<String, dynamic> json) {
    quantity = json['quantity'];
    discount = json['discount'];
    amountPaid = json['amountPaid'];
    couponId = json['couponId'];
    paymentId = json['paymentId'];
    paymentMode = json['paymentMode'];
    paymentStatus = json['paymentStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quantity'] = this.quantity;
    data['discount'] = this.discount;
    data['amountPaid'] = this.amountPaid;
    data['couponId'] = this.couponId;
    data['paymentId'] = this.paymentId;
    data['paymentMode'] = this.paymentMode;
    data['paymentStatus'] = this.paymentStatus;
    return data;
  }
}
