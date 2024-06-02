class HomeFeedResponse {
  int? status;
  bool? success;
  String? message;
  List<NearbyGround>? nearbyGround;
  List<Matches>? matches;

  HomeFeedResponse({this.status, this.success, this.message, this.nearbyGround, this.matches});

  HomeFeedResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    message = json['message'];
    if (json['nearbyGround'] != null) {
      nearbyGround = <NearbyGround>[];
      json['nearbyGround'].forEach((v) {
        nearbyGround!.add(new NearbyGround.fromJson(v));
      });
    }
    if (json['matches'] != null) {
      matches = <Matches>[];
      json['matches'].forEach((v) {
        matches!.add(new Matches.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.nearbyGround != null) {
      data['nearbyGround'] = this.nearbyGround!.map((v) => v.toJson()).toList();
    }
    if (this.matches != null) {
      data['matches'] = this.matches!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NearbyGround {
  String? businessID;
  String? name;
  String? address;
  String? bannerUrl;

  NearbyGround({this.businessID, this.name, this.address, this.bannerUrl});

  NearbyGround.fromJson(Map<String, dynamic> json) {
    businessID = json['businessID'];
    name = json['name'];
    address = json['address'];
    bannerUrl = json['bannerUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['businessID'] = this.businessID;
    data['name'] = this.name;
    data['address'] = this.address;
    data['bannerUrl'] = this.bannerUrl;
    return data;
  }
}

class Matches {
  String? matchId;
  String? businessId;
  String? name;
  String? address;
  String? price;
  int? gameTime;
  int? playerCapacity;
  int? playerJoined;
  int? matchDate;
  int? startTimestamp;
  int? endTimestamp;

  Matches(
      {this.matchId,
      this.businessId,
      this.name,
      this.address,
      this.price,
      this.gameTime,
      this.playerCapacity,
      this.playerJoined,
      this.matchDate,
      this.startTimestamp,
      this.endTimestamp});

  Matches.fromJson(Map<String, dynamic> json) {
    matchId = json['matchId'];
    businessId = json['businessID'];
    name = json['name'];
    address = json['address'];
    price = json['price'];
    gameTime = json['gameTime'];
    playerCapacity = json['playerCapacity'];
    playerJoined = json['playerJoined'];
    matchDate = json['matchDate'];
    startTimestamp = json['StartTimestamp'];
    endTimestamp = json['EndTimestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['matchId'] = this.matchId;
    data['businessID'] = this.businessId;
    data['name'] = this.name;
    data['address'] = this.address;
    data['price'] = this.price;
    data['gameTime'] = this.gameTime;
    data['playerCapacity'] = this.playerCapacity;
    data['playerJoined'] = this.playerJoined;
    data['matchDate'] = this.matchDate;
    data['StartTimestamp'] = this.startTimestamp;
    data['EndTimestamp'] = this.endTimestamp;
    return data;
  }
}
