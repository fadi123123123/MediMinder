class MedicineModel {
  String name;
  double dosage;
  String startTime;
  String startDate;
  String endDate;
  int reminder;

  MedicineModel({
    this.name,
    this.dosage,
    this.startDate,
    this.startTime,
    this.endDate,
    this.reminder,
  });
  MedicineModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    dosage = json['dosage'];
    startDate = json['startDate'];
    startTime = json['startTime'];
    endDate = json['endDate'];
    reminder = json['reminder'];
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'dosage': dosage,
      'startDate': startDate,
      'endDate': endDate,
      'reminder': reminder,
    };
  }
}
