class FollowerRes {
  int? status;
  bool? success;
  String? message;
  Data? data;

  FollowerRes({this.status, this.success, this.message, this.data});

  FollowerRes.fromJson(Map<String, dynamic> json) {
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
  int? followerCount;
  List<Followers>? followers;

  Data({this.followerCount, this.followers});

  Data.fromJson(Map<String, dynamic> json) {
    followerCount = json['followerCount'];
    if (json['followers'] != null) {
      followers = <Followers>[];
      json['followers'].forEach((v) {
        followers!.add(new Followers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['followerCount'] = this.followerCount;
    if (this.followers != null) {
      data['followers'] = this.followers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Followers {
  String? followerId;
  String? userName;
  String? profilePicture;

  Followers({this.followerId, this.userName, this.profilePicture});

  Followers.fromJson(Map<String, dynamic> json) {
    followerId = json['followerId'];
    userName = json['userName'];
    profilePicture = json['profilePicture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['followerId'] = this.followerId;
    data['userName'] = this.userName;
    data['profilePicture'] = this.profilePicture;
    return data;
  }
}
