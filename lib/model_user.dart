class SocialUserModel {
  String name;
  String email;
  String phone;
  String uId;
  String isDoctor;
  Map<String, String> listOfDoctor;

  SocialUserModel({
    this.name,
    this.email,
    this.phone,
    this.uId,
    this.isDoctor,
    this.listOfDoctor,
  });
  SocialUserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    uId = json['uId'];
    isDoctor = json['isDoctor'];
    listOfDoctor = new Map<String, String>.from(json['listOfDoctor']);
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
      'isDoctor': isDoctor,
      'listOfDoctor': listOfDoctor,
    };
  }
}
