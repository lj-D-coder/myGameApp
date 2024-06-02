class UpdateLocationReq {
  String? userId;
  String? latitude;
  String? longitude;

  UpdateLocationReq({this.userId, this.latitude, this.longitude});

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
