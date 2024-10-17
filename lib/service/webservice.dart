import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:mvvm/model/registrationmodel.dart';
import 'package:http/http.dart' as http;
import '../model/loginmodel.dart';

class webService {
  String baseUrl = "http://192.168.213.87:8080/WebApplication1/";
  Future<Map<String, dynamic>> login(
    String username,
    String password,
  ) async {
    print('webservice');
    print(username);
    print(password);
    var result;
    final Map<String, dynamic> loginData = {
      'username': username,
      'password': password,
    };

    final response = await http.post(
      Uri.parse(baseUrl + "/login.jsp"),
      body: loginData,
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      // print(response.body);

      var userData = responseData;
      print(userData);

      loginModel ws = loginModel.fromJson(userData);

      result = {'status': true, 'message': 'Successful', 'user': ws};
      print("web res>>>>>>>>>" + result.toString());
    } else {
      result = {
        'status': false,
        'message': json.decode(response.body)['error']
      };
    }
    return result;
  }

  //  REGISTER
  Future<String> register(
      String name, String Username, String mobile, String Password) async {
    var result;
    print("nameeeee===" + name);
    print("Usernameeee===" + Username);
    print("phone no===" + mobile);
    print("pas===" + Password);
    final Map<String, dynamic> registerData = {
      'name': name,
      'username': Username,
      'mobile': mobile,
      'password': Password,
    };
    print("reg data===" + Password);
    //  final url = "http://192.168.39.118:8080/communityApp/login.jsp";
    // final response = await http.post(
    //   Uri.parse(baseUrl + "/register.jsp"),
    //   body: registerData,
    // );

    final response = await http.post(
      Uri.parse('http://192.168.213.87:8080/WebApplication1/register.jsp'),
      body: registerData,
    );
    if (response.statusCode == 200) {
      log("hiiii");
      log(response.body);
    } else {
      log(" Register Error");
    }
    return response.body;
  }

  Future<List<RegModel>?> dataItem() async {
    try {
      final url = baseUrl + "viewusers.jsp";
      final response = await http.get(Uri.parse(url));
      // var result;

      if (response.statusCode == 200) {
        print("saasasa===" + response.body.toString());
        final body = jsonDecode(response.body);
        final Iterable json = body;
        print("response:_____________________" + body.toString());
        return json.map((item) => RegModel.fromJson(item)).toList();
      } else {
        throw Exception("Unable to perform request!");
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
