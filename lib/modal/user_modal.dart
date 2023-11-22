class UserModal {
  String? key;
  UserData userData;

  UserModal({this.key, required this.userData});
}

class UserData {
  String? email;
  String? password;
  String? fullname;
  String? birth;
  String? cmnd;
  String? sdt;

  UserData(
      {this.email,
      this.password,
      this.fullname,
      this.birth,
      this.cmnd,
      this.sdt});

  UserData.fromJson(Map<dynamic, dynamic> json) {
    email = json["email"];
    password = json["password"];
    fullname = json["fullName"];
    birth = json["birth"];
    cmnd = json["CMND"];
    sdt = json["SDT"];
  }
}
