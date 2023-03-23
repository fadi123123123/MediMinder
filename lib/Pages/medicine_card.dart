import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pro/Pages/update_medicine.dart';
import 'package:pro/shared/cubit.dart';
import 'package:pro/shared/states.dart';
import 'package:pro/utilites/ToolsUtilites.dart';

class MedicineCard extends StatelessWidget {
  const MedicineCard({
    Key key,
    @required this.id,
    @required this.task,
    @required this.name,
    @required this.starttime,
    @required this.endDate,
    /*
      @required this.time,
      @required this.date,
      @required this.dosage,
      @required this.hourse*/
  }) : super(key: key);

  final int id;
  final Map task;
  final String name;
  final String starttime;
  final String endDate;

  /*final String name;
  final String time;
  final String date;
  final int dosage;
  final int hourse;
*/
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {},
        builder: (BuildContext context, AppStates state) {
          //AppCubit cubit = AppCubit.get(context);
          var tasks = AppCubit.get(context).newTasks;
          return InkWell(
            onTap: () {
              /* Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => UpdateMedicine(
                        name: name,
                        time: time,
                        date: date,
                        dosage: dosage,
                        hourse: hourse)));*/
            },
            child: Container(
              width: 200,
              child: Padding(
                padding: const EdgeInsets.only(top: 18.0, left: 5),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),

                                //image: DecorationImage(
                                //  image: AssetImage(i), fit: BoxFit.cover),
                              ),
                              child: CircleAvatar(
                                  backgroundColor: ToolsUtilites.whiteColor,
                                  radius: 60.0,
                                  child: Icon(
                                    FontAwesomeIcons.pills,
                                    size: 40,
                                    color: ToolsUtilites.mainColor,
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(name, //task[id]['name'], //.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.indigo)),
                                  SizedBox(
                                    height: 6.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(starttime, //task[id]
                                        //['starttime'], //tasks[id]['dosage']
                                        style: TextStyle(color: Colors.red)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text("endDate:", //tasks[id]['starttime'],
                                style: TextStyle(color: Colors.black)),
                            //endDate
                            Text(
                                endDate, //task[id]['endDate'], //tasks[id]['starttime'],
                                style: TextStyle(color: Colors.indigo)),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Divider(
                        thickness: 0.7,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
