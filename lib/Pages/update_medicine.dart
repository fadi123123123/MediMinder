import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pro/shared/cubit.dart';
import 'package:pro/shared/states.dart';
import 'package:pro/utilites/ToolsUtilites.dart';

class UpdateMedicine extends StatefulWidget {
  const UpdateMedicine(
      {Key key,
      @required this.name,
      @required this.time,
      @required this.date,
      @required this.dosage,
      @required this.hourse})
      : super(key: key);

  final String name;
  final String time;
  final String date;
  final int dosage;
  final int hourse;
  @override
  _UpdateMedicineState createState() => _UpdateMedicineState();
}

class _UpdateMedicineState extends State<UpdateMedicine> {
  final ubdateMedicineKey = GlobalKey<ScaffoldState>();
  TextEditingController _medicine_name = TextEditingController();
  TextEditingController _dosage_in_mg = TextEditingController();
  TextEditingController _number_of_bills = TextEditingController();
  TextEditingController _picker_time = TextEditingController();
  TextEditingController _picker_date = TextEditingController();
  TextEditingController number_of_hourse = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {},
        builder: (BuildContext context, AppStates state) {
          //AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text('Update Medicine'),
            ),
            body: Container(
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
                            left: 8.0, right: 8.0, bottom: 25.0, top: 8.0),
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
                          controller: _medicine_name,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: ToolsUtilites.mainColor),
                            ),
                            prefixIcon: Icon(
                              Icons.text_format,
                              color: ToolsUtilites.mainColor,
                            ),
                            hintText: widget.name,
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
                            left: 8.0, right: 8.0, bottom: 25.0, top: 8.0),
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
                              borderSide:
                                  BorderSide(color: ToolsUtilites.mainColor),
                            ),
                            prefixIcon: Icon(
                              FontAwesomeIcons.pills,
                              color: ToolsUtilites.mainColor,
                            ),
                            labelText: "Dosage in mg",
                            labelStyle:
                                TextStyle(color: ToolsUtilites.mainColor),
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),

                      //_picker_Start_time
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8.0, bottom: 25.0, top: 8.0),
                        child: TextFormField(
                          readOnly: true,
                          style: TextStyle(
                            color: ToolsUtilites.secondColor,
                          ),
                          maxLines: 1,
                          controller: _picker_time,
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
                              _picker_time.text =
                                  value.format(context).toString();
                              print(value.format(context));
                            });
                          },
                          decoration: InputDecoration(
                            // hoverColor: ToolsUtilites.whiteColor,
                            //focusColor: ToolsUtilites.whiteColor,
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: ToolsUtilites.mainColor),
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
                      //_picker_date
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8.0, bottom: 25.0, top: 8.0),
                        child: TextFormField(
                          readOnly: true,
                          style: TextStyle(
                            color: ToolsUtilites.secondColor,
                          ),
                          maxLines: 1,
                          controller: _picker_date,
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
                              _picker_date.text =
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
                      //Remind me every
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8.0, bottom: 25.0, top: 8.0),
                        child: TextFormField(
                          // readOnly: true,
                          style: TextStyle(
                            color: ToolsUtilites.secondColor,
                          ),
                          maxLines: 1,
                          controller: number_of_hourse,
                          // keyboardType: TextInputType.number,
                          // onChanged: (String value) {},
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
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, bottom: 8.0, left: 80, right: 80),
                        child: Container(
                          width: 200,
                          height: 60,
                          child: FlatButton(
                            color: ToolsUtilites.greenColor,
                            shape: StadiumBorder(),
                            onPressed: () {
                              if (formKey.currentState.validate()) {
                                print('true');
                              }
                              /* else {
                                Navigator.pop(context);
                                ubdateMedicineKey.currentState.showSnackBar(
                                  SnackBar(
                                    content: Text(''),
                                  ),
                                );
                              }*/
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

  /*Widget _customTextFiled(int maxLine, TextEditingController controller,
      String hintName, AppCubit c) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 25.0, top: 8.0),
      child: TextField(
        style: TextStyle(
          color: ToolsUtilites.secondColor,
        ),
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
  }*/
}
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
