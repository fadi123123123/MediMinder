import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pro/Pages/addDoctor.dart';
import 'package:pro/shared/login_cubit.dart';
import 'package:pro/shared/login_state.dart';
import 'package:pro/utilites/ToolsUtilites.dart';

import '../constants.dart';

class Doctor extends StatefulWidget {
  @override
  _DoctorState createState() => _DoctorState();
}

class _DoctorState extends State<Doctor> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit()..getMyDoctors(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (BuildContext context, LoginStates state) {},
        builder: (BuildContext context, LoginStates state) {
          LoginCubit cubit = LoginCubit.get(context);
          return Scaffold(
            floatingActionButton: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                elevation: 10.0,
                child: Icon(
                  Icons.add,
                ),
                onPressed: () async {
                  // cubit.getMyDoctors();
                  //cubit.getAllDoctor();
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddDoctor()),
                  );
                  cubit.getMyDoctors();
                },
                //backgroundColor: ToolsUtilites.mainColor,
              ),
            ),
            body: state is SocialgetMyDoctorsLoadingState ||
                    state is SocialgetMyDoctorsLoadingState2
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
                    child: ListView.builder(
                      itemCount: cubit.doctorOfPatient.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 200,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10.0, left: 5),
                            child: Card(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            height: 80,
                                            width: 80,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(40),

                                              //image: DecorationImage(
                                              //  image: AssetImage(i), fit: BoxFit.cover),
                                            ),
                                            child: CircleAvatar(
                                                backgroundColor:
                                                    ToolsUtilites.whiteColor,
                                                radius: 60.0,
                                                child: Icon(
                                                  FontAwesomeIcons.userMd,
                                                  size: 40,
                                                  color:
                                                      ToolsUtilites.mainColor,
                                                )),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    isdoc == true
                                                        ? cubit.doctorOfPatient[
                                                                    index] !=
                                                                null
                                                            ? cubit
                                                                .doctorOfPatient[
                                                                    index]
                                                                .name
                                                            : "name"
                                                        : cubit.doctorOfPatient[
                                                                    index] !=
                                                                null
                                                            ? cubit
                                                                .doctorOfPatient[
                                                                    index]
                                                                .name
                                                            : "name",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.indigo)),
                                                SizedBox(
                                                  height: 6.0,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0),
                                                  child: Text(
                                                      isdoc == true
                                                          ? cubit.doctorOfPatient[
                                                                      index] !=
                                                                  null
                                                              ? cubit
                                                                  .doctorOfPatient[
                                                                      index]
                                                                  .phone
                                                              : "phone"
                                                          : cubit.doctorOfPatient[
                                                                      index] !=
                                                                  null
                                                              ? cubit
                                                                  .doctorOfPatient[
                                                                      index]
                                                                  .phone
                                                              : "phone",
                                                      style: TextStyle(
                                                          color: Colors.red)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 4,
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          );
        },
      ),
    );
  }
}
