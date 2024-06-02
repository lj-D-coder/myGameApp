class UserProfileRes {
  int? status;
  bool? success;
  String? message;
  UserData? userData;

  UserProfileRes({this.status, this.success, this.message, this.userData});

  UserProfileRes.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    message = json['message'];
    userData = json['UserData'] != null ? new UserData.fromJson(json['UserData']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.userData != null) {
      data['UserData'] = this.userData!.toJson();
    }
    return data;
  }
}

class UserData {
  String? domain;
  String? userId;
  String? userName;
  String? profilePicture;
  int? follower;
  int? following;

  UserData(
      {this.domain,
      this.userId,
      this.userName,
      this.profilePicture,
      this.follower,
      this.following});

  UserData.fromJson(Map<String, dynamic> json) {
    domain = json['domain'];
    userId = json['UserId'];
    userName = json['userName'];
    profilePicture = json['profilePicture'];
    follower = json['follower'];
    following = json['following'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['domain'] = this.domain;
    data['UserId'] = this.userId;
    data['userName'] = this.userName;
    data['profilePicture'] = this.profilePicture;
    data['follower'] = this.follower;
    data['following'] = this.following;
    return data;
  }
}
