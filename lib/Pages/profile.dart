import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pro/Pages/edite_profile.dart';
import 'package:pro/constants.dart';
import 'package:pro/shared/login_cubit.dart';
import 'package:pro/shared/login_state.dart';
import 'package:pro/utilites/ToolsUtilites.dart';
import 'package:pro/widget/patient_card.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit()
        ..getDoctorData2()
        ..getUserData(),
      child: BlocConsumer<LoginCubit, LoginStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = LoginCubit.get(context);
            // cubit.getDoctorData2();
            print("@@@@@@@@@@@");
            print(state);
            print("#########");
            return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      state is SocialGetDoctorLoadingState2 ||
                              state is SocialGetUserLoadingState2 ||
                              state is GetMyPatientLodingState
                          ? Padding(
                              padding: const EdgeInsets.only(
                                  top: 200, bottom: 200.0),
                              child: Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.0,
                                  backgroundColor: ToolsUtilites.mainColor,
                                ),
                              ),
                            )
                          : SingleChildScrollView(
                              child: Column(
                                children: [
                                  Container(
                                    height: 220.0,
                                    child: Stack(
                                        alignment:
                                            AlignmentDirectional.bottomCenter,
                                        children: [
                                          Align(
                                            alignment:
                                                AlignmentDirectional.topCenter,
                                            child: Container(
                                              height: 160.0,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(4.0),
                                                    topRight:
                                                        Radius.circular(4.0)),
                                                color: ToolsUtilites.mainColor,
                                              ),
                                            ),
                                          ),
                                          CircleAvatar(
                                            backgroundColor:
                                                ToolsUtilites.whiteColor,
                                            radius: 65.0,
                                            child: CircleAvatar(
                                                backgroundColor:
                                                    ToolsUtilites.whiteColor,
                                                radius: 60.0,
                                                child: Icon(
                                                  FontAwesomeIcons.userCircle,
                                                  size: 120,
                                                  color:
                                                      ToolsUtilites.mainColor,
                                                )
                                                /*child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                //Theme.of(context).scaffoldBackgroundColor,
                              ),
                              /*CircleAvatar( radius:25.0,
                            
                            //backgroundImage: ,
                            )*/
                              ),*/
                                                ),
                                          )
                                        ]),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    isdoc == true
                                        ? LoginCubit.get(context).model != null
                                            ? '${LoginCubit.get(context).model.name}'
                                            : 'test2'
                                        : LoginCubit.get(context).userModel !=
                                                null
                                            ? '${LoginCubit.get(context).userModel.name}'
                                            : 'test2',
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                  SizedBox(
                                    height: 30.0,
                                  ),
                                  Text(
                                    isdoc == true
                                        ? LoginCubit.get(context).model != null
                                            ? 'email: ${LoginCubit.get(context).model.email}'
                                            : 'test2'
                                        : LoginCubit.get(context).userModel !=
                                                null
                                            ? 'email: ${LoginCubit.get(context).userModel.email}'
                                            : 'test2',
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                  SizedBox(
                                    height: 30.0,
                                  ),
                                  Text(
                                    isdoc == true
                                        ? LoginCubit.get(context).model != null
                                            ? 'phone: ${LoginCubit.get(context).model.phone}'
                                            : 'test2'
                                        : LoginCubit.get(context).userModel !=
                                                null
                                            ? 'phone: ${LoginCubit.get(context).userModel.phone}'
                                            : 'test2',
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                  SizedBox(
                                    height: 40.0,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'for edite profile click:',
                                      ),
                                      SizedBox(
                                        width: 2,
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    EditeProfile()),
                                          );
                                          isdoc == true
                                              ? cubit.getDoctorData2()
                                              : cubit.getUserData();
                                        },
                                        child: Text(
                                          'Edite',
                                          style: TextStyle(
                                              color: ToolsUtilites.mainColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 40.0,
                                  ),
                                  //Patient as adoctor
                                  /* isdoc == true
                                      ? Column(
                                          children: [
                                            Text(
                                              "My Patients",
                                              style: TextStyle(
                                                color: ToolsUtilites.mainColor,
                                                fontSize: 25.0,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10.0,
                                            ),
                                            Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.50,
                                              //height: 250,
                                              child: ListView.builder(
                                                itemCount:
                                                    cubit.patient1.length,
                                                scrollDirection: Axis.vertical,
                                                itemBuilder: (context, index) {
                                                  return PatientCard(
                                                    id: index,
                                                    name: cubit
                                                        .patient1[index].name,
                                                    phone: cubit
                                                        .patient1[index].phone,
                                                    isDoc: true,
                                                  );
                                                },
                                              ),
                                            ),
                                            SizedBox(
                                              height: 40.0,
                                            ),
                                            /*Container(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height,
                                              //height: 250,
                                              child: ListView.builder(
                                                itemCount:
                                                    cubit.patient2.length,
                                                scrollDirection: Axis.vertical,
                                                itemBuilder: (context, index) {
                                                  return PatientCard(
                                                    id: index,
                                                    name: cubit
                                                        .patient2[index].name,
                                                    phone: cubit
                                                        .patient2[index].phone,
                                                    isDoc: false,
                                                  );
                                                },
                                              ),
                                            ),*/
                                          ],
                                        )
                                      : SizedBox(
                                          height: 0.0,
                                        ),*/
                                ],
                              ),
                            ),
                    ],
                  ),
                ));
          }),
    );
  }
}
