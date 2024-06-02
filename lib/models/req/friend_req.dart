// ignore_for_file: public_member_api_docs, sort_constructors_first
class FriendReq {
  String? userId;
  List? userLocation;
  int? radius;
  FriendReq({
    this.userId,
    this.userLocation,
    this.radius,
  });
  Map<String, dynamic> toJson() {
    return {'userId': userId, 'userLocation': userLocation, 'radius': radius};
  }
}
