import '../helpers/custom_trace.dart';
import '../models/media.dart';

enum UserState { available, away, busy }

class User {
  String id;
  String name;
  String email;
  String password;
  String apiToken;
  String deviceToken;
  String phone;
  String address;
  String otp;
 // String bio;
  Media image;

  // used for indicate if client logged in or not
  bool auth;

//  String role;

  User();

  User.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'].toString();
      name = jsonMap['username'] != null ? jsonMap['username'] : '';
      email = jsonMap['email'] != null ? jsonMap['email'] : '';
      apiToken = jsonMap['api_token'];
      otp = jsonMap['OTP'];
      phone=jsonMap['number'];
      //deviceToken = jsonMap['device_token'];
      // try {
      //   phone = jsonMap['custom_fields']['number'];
      // } catch (e) {
      //   phone = "";
      // }
      try {
        address = jsonMap['custom_fields']['address'];
      } catch (e) {
        address = "";
      }
      // try {
      //  // bio = jsonMap['custom_fields']['bio']['view'];
      // } catch (e) {
      //   bio = "";
      // }
      image = jsonMap['media'] != null && (jsonMap['media'] as List).length > 0 ? Media.fromJSON(jsonMap['media'][0]) : new Media();
    } catch (e) {
      print(CustomTrace(StackTrace.current, message: e));
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["email"] = email;
    map["username"] = name;
    map["password"] = password;
    map["OTP"] = otp;
    map["api_token"] = apiToken;

    map["number"] = phone;
    map["address"] = address;
  //  map["bio"] = bio;
    map["media"] = image?.toMap();
    return map;
  }

  Map toRestrictMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["email"] = email;
    map["username"] = name;
    map["thumb"] = image?.thumb;

    return map;
  }

  @override
  String toString() {
    var map = this.toMap();
    map["auth"] = this.auth;
    return map.toString();
  }

  bool profileCompleted() {
    return address != null && address != '' && phone != null && phone != '';
  }
}
