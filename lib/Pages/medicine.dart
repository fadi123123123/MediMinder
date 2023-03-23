import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro/Pages/add_medicine.dart';
import 'package:pro/Pages/medicine_card.dart';
import 'package:pro/shared/cubit.dart';
import 'package:pro/shared/states.dart';
import 'package:pro/utilites/ToolsUtilites.dart';

class PageMedicine extends StatefulWidget {
  @override
  _PageMedicineState createState() => _PageMedicineState();
}

class _PageMedicineState extends State<PageMedicine> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
          listener: (BuildContext context, AppStates state) {
        if (state is AppCreateDatabaseLoddingState) {
          CircularProgressIndicator(
            strokeWidth: 1.0,
            backgroundColor: ToolsUtilites.mainColor,
          );
        }
      }, builder: (BuildContext context, AppStates state) {
        AppCubit cubit = AppCubit.get(context);
        //var tasks = AppCubit.get(context).newTasks;

        return Scaffold(
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              elevation: 10.0,
              child: Icon(
                Icons.add,
              ),
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddMedicine()),
                );
              },
            ),
          ),
          body: Center(
            child: Stack(
              overflow: Overflow.clip,
              children: <Widget>[
                /*Center(
                  child: state is AppCreateDatabaseLoddingState
                      ? Text(
                          'Press + to add a Medicine${cubit.iii}',
                          style: TextStyle(fontSize: 30, color: Colors.grey),
                        )
                      : CircularProgressIndicator(
                          strokeWidth: 1.0,
                          backgroundColor: ToolsUtilites.mainColor,
                        ),
                ),*/
                Container(
                  height: MediaQuery.of(context).size.height,
                  //height: 250,
                  child: ListView.builder(
                    itemCount: cubit.newTasks.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      //var tasks = cubit.newTasks;
                      return Dismissible(
                        key: ObjectKey(index),
                        onDismissed: (direction) {
                          print(direction.index);
                          //write method for delete
                        },
                        child: MedicineCard(
                          id: index,
                          task: cubit.newTasks[index],
                          name: cubit.newTasks[index]['name'],
                          starttime: cubit.newTasks[index]['starttime'],
                          endDate: cubit.newTasks[index]['endDate'],
                          //id: index,
                          // i: images[index],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
