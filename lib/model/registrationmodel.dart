
class RegModel {
  final String? name;
  final String? phone;
  final String? password;
  final String? username;

  RegModel({this.name, this.phone,this.password,this.username});

  factory RegModel.fromJson(Map<String, dynamic> Json) {
    return RegModel(
      name: Json['name'],
      phone: Json['phone'],
    );
  }
}

