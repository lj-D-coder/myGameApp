class PricingResponse {
  int? status;
  String? businessID;
  Price? price;

  PricingResponse({this.businessID, this.price, this.status});

  factory PricingResponse.fromJson(Map<String, dynamic> json) {
    return PricingResponse(
      businessID: json['businessID'],
      status: json['status'],
      price: json['price'] != null ? Price.fromJson(json['price']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'businessID': businessID,
      'status': status
    };
    if (price != null) {
      data['price'] = price!.toJson();
    }
    return data;
  }
}

class Price {
  Individual? individual;
  Team? team;
  Field? field;

  Price({this.individual, this.team, this.field});

  factory Price.fromJson(Map<String, dynamic> json) {
    return Price(
      individual: json['individual'] != null
          ? Individual.fromJson(json['individual'])
          : null,
      team: json['team'] != null ? Team.fromJson(json['team']) : null,
      field: json['field'] != null ? Field.fromJson(json['field']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (individual != null) {
      data['individual'] = individual!.toJson();
    }
    if (team != null) {
      data['team'] = team!.toJson();
    }
    if (field != null) {
      data['field'] = field!.toJson();
    }
    return data;
  }
}

class Individual {
  String? type;
  String? price;
  String? discount;
  Coupon? coupon;

  Individual({this.type, this.price, this.discount, this.coupon});

  factory Individual.fromJson(Map<String, dynamic> json) {
    return Individual(
      type: json['type'],
      price: json['Price'],
      discount: json['discount'],
      coupon: json['coupon'] != null ? Coupon.fromJson(json['coupon']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'type': type,
      'Price': price,
      'discount': discount,
    };
    if (coupon != null) {
      data['coupon'] = coupon!.toJson();
    }
    return data;
  }
}

class Team {
  String? type;
  String? price;
  String? discount;
  Coupon? coupon;

  Team({this.type, this.price, this.discount, this.coupon});

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      type: json['type'],
      price: json['Price'],
      discount: json['discount'],
      coupon: json['coupon'] != null ? Coupon.fromJson(json['coupon']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'type': type,
      'Price': price,
      'discount': discount,
    };
    if (coupon != null) {
      data['coupon'] = coupon!.toJson();
    }
    return data;
  }
}

class Field {
  String? type;
  String? price;
  String? discount;
  Coupon? coupon;

  Field({this.type, this.price, this.discount, this.coupon});

  factory Field.fromJson(Map<String, dynamic> json) {
    return Field(
      type: json['type'],
      price: json['Price'],
      discount: json['discount'],
      coupon: json['coupon'] != null ? Coupon.fromJson(json['coupon']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'type': type,
      'Price': price,
      'discount': discount,
    };
    if (coupon != null) {
      data['coupon'] = coupon!.toJson();
    }
    return data;
  }
}

class Coupon {
  bool? allow;
  bool? showCoupon;
  List<ValidCoupon>? validCoupon;

  Coupon({this.allow, this.showCoupon, this.validCoupon});

  factory Coupon.fromJson(Map<String, dynamic> json) {
    return Coupon(
      allow: json['allow'],
      showCoupon: json['showCoupon'],
      validCoupon: json['validCoupon'] != null
          ? List<ValidCoupon>.from(
              json['validCoupon'].map((v) => ValidCoupon.fromJson(v)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'allow': allow,
      'showCoupon': showCoupon,
    };
    if (validCoupon != null) {
      data['validCoupon'] = validCoupon!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ValidCoupon {
  String? code;
  String? value;
  String? expiry;

  ValidCoupon({this.code, this.value, this.expiry});

  factory ValidCoupon.fromJson(Map<String, dynamic> json) {
    return ValidCoupon(
      code: json['code'],
      value: json['value'],
      expiry: json['expiry'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'code': code,
      'value': value,
      'expiry': expiry,
    };
    return data;
  }
}
