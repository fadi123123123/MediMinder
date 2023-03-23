import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pro/shared/alarm_info.dart';
import 'package:pro/shared/cubit.dart';
import 'package:pro/shared/login_cubit.dart';
import 'package:pro/shared/login_state.dart';
import 'package:pro/shared/states.dart';
import 'package:pro/utilites/ToolsUtilites.dart';

class AddMedicine extends StatefulWidget {
  @override
  _AddMedicineState createState() => _AddMedicineState();
}

class _AddMedicineState extends State<AddMedicine> {
  TextEditingController medicine_name = TextEditingController();
  TextEditingController _dosage_in_mg = TextEditingController();
  TextEditingController _number_of_bills = TextEditingController();
  TextEditingController _picker_start_time = TextEditingController();
  TextEditingController _picker_start_date = TextEditingController();
  TextEditingController _picker_end_date = TextEditingController();
  TextEditingController number_of_hourse = TextEditingController();
  var formKey = GlobalKey<FormState>();

  var flutterLocalNotificationsPlugin;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (BuildContext context, LoginStates state) {
          /* if (state is AppCreateDatabaseLoddingState) {
            //Navigator.pop(context);
            //AppGetDatabaseState()
            //AppInsertDatabaseState
          }*/
        },
        builder: (BuildContext context, LoginStates state) {
          LoginCubit cubit = LoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text('Add New Medicine'),
            ),
            body: state is AppCreateDatabaseLoddingState
                ? CircularProgressIndicator(
                    strokeWidth: 1.0,
                    backgroundColor: ToolsUtilites.mainColor,
                  )
                : Container(
                    color: ToolsUtilites.whiteColor,
                    child: SingleChildScrollView(
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //Medicine Name
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0,
                                  right: 8.0,
                                  bottom: 25.0,
                                  top: 8.0),
                              child: TextFormField(
                                style: TextStyle(
                                  color: ToolsUtilites.secondColor,
                                ),
                                maxLines: 1,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Medicine Name must not be empty';
                                  }
                                  return null;
                                },
                                controller: medicine_name,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ToolsUtilites.mainColor),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.text_format,
                                    color: ToolsUtilites.mainColor,
                                  ),
                                  labelText: "Medicine Name",
                                  labelStyle:
                                      TextStyle(color: ToolsUtilites.mainColor),
                                ),
                                keyboardType: TextInputType.name,
                              ),
                            ),

                            //Dosage in mg
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0,
                                  right: 8.0,
                                  bottom: 25.0,
                                  top: 8.0),
                              child: TextFormField(
                                style: TextStyle(
                                  color: ToolsUtilites.secondColor,
                                ),
                                maxLines: 1,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Dosage in mg must not be empty';
                                  }
                                  return null;
                                },
                                controller: _dosage_in_mg,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ToolsUtilites.mainColor),
                                  ),
                                  prefixIcon: Icon(
                                    FontAwesomeIcons.pills,
                                    color: ToolsUtilites.mainColor,
                                  ),
                                  labelText: "Dosage in mg",
                                  labelStyle:
                                      TextStyle(color: ToolsUtilites.mainColor),
                                ),
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: true),
                                /*inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(filterPattern)
                          ],*/
                              ),
                            ),

                            //_picker_Start_time
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0,
                                  right: 8.0,
                                  bottom: 25.0,
                                  top: 8.0),
                              child: TextFormField(
                                readOnly: true,
                                style: TextStyle(
                                  color: ToolsUtilites.secondColor,
                                ),
                                maxLines: 1,
                                controller: _picker_start_time,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Start Time must not be empty';
                                  }
                                  return null;
                                },
                                onTap: () {
                                  showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  ).then((value) {
                                    _picker_start_time.text =
                                        value.format(context).toString();
                                    print(value.format(context));
                                  });
                                },
                                decoration: InputDecoration(
                                  // hoverColor: ToolsUtilites.whiteColor,
                                  //focusColor: ToolsUtilites.whiteColor,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ToolsUtilites.mainColor),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.watch_later,
                                    color: ToolsUtilites.mainColor,
                                  ),
                                  labelText: "Start Time",
                                  labelStyle:
                                      TextStyle(color: ToolsUtilites.mainColor),
                                ),
                              ),
                            ),
                            //_picker_start_date
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0,
                                  right: 8.0,
                                  bottom: 25.0,
                                  top: 8.0),
                              child: TextFormField(
                                readOnly: true,
                                style: TextStyle(
                                  color: ToolsUtilites.secondColor,
                                ),
                                maxLines: 1,
                                controller: _picker_start_date,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Start Date must not be empty';
                                  }
                                  return null;
                                },
                                onTap: () {
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.parse('2021-10-03'),
                                  ).then((value) {
                                    _picker_start_date.text =
                                        DateFormat.yMMMd().format(value);
                                    print(DateFormat.yMMMd().format(value));
                                  });
                                },
                                decoration: InputDecoration(
                                  // hoverColor: ToolsUtilites.whiteColor,
                                  //focusColor: ToolsUtilites.whiteColor,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: ToolsUtilites.mainColor,
                                    ),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.date_range,
                                    color: ToolsUtilites.mainColor,
                                  ),
                                  labelText: "Start Date",
                                  labelStyle:
                                      TextStyle(color: ToolsUtilites.mainColor),
                                ),
                                keyboardType: TextInputType.datetime,
                                /*inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],*/
                              ),
                            ),

                            //_picker_end_date
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0,
                                  right: 8.0,
                                  bottom: 25.0,
                                  top: 8.0),
                              child: TextFormField(
                                readOnly: true,
                                style: TextStyle(
                                  color: ToolsUtilites.secondColor,
                                ),
                                maxLines: 1,
                                controller: _picker_end_date,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'end Date must not be empty';
                                  }
                                  return null;
                                },
                                onTap: () {
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.parse('2021-10-03'),
                                  ).then((value) {
                                    _picker_end_date.text =
                                        DateFormat.yMMMd().format(value);
                                    print(DateFormat.yMMMd().format(value));
                                  });
                                },
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: ToolsUtilites.mainColor,
                                    ),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.date_range,
                                    color: ToolsUtilites.mainColor,
                                  ),
                                  labelText: "End Date",
                                  labelStyle:
                                      TextStyle(color: ToolsUtilites.mainColor),
                                ),
                                keyboardType: TextInputType.datetime,
                              ),
                            ),
                            //Remind me every
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0,
                                  right: 8.0,
                                  bottom: 25.0,
                                  top: 8.0),
                              child: TextFormField(
                                //readOnly: true,
                                style: TextStyle(
                                  color: ToolsUtilites.secondColor,
                                ),
                                maxLines: 1,
                                controller: number_of_hourse,
                                keyboardType: TextInputType.number,
                                onChanged: (String value) {},
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Remind me every must not be empty';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  // hoverColor: ToolsUtilites.whiteColor,
                                  //focusColor: ToolsUtilites.whiteColor,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: ToolsUtilites.mainColor,
                                    ),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.watch,
                                    color: ToolsUtilites.mainColor,
                                  ),
                                  labelText: "Remind me every ",
                                  labelStyle:
                                      TextStyle(color: ToolsUtilites.mainColor),
                                ),
                              ),
                            ),
                            //Number of bills
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0,
                                  right: 8.0,
                                  bottom: 25.0,
                                  top: 8.0),
                              child: TextFormField(
                                //readOnly: true,
                                style: TextStyle(
                                  color: ToolsUtilites.secondColor,
                                ),
                                maxLines: 1,
                                controller: _number_of_bills,
                                keyboardType: TextInputType.number,
                                onChanged: (String value) {},
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Remind me every must not be empty';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  // hoverColor: ToolsUtilites.whiteColor,
                                  //focusColor: ToolsUtilites.whiteColor,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: ToolsUtilites.mainColor,
                                    ),
                                  ),
                                  prefixIcon: Icon(
                                    FontAwesomeIcons.pills,
                                    color: ToolsUtilites.mainColor,
                                  ),
                                  labelText: "Number of pills: ",
                                  labelStyle:
                                      TextStyle(color: ToolsUtilites.mainColor),
                                ),
                              ),
                            ),

                            //button Confirm
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0, bottom: 8.0, left: 80, right: 80),
                              child: Container(
                                width: 200,
                                height: 60,
                                child: state is AppGetDatabaseLoadingState
                                    ? CircularProgressIndicator(
                                        strokeWidth: 1.0,
                                        backgroundColor:
                                            ToolsUtilites.mainColor,
                                      )
                                    : FlatButton(
                                        color: ToolsUtilites.greenColor,
                                        shape: StadiumBorder(),
                                        onPressed: () async {
                                          if (formKey.currentState.validate()) {
                                            /*cubit.insertToDatabase(
                                              name:
                                                  'fadi', //_medicine_name.text,
                                              dosage: 3.5,
                                              /*double.parse(
                                                    _dosage_in_mg.text),*/
                                              starttime:
                                                  '${_picker_start_time.text}',
                                              startDate:
                                                  '${_picker_start_date.text}',
                                              endDate:
                                                  '${_picker_end_date.text}',
                                              reminder:
                                                  3, /*int.parse(
                                                    number_of_hourse.text)*/
                                            );*/
                                            await cubit.addMedicineData(
                                              name: medicine_name.text ?? '0',
                                              dosage: double.parse(
                                                      _dosage_in_mg.text) ??
                                                  0,
                                              startTime:
                                                  '${_picker_start_time.text}',
                                              startDate:
                                                  '${_picker_start_date.text}',
                                              endDate:
                                                  '${_picker_end_date.text}',
                                              reminder: int.parse(
                                                      number_of_hourse.text) ??
                                                  0,
                                            );
                                            //Navigator.of(context).pop();

                                            print('true');
                                          }
                                        },
                                        child: Center(
                                          child: Text(
                                            "Confirm",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 28,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }
}
/*Widget _customTextFiled(int maxLine, TextEditingController controller,
      String hintName, AppCubit c) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 25.0, top: 8.0),
      child: TextField(
        style: TextStyle(color: ToolsUtilites.secondColor),
        maxLines: maxLine,
        controller: controller,
        decoration: InputDecoration(
          hoverColor: ToolsUtilites.whiteColor,
          focusColor: ToolsUtilites.whiteColor,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ToolsUtilites.mainColor),
          ),
          labelText: hintName,
          labelStyle: TextStyle(color: ToolsUtilites.mainColor),
        ),
      ),
    );
  }

  void scheduleAlarm(
      DateTime scheduledNotificationDateTime, AlarmInfo alarmInfo) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      'Channel for Alarm notification',
      icon: 'codex_logo',
      sound: RawResourceAndroidNotificationSound('a_long_cold_sting'),
      largeIcon: DrawableResourceAndroidBitmap('codex_logo'),
    );

    var iOSPlatformChannelSpecifics = IOSNotificationDetails(
        sound: 'a_long_cold_sting.wav',
        presentAlert: true,
        presentBadge: true,
        presentSound: true);
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    var platformChannel = NotificationDetails();
    await flutterLocalNotificationsPlugin.show(
        0, 'Office', 'Daily Test Body', platformChannel,
        payload: 'New Payload');
  }
}*/
//class AddMedicine extends StatelessWidget {
//bool t = CubitThemeMode.get(context).isDark;
/* TextEditingController _medicine_name = TextEditingController();
  TextEditingController _dosage_in_mg = TextEditingController();
  TextEditingController _number_of_bills = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {},
        builder: (BuildContext context, AppStates state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text('Add Medicine'),
            ),
            body: Container(
              decoration: BoxDecoration(
                color: AppCubit.get(context).isDark
                    ? ToolsUtilites.secondColor
                    : ToolsUtilites.whiteColor, //cubit.colorModeBackground(),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _customTextFiled(1, _medicine_name, "Medicine Name", cubit),
                    _customTextFiled(1, _dosage_in_mg, "Dosage in mg", cubit),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8.0, bottom: 25.0, top: 8.0),
                      child: TextField(
                        style: TextStyle(
                          color: Colors.redAccent,
                        ),
                        maxLines: 1,
                        controller: _number_of_bills,
                        decoration: InputDecoration(
                          // hoverColor: ToolsUtilites.whiteColor,
                          //focusColor: ToolsUtilites.whiteColor,
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: ToolsUtilites.mainColor),
                          ),
                          labelText: "Number of Bills",
                          labelStyle: TextStyle(color: ToolsUtilites.mainColor),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),

                    //_customTextFiled(1, _number_of_bills, "Number of Bills"),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
*/

//}
