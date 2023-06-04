import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class User  {

  User._privateConstructor();
  static final User _instance  = User._privateConstructor();

  String id = '';
  String phone = '';
  String password = '';
  String note = '';

  factory User() {
    return _instance ;
  }

  Future <BackendMessage> loginToBackend(String phone, String password) async {
    Response response = await post(Uri.parse("http://technolab4iot.us-east-1.elasticbeanstalk.com/class_bell/user_login.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Control-Allow-Origin': '*'
        },
        body: jsonEncode({'phone': phone, 'password': password}));

    var jsonResponse = jsonDecode(response.body);
    debugPrint("jsonResponse: " + jsonResponse.toString());
    if (jsonResponse['status'] == "success") {
      this.id = jsonResponse['message']['id'].toString();
      this.phone = jsonResponse['message']['phone'].toString();
      this.password = jsonResponse['message']['password'].toString();
      this.note = jsonResponse['message']['note'].toString();
    }

    return BackendMessage(jsonResponse['status'].toString(), jsonResponse['message'].toString());
  }


  Future <BackendMessage> addClass(String name, String note, String startTime, String endTime) async {
    Response response = await post(Uri.parse("http://technolab4iot.us-east-1.elasticbeanstalk.com/class_bell/add_class.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Control-Allow-Origin': '*'
        },
        body: jsonEncode( { 'user_id': this.id, 'class_number': name, 'note': note, 'start_time': startTime, 'end_time': endTime, }));

    var jsonResponse = jsonDecode(response.body);

    return BackendMessage(jsonResponse['status'].toString(), jsonResponse['message'].toString());
  }

  Future <BackendMessage> editClass(String classId, String name, String note, String startTime, String endTime) async {
    Response response = await post(Uri.parse("http://technolab4iot.us-east-1.elasticbeanstalk.com/class_bell/edit_class.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Control-Allow-Origin': '*'
        },
        body: jsonEncode( { 'user_id': this.id, 'class_id': classId, 'class_number': name, 'note': note, 'start_time': startTime, 'end_time': endTime, }));

    var jsonResponse = jsonDecode(response.body);

    return BackendMessage(jsonResponse['status'].toString(), jsonResponse['message'].toString());
  }

  Future <BackendMessage> deleteClass(String classId) async {
    Response response = await post(Uri.parse("http://technolab4iot.us-east-1.elasticbeanstalk.com/class_bell/delete_class.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Control-Allow-Origin': '*'
        },
        body: jsonEncode( { 'user_id': this.id, 'class_id': classId, }));

    var jsonResponse = jsonDecode(response.body);

    return BackendMessage(jsonResponse['status'].toString(), jsonResponse['message'].toString());
  }

  Future <dynamic> showUserClasses() async {
    Response response = await post(Uri.parse("http://technolab4iot.us-east-1.elasticbeanstalk.com/class_bell/user_classes.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Control-Allow-Origin': '*'
        },
        body: jsonEncode( { 'id': this.id, }));

    var jsonResponse = jsonDecode(response.body);
    return jsonResponse;
    return BackendMessage(jsonResponse['status'].toString(), jsonResponse['message'].toString());
  }
}

class BackendMessage {
  String status = '';
  String message = '';

  BackendMessage(this.status, this.message);
}

class NotificationMessage {
  String title = '';
  String body = '';
  dynamic payload;

  NotificationMessage(this.title, this.body, this.payload);
}