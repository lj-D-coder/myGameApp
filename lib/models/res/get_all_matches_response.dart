class AllMatchesResponse {
  int? status;
  bool? success;
  String? message;
  List<Data>? data;

  AllMatchesResponse({this.status, this.success, this.message, this.data});

  AllMatchesResponse.fromJson(Map<String, dynamic> json) {
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
  String? matchId;
  String? businessID;
  String? price;
  int? noOfSlot;
  int? gameTime;
  String? bookingType;
  int? playerCapacity;
  int? playerJoined;
  int? matchDate;
  int? startTimestamp;
  int? endTimestamp;

  Data({this.matchId, this.price, this.businessID, this.noOfSlot, this.gameTime, this.bookingType, this.playerCapacity, this.playerJoined, this.matchDate, this.startTimestamp, this.endTimestamp});

  Data.fromJson(Map<String, dynamic> json) {
    matchId = json['matchId'];
    price = json['price'];
    businessID = json['businessID'];
    noOfSlot = json['noOfSlot'];
    gameTime = json['gameTime'];
    bookingType = json['bookingType'];
    playerCapacity = json['playerCapacity'];
    playerJoined = json['playerJoined'];
    matchDate = json['matchDate'];
    startTimestamp = json['StartTimestamp'];
    endTimestamp = json['EndTimestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['matchId'] = this.matchId;
    data['businessID'] = this.businessID;
    data['price'] = this.price;
    data['noOfSlot'] = this.noOfSlot;
    data['gameTime'] = this.gameTime;
    data['bookingType'] = this.bookingType;
    data['playerCapacity'] = this.playerCapacity;
    data['playerJoined'] = this.playerJoined;
    data['matchDate'] = this.matchDate;
    data['StartTimestamp'] = this.startTimestamp;
    data['EndTimestamp'] = this.endTimestamp;
    return data;
  }
}
