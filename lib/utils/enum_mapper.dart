import 'package:mygame/core/user_type.dart';

UserType enumMapper(String type) {
  if (type == "user") {
    return UserType.player;
  } else if (type == "business") {
    return UserType.business;
  } else if (type == "admin") {
    return UserType.admin;
  } else {
    return UserType.noStatus;
  }
}
