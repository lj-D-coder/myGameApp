class OtpResponse {
  String? Status;
  String? Details;

  OtpResponse({required this.Status, required Details});

  factory OtpResponse.fromJson(json) {
    return OtpResponse(Status: json["Status"], Details: json["Details"]);
  }
}
