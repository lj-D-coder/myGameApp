// ignore_for_file: public_member_api_docs, sort_constructors_first
class FollowReq {
  String? userId;
  String? followerId;
  FollowReq({this.userId, this.followerId});
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'followerId': followerId,
    };
  }
}
