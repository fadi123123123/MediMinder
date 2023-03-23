class AlarmInfo {
  int id;
  String title;
  int reminder;
  DateTime alarmDateTime;
  bool isPending;
  int gradientColorIndex;

  AlarmInfo(
      {this.id,
      this.title,
      this.reminder,
      this.alarmDateTime,
      this.isPending,
      this.gradientColorIndex});

  factory AlarmInfo.fromMap(Map<String, dynamic> json) => AlarmInfo(
        id: json["id"],
        title: json["title"],
        reminder: json['reminder'],
        alarmDateTime: DateTime.parse(json["alarmDateTime"]),
        isPending: json["isPending"],
        gradientColorIndex: json["gradientColorIndex"],
      );
  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "reminder": reminder,
        "alarmDateTime": alarmDateTime.toIso8601String(),
        "isPending": isPending,
        "gradientColorIndex": gradientColorIndex,
      };
}
