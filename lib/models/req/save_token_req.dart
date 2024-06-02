class FirebaseSaveTokenReq {
  String? userId;
  String? firebaseToken;

  FirebaseSaveTokenReq({
    this.userId,
    this.firebaseToken,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'firebaseToken': firebaseToken,
    };
  }
}
