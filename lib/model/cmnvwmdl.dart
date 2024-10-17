import 'package:flutter/cupertino.dart';
import 'package:mvvm/model/registrationmodel.dart';
import 'package:mvvm/service/webservice.dart';

class CommonViewModel extends ChangeNotifier {
  Future<Map<String, dynamic>> login(String username, String password) async {
    final result = await webService().login(username, password);
    print(">>>result $result");
    return result;
  }

  Future<String> register(
      String name, String Username, String phone, String Password) async {
    print("object");
    print("name==" + name);
    print("Username==" + Username);
    print("phone==" + phone);
    print("Password==" + Password);
    final result = await webService().register(name, Username, phone, Password);
    print(">>>result $result");
    return result;
  }

  List<RegModel> user = [];
  getusers() async {
    user = (await webService().dataItem())!; 
    notifyListeners();
    return user;
  }
}

