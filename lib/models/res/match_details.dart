class MatchDetailResponse {
  int? status;
  bool? success;
  String? message;
  Data? data;

  MatchDetailResponse({this.status, this.success, this.message, this.data});

  MatchDetailResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  Teams? teams;
  String? matchId;
  String? businessID;
  int? noOfSlot;
  int? gameTime;
  String? bookingType;
  int? playerCapacity;
  int? playerJoined;
  int? matchDate;
  int? startTimestamp;
  int? endTimestamp;

  Data({this.teams, this.matchId, this.businessID, this.noOfSlot, this.gameTime, this.bookingType, this.playerCapacity, this.playerJoined, this.matchDate, this.startTimestamp, this.endTimestamp});

  Data.fromJson(Map<String, dynamic> json) {
    teams = json['teams'] != null ? new Teams.fromJson(json['teams']) : null;
    matchId = json['matchId'];
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
    if (this.teams != null) {
      data['teams'] = this.teams!.toJson();
    }
    data['matchId'] = this.matchId;
    data['businessID'] = this.businessID;
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

class Teams {
  List<String>? leftTeam;
  List<String>? rightTeam;

  Teams({this.leftTeam, this.rightTeam});

  Teams.fromJson(Map<String, dynamic> json) {
    leftTeam = json['leftTeam'].cast<String>();
    rightTeam = json['rightTeam'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['leftTeam'] = this.leftTeam;
    data['rightTeam'] = this.rightTeam;
    return data;
  }
}
