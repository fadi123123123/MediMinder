import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pro/constants.dart';
import 'package:pro/shared/login_cubit.dart';
import 'package:pro/shared/login_state.dart';
import 'package:pro/utilites/ToolsUtilites.dart';

class EditeProfile extends StatefulWidget {
  @override
  _EditeProfileState createState() => _EditeProfileState();
}

class _EditeProfileState extends State<EditeProfile> {
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var phoneController = TextEditingController();
    var nameController = TextEditingController();
    /*return BlocProvider(
      create: (BuildContext context) => LoginCubit()..getDoctorData2(),*/
    return BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
          if (LoginCubit.get(context).model != null ||
              LoginCubit.get(context).userModel != null) {
            nameController.text = isdoc == true
                ? LoginCubit.get(context).model != null
                    ? '${LoginCubit.get(context).model.name}'
                    : 'test2'
                : LoginCubit.get(context).userModel != null
                    ? '${LoginCubit.get(context).userModel.name}'
                    : 'test2';

            phoneController.text = isdoc == true
                ? LoginCubit.get(context).model != null
                    ? '${LoginCubit.get(context).model.phone}'
                    : 'test2'
                : LoginCubit.get(context).userModel != null
                    ? '${LoginCubit.get(context).userModel.phone}'
                    : 'test2';
          }
          return Scaffold(
            appBar: AppBar(
              title: Text('Edite Profile'),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  state is SocialUpdateDoctorLoadingState ||
                          state is SocialUpdateUserLoadingState
                      ? LinearProgressIndicator()
                      : SizedBox(
                          height: 10.0,
                        ),

                  Container(
                    height: 210.0,
                    child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Align(
                            alignment: AlignmentDirectional.topCenter,
                            child: Stack(
                                alignment: AlignmentDirectional.topEnd,
                                children: [
                                  Container(
                                    height: 160.0,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0)),
                                      color: ToolsUtilites.mainColor,
                                    ),
                                  ),
                                  IconButton(
                                    icon: CircleAvatar(
                                      radius: 20.0,
                                      child: Icon(FontAwesomeIcons.camera,
                                          size: 16.0),
                                    ),
                                    onPressed: () {},
                                  ),
                                ]),
                          ),
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                backgroundColor: ToolsUtilites.whiteColor,
                                radius: 65.0,
                                child: CircleAvatar(
                                    backgroundColor: ToolsUtilites.whiteColor,
                                    radius: 60.0,
                                    child: Icon(
                                      FontAwesomeIcons.userCircle,
                                      size: 120,
                                      color: ToolsUtilites.mainColor,
                                    )),
                              ),
                              IconButton(
                                icon: CircleAvatar(
                                  radius: 20.0,
                                  child:
                                      Icon(FontAwesomeIcons.camera, size: 16.0),
                                ),
                                onPressed: () {},
                              ),
                            ],
                          )
                        ]),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  //Edite your name
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: nameController,
                      //type: TextInputType.emailAddress,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'please enter your name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: ToolsUtilites.mainColor),
                        ),
                        prefixIcon: Icon(
                          Icons.text_fields,
                          color: ToolsUtilites.mainColor,
                        ),
                        labelText: 'name', //'${cubit.model.name}',
                        labelStyle: TextStyle(color: ToolsUtilites.mainColor),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),

                  //Edite your phone
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: phoneController,
                      //type: TextInputType.emailAddress,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'please enter your phone number';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: ToolsUtilites.mainColor),
                        ),
                        prefixIcon: Icon(
                          Icons.phone,
                          color: ToolsUtilites.mainColor,
                        ),
                        labelText: 'phone', //'${cubit.model.phone}',
                        labelStyle: TextStyle(color: ToolsUtilites.mainColor),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 8.0, bottom: 8.0, left: 80, right: 80),
                    child: Container(
                      width: 200,
                      height: 60,
                      child: state is SocialUpdateDoctorLoadingState ||
                              state is SocialUpdateUserLoadingState
                          ? CircularProgressIndicator(
                              strokeWidth: 1.0,
                              backgroundColor: ToolsUtilites.mainColor,
                            )
                          : FlatButton(
                              color: ToolsUtilites.greenColor,
                              shape: StadiumBorder(),
                              onPressed: () {
                                //if (formKey.currentState.validate()) {
                                isdoc == true
                                    ? cubit.updateDoctor(
                                        name: nameController.text,
                                        phone: phoneController.text)
                                    : cubit.updateUser(
                                        name: nameController.text,
                                        phone: phoneController.text);
                                if (state is SocialGetDoctorSuccessState2 ||
                                    state is SocialGetUserSuccessState2) {
                                  Navigator.of(context).pop();
                                }

                                print('true');
                              },
                              child: Center(
                                child: Text(
                                  "Save Edite",
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
                  SizedBox(
                    height: 30.0,
                  ),
                ],
              ),
            ),
          );
        });
  }
  /* }),
    );*/
}
//}
