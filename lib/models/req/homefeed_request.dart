class HomeFeedRequest {
  List<double>? userLocation;
  int? radius;

  HomeFeedRequest({this.userLocation, this.radius});

  HomeFeedRequest.fromJson(Map<String, dynamic> json) {
    userLocation = json['userLocation'].cast<double>();
    radius = json['radius'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userLocation'] = this.userLocation;
    data['radius'] = this.radius;
    return data;
  }
}
