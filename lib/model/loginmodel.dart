class loginModel {
  final String msg;
  final String username;
  final String password;

  loginModel({required this.msg,required this.username,required this.password});

  factory loginModel.fromJson(Map<String, dynamic> Json) {
    return loginModel(
      msg: Json['msg'], password:Json['password'], username: Json['username'],
    );
  }
}
