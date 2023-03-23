import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pro/constants.dart';
import 'package:pro/shared/local/cachHelper.dart';
import 'package:pro/shared/login_cubit.dart';
import 'package:pro/shared/login_state.dart';
import 'package:pro/utilites/ToolsUtilites.dart';

import 'home_page.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var isDoctorController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
          listener: (BuildContext context, LoginStates state) {
        if (state is SocialCreatUserSuccessgState) {
          CacheHelper.saveData(
            key: 'uId',
            value: state.uId,
          ).then((value) {
            CacheHelper.saveData(
              key: 'isdoc',
              value: state.isDoctor,
            ).then((val) {});
            //LoginCubit.get(context)
            isdoc == true
                ? LoginCubit.get(context).getDoctorData2()
                : LoginCubit.get(context).getUserData();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          });
        }
      }, builder: (BuildContext context, LoginStates state) {
        LoginCubit cubit = LoginCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text("Register"),
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'REGISTER',
                        style: Theme.of(context).textTheme.headline4.copyWith(
                              color: Colors.black,
                            ),
                      ),
                      Text(
                        'Register now',
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: Colors.grey,
                            ),
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      //name
                      TextFormField(
                        controller: nameController,
                        //type: TextInputType.emailAddress,
                        keyboardType: TextInputType.name,
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
                            Icons.text_format,
                            color: ToolsUtilites.mainColor,
                          ),
                          labelText: 'name',
                          labelStyle: TextStyle(color: ToolsUtilites.mainColor),
                        ),
                      ),

                      SizedBox(
                        height: 30.0,
                      ),

                      //email
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'please enter your email address';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: ToolsUtilites.mainColor),
                          ),
                          prefixIcon: Icon(
                            Icons.email,
                            color: ToolsUtilites.mainColor,
                          ),
                          labelText: 'Email Address',
                          labelStyle: TextStyle(color: ToolsUtilites.mainColor),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),

                      //password
                      TextFormField(
                        controller: passwordController,
                        obscureText: cubit.isPassword,
                        obscuringCharacter: '*',
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'password is too short';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: ToolsUtilites.mainColor),
                          ),
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: ToolsUtilites.mainColor,
                          ),
                          suffixIcon: InkWell(
                            onTap: () {
                              LoginCubit.get(context)
                                  .changePasswordVisibility();
                            },
                            child: Icon(
                              LoginCubit.get(context).suffix,
                              color: ToolsUtilites.mainColor,
                            ),
                          ),
                          labelText: 'Password',
                          labelStyle: TextStyle(color: ToolsUtilites.mainColor),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),

                      //phone number
                      TextFormField(
                        controller: phoneController,
                        //type: TextInputType.emailAddress,
                        keyboardType: TextInputType.number,
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
                          labelText: 'phone number',
                          labelStyle: TextStyle(color: ToolsUtilites.mainColor),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      //isDoctor

                      TextFormField(
                        controller: isDoctorController,
                        //type: TextInputType.name,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'please enter your email address';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: ToolsUtilites.mainColor),
                          ),
                          prefixIcon: Icon(
                            FontAwesomeIcons.userMd,
                            color: ToolsUtilites.mainColor,
                          ),
                          labelText: 'is Doctor',
                          labelStyle: TextStyle(color: ToolsUtilites.mainColor),
                        ),
                      ),

                      //Register button
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, bottom: 8.0, left: 80, right: 80),
                        child: Container(
                          width: 200,
                          height: 60,
                          child: state is! SocialRegisterLoadingState
                              ? FlatButton(
                                  color: ToolsUtilites.greenColor,
                                  shape: StadiumBorder(),
                                  onPressed: () {
                                    //Map<String, dynamic> p = {"uId": "123"};
                                    if (formKey.currentState.validate()) {
                                      cubit.userRegister(
                                        name: nameController.text,
                                        email: emailController.text,
                                        password: passwordController.text,
                                        phone: phoneController.text,
                                        isDoctor: isDoctorController.text,
                                        //list: p,
                                      );
                                      // Navigator.pop(context);
                                    } //else
                                    // Navigator.pop(context);
                                  },
                                  child: Center(
                                    child: Text(
                                      "Register",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 28,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                )
                              : CircularProgressIndicator(
                                  strokeWidth: 1.0,
                                  backgroundColor: ToolsUtilites.mainColor,
                                ),
                        ),
                      ),

                      SizedBox(
                        height: 30.0,
                      ),
                      // Register Button
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
