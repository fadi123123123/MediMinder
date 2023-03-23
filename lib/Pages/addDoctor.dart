import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro/constants.dart';
import 'package:pro/shared/login_cubit.dart';
import 'package:pro/shared/login_state.dart';

import 'package:pro/utilites/ToolsUtilites.dart';
import 'package:pro/widget/doctor_card.dart';

class AddDoctor extends StatefulWidget {
  //const AddDoctor({ Key? key }) : super(key: key);

  @override
  _AddDoctorState createState() => _AddDoctorState();
}

class _AddDoctorState extends State<AddDoctor> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (BuildContext context, LoginStates state) {
        if (state is SocialGetAllDoctorLoadingState ||
            LoginCubit.get(context).doctorsOfFirebase.length <= 0) {
          CircularProgressIndicator(
            strokeWidth: 1.0,
            backgroundColor: ToolsUtilites.mainColor,
          );
        }
      },
      builder: (BuildContext context, LoginStates state) {
        LoginCubit cubit = LoginCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('Add Doctor'),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                state is SocialGetAllDoctorLoadingState
                    //cubit.doctorsOfFirebase != null
                    ? Padding(
                        padding: const EdgeInsets.only(top: 200, bottom: 200.0),
                        child: Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2.0,
                            backgroundColor: ToolsUtilites.mainColor,
                          ),
                        ),
                      )
                    : Container(
                        height: MediaQuery.of(context).size.height,
                        //height: 250,
                        child: ListView.builder(
                          itemCount: cubit.doctorsOfFirebase.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            //cubit.getAllDoctor();
                            //var tasks = cubit.newTasks;
                            return uId != cubit.doctorsOfFirebase[index].uId
                                ? DoctorCard(
                                    id: index,
                                    name: cubit.doctorsOfFirebase[index].name,
                                    phone: cubit.doctorsOfFirebase[index].phone,
                                    u: cubit.doctorsOfFirebase[index].uId,
                                  )
                                : Container(
                                    height: 0.0,
                                  );
                          },
                        ),
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
