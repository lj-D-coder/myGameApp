class FriendRes {
  int? status;
  bool? success;
  String? message;
  List<NearbyPlayers>? nearbyPlayers;

  FriendRes({this.status, this.success, this.message, this.nearbyPlayers});

  FriendRes.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    message = json['message'];
    if (json['nearbyPlayers'] != null) {
      nearbyPlayers = <NearbyPlayers>[];
      json['nearbyPlayers'].forEach((v) {
        nearbyPlayers!.add(new NearbyPlayers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.nearbyPlayers != null) {
      data['nearbyPlayers'] = this.nearbyPlayers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NearbyPlayers {
  String? userId;
  String? profilePicture;
  String? name;
  String? address;
  bool? following;

  NearbyPlayers({this.userId, this.profilePicture, this.name, this.address, this.following});

  NearbyPlayers.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    profilePicture = json['profilePicture'];
    name = json['name'];
    address = json['address'];
    following = json['following'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['profilePicture'] = this.profilePicture;
    data['name'] = this.name;
    data['address'] = this.address;
    data['following'] = this.following;
    return data;
  }
}
