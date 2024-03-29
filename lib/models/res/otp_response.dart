class OtpResponse {
  String? Status;
  String? Details;

  OtpResponse({required this.Status, required this.Details});

  // Named constructor for creating an instance from a JSON map
  factory OtpResponse.fromJson(Map<String, dynamic> json) {
    return OtpResponse(
      Status: json['Status'],
      Details: json['Details'],
    );
  }

  // Named constructor for creating an instance from a map
  factory OtpResponse.fromMap(Map<String, dynamic> map) {
    return OtpResponse(
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
