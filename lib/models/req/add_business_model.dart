class AddBusinessModel {
  BusinessInfo? businessInfo;
  BusinessHours? businessHours;
  Slot? slot;

  AddBusinessModel({this.businessInfo, this.businessHours, this.slot});

  AddBusinessModel.fromJson(Map<String, dynamic> json) {
    businessInfo = json['businessInfo'] != null
        ? new BusinessInfo.fromJson(json['businessInfo'])
        : null;
    businessHours = json['businessHours'] != null
        ? new BusinessHours.fromJson(json['businessHours'])
        : null;
    slot = json['slot'] != null ? new Slot.fromJson(json['slot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.businessInfo != null) {
      data['businessInfo'] = this.businessInfo!.toJson();
    }
    if (this.businessHours != null) {
      data['businessHours'] = this.businessHours!.toJson();
    }
    if (this.slot != null) {
      data['slot'] = this.slot!.toJson();
    }
    return data;
  }
}

class BusinessInfo {
  String? name;
  String? address;
  int? phoneNo;
  String? email;
  String? gstNo;
  String? bannerUrl;
  Location? location;

  BusinessInfo(
      {this.name,
      this.address,
      this.phoneNo,
      this.email,
      this.gstNo,
      this.location});

  BusinessInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    address = json['address'];
    phoneNo = json['phoneNo'];
    email = json['email'];
    gstNo = json['gstNo'];
    bannerUrl = json['bannerUrl'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['address'] = this.address;
    data['phoneNo'] = this.phoneNo;
    data['email'] = this.email;
    data['bannerUrl'] = this.bannerUrl;
    data['gstNo'] = this.gstNo;
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    return data;
  }
}

class Location {
  String? latitude;
  String? longitude;

  Location({this.latitude, this.longitude});

  Location.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}

class BusinessHours {
  String? openTime;
  String? closeTime;
  String? breakStart;
  String? breakEnd;

  BusinessHours(
      {this.openTime, this.closeTime, this.breakStart, this.breakEnd});

  BusinessHours.fromJson(Map<String, dynamic> json) {
    openTime = json['openTime'];
    closeTime = json['closeTime'];
    breakStart = json['breakStart'];
    breakEnd = json['breakEnd'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['openTime'] = this.openTime;
    data['closeTime'] = this.closeTime;
    data['breakStart'] = this.breakStart;
    data['breakEnd'] = this.breakEnd;
    return data;
  }
}

class Slot {
  int? gameLength;
  bool? customGameLength;

  Slot({this.gameLength, this.customGameLength});

  Slot.fromJson(Map<String, dynamic> json) {
    gameLength = json['gameLength'];
    customGameLength = json['customGameLength'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gameLength'] = this.gameLength;
    data['customGameLength'] = this.customGameLength;
    return data;
  }
}
