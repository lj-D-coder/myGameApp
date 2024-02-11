class BookingRequest {
  String? userId;
  List<String>? userName;
  String? businessID;
  int? noOfSlot;
  String? date;
  String? startTime;
  String? endTime;
  String? bookingType;
  String? sideChoose;
  PaymentInfo? paymentInfo;

  BookingRequest({this.userId, this.userName, this.businessID, this.noOfSlot, this.date, this.startTime, this.endTime, this.bookingType, this.sideChoose, this.paymentInfo});

  BookingRequest.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userName = json['UserName'].cast<String>();
    businessID = json['businessID'];
    noOfSlot = json['noOfSlot'];
    date = json['date'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    bookingType = json['bookingType'];
    sideChoose = json['sideChoose'];
    paymentInfo = json['paymentInfo'] != null ? new PaymentInfo.fromJson(json['paymentInfo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['UserName'] = this.userName;
    data['businessID'] = this.businessID;
    data['noOfSlot'] = this.noOfSlot;
    data['date'] = this.date;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['bookingType'] = this.bookingType;
    data['sideChoose'] = this.sideChoose;
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

  PaymentInfo({this.quantity, this.discount, this.amountPaid, this.couponId, this.paymentId, this.paymentMode, this.paymentStatus});

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
