class SocialDoctorModel {
  String name;
  String email;
  String phone;
  String uId;
  Map<String, String> listOfDoctor;
  Map<String, String> listOfPatient;
  //Map<String, String> listOfPatient;
  // String specialization;
  String isDoctor;

  SocialDoctorModel({
    this.name,
    this.email,
    this.phone,
    this.uId,
    this.listOfDoctor,
    this.listOfPatient,
    //this.specialization,
    this.isDoctor,
  });
  SocialDoctorModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    uId = json['uId'];
    isDoctor = json['isDoctor'];
    listOfDoctor = new Map<String, String>.from(json['listOfDoctor']);
    listOfPatient = new Map<String, String>.from(json['listOfPatient']);
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
      'listOfDoctor': listOfDoctor,
      'listOfPatient': listOfPatient,
      //'specialization': specialization,
      'isDoctor': isDoctor,
    };
  }
}
