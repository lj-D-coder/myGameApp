class SignUpRequest {
  String? loginId;
  String? userName;
  String? phoneNo;
  String? email;
  String? userRole;

  SignUpRequest(
      {this.loginId, this.userName, this.phoneNo, this.email, this.userRole});

  Map<String, dynamic> toJson() {
    return {
      'loginId': loginId,
      'userName': userName,
      'phoneNo': phoneNo,
      'email': email,
      'userRole': userRole
    };
  }
}
