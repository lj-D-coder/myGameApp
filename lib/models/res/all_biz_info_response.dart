class AllBusinessInfoResponse {
  int? status;
  String? message;
  List<AllBusiness>? allBusiness;

  AllBusinessInfoResponse({this.status, this.message, this.allBusiness});

  AllBusinessInfoResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['allBusiness'] != null) {
      allBusiness = <AllBusiness>[];
      json['allBusiness'].forEach((v) {
        allBusiness!.add(new AllBusiness.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.allBusiness != null) {
      data['allBusiness'] = this.allBusiness!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllBusiness {
  String? loginId;
  String? userName;
  String? phoneNo;
  String? email;
  String? userRole;
  String? createdAt;
  String? updatedAt;
  BusinessData? businessData;

  AllBusiness(
      {this.loginId,
      this.userName,
      this.phoneNo,
      this.email,
      this.userRole,
      this.createdAt,
      this.updatedAt,
      this.businessData});

  AllBusiness.fromJson(Map<String, dynamic> json) {
    loginId = json['loginId'];
    userName = json['userName'];
    phoneNo = json['phoneNo'];
    email = json['email'];
    userRole = json['userRole'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    businessData = json['businessData'] != null
        ? new BusinessData.fromJson(json['businessData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['loginId'] = this.loginId;
    data['userName'] = this.userName;
    data['phoneNo'] = this.phoneNo;
    data['email'] = this.email;
    data['userRole'] = this.userRole;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.businessData != null) {
      data['businessData'] = this.businessData!.toJson();
    }
    return data;
  }
}

class BusinessData {
  BusinessStatus? businessStatus;
  BusinessInfo? businessInfo;
  BusinessHours? businessHours;
  Slot? slot;
  BookingType? bookingType;
  String? sId;
  String? businessID;
  String? createdAt;
  String? updatedAt;

  BusinessData({
    this.businessStatus,
    this.businessInfo,
    this.businessHours,
    this.slot,
    this.bookingType,
    this.sId,
    this.businessID,
    this.createdAt,
    this.updatedAt,
  });

  BusinessData.fromJson(Map<String, dynamic> json) {
    businessStatus = json['businessStatus'] != null
        ? new BusinessStatus.fromJson(json['businessStatus'])
        : null;
    businessInfo = json['businessInfo'] != null
        ? new BusinessInfo.fromJson(json['businessInfo'])
        : null;
    businessHours = json['businessHours'] != null
        ? new BusinessHours.fromJson(json['businessHours'])
        : null;
    slot = json['slot'] != null ? new Slot.fromJson(json['slot']) : null;
    bookingType = json['bookingType'] != null
        ? new BookingType.fromJson(json['bookingType'])
        : null;
    sId = json['_id'];
    businessID = json['businessID'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.businessStatus != null) {
      data['businessStatus'] = this.businessStatus!.toJson();
    }
    if (this.businessInfo != null) {
      data['businessInfo'] = this.businessInfo!.toJson();
    }
    if (this.businessHours != null) {
      data['businessHours'] = this.businessHours!.toJson();
    }
    if (this.slot != null) {
      data['slot'] = this.slot!.toJson();
    }
    if (this.bookingType != null) {
      data['bookingType'] = this.bookingType!.toJson();
    }
    data['_id'] = this.sId;
    data['businessID'] = this.businessID;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class BusinessStatus {
  Holiday? holiday;
  bool? open;
  bool? blocked;
  bool? verified;

  BusinessStatus({this.holiday, this.open, this.blocked, this.verified});

  BusinessStatus.fromJson(Map<String, dynamic> json) {
    holiday =
        json['holiday'] != null ? new Holiday.fromJson(json['holiday']) : null;
    open = json['open'];
    blocked = json['blocked'];
    verified = json['verified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.holiday != null) {
      data['holiday'] = this.holiday!.toJson();
    }
    data['open'] = this.open;
    data['blocked'] = this.blocked;
    data['verified'] = this.verified;
    return data;
  }
}

class Holiday {
  bool? sunday;
  bool? monday;
  bool? tuesday;
  bool? wednesday;
  bool? thrusday;
  bool? friday;
  bool? saturday;

  Holiday(
      {this.sunday,
      this.monday,
      this.tuesday,
      this.wednesday,
      this.thrusday,
      this.friday,
      this.saturday});

  Holiday.fromJson(Map<String, dynamic> json) {
    sunday = json['sunday'];
    monday = json['monday'];
    tuesday = json['tuesday'];
    wednesday = json['wednesday'];
    thrusday = json['thrusday'];
    friday = json['friday'];
    saturday = json['saturday'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sunday'] = this.sunday;
    data['monday'] = this.monday;
    data['tuesday'] = this.tuesday;
    data['wednesday'] = this.wednesday;
    data['thrusday'] = this.thrusday;
    data['friday'] = this.friday;
    data['saturday'] = this.saturday;
    return data;
  }
}

class BusinessInfo {
  Location? location;
  String? name;
  String? address;
  int? phoneNo;
  String? email;
  String? gstNo;
  String? bannerUrl;

  BusinessInfo(
      {this.location,
      this.name,
      this.address,
      this.phoneNo,
      this.email,
      this.gstNo,
      this.bannerUrl});

  BusinessInfo.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    name = json['name'];
    address = json['address'];
    phoneNo = json['phoneNo'];
    email = json['email'];
    gstNo = json['gstNo'];
    bannerUrl = json['bannerUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['name'] = this.name;
    data['address'] = this.address;
    data['phoneNo'] = this.phoneNo;
    data['email'] = this.email;
    data['gstNo'] = this.gstNo;
    data['bannerUrl'] = this.bannerUrl;
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

class BookingType {
  bool? single;
  bool? multiple;
  bool? team;
  bool? timeRanges;

  BookingType({this.single, this.multiple, this.team, this.timeRanges});

  BookingType.fromJson(Map<String, dynamic> json) {
    single = json['single'];
    multiple = json['multiple'];
    team = json['team'];
    timeRanges = json['TimeRanges'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['single'] = this.single;
    data['multiple'] = this.multiple;
    data['team'] = this.team;
    data['TimeRanges'] = this.timeRanges;
    return data;
  }
}
