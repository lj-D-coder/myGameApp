class GetRangesReq {
  String? businessID;
  String? date;

  GetRangesReq({this.businessID, this.date});

  GetRangesReq.fromJson(Map<String, dynamic> json) {
    businessID = json['businessID'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['businessID'] = this.businessID;
    data['date'] = this.date;
    return data;
  }
}
