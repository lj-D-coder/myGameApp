class OtpVerifyResponse {
  String? Status;
  String? Details;

  OtpVerifyResponse({required this.Status, required this.Details});

  // Named constructor for creating an instance from a JSON map
  factory OtpVerifyResponse.fromJson(Map<String, dynamic> json) {
    return OtpVerifyResponse(
      Status: json['Status'],
      Details: json['Details'],
    );
  }

  // Named constructor for creating an instance from a map
  factory OtpVerifyResponse.fromMap(Map<String, dynamic> map) {
    return OtpVerifyResponse(
      Status: map['Status'],
      Details: map['Details'],
    );
  }

  // Convert the object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'Status': Status,
      'Details': Details,
    };
  }
}
