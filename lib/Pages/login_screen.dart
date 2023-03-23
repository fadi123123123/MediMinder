import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro/Pages/home_page.dart';
import 'package:pro/Pages/register_screen.dart';
import 'package:pro/constants.dart';
import 'package:pro/shared/components.dart';
import 'package:pro/shared/local/cachHelper.dart';
import 'package:pro/shared/login_cubit.dart';
import 'package:pro/shared/login_state.dart';
import 'package:pro/utilites/ToolsUtilites.dart';

class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (BuildContext context, LoginStates state) {
          if (state is SociaLoginErrorState) {
            print(state.error);
            showToast(
              text: state.error,
              state: ToastStates.ERROR,
            );
          }
          if (state is SocialLoginSuccessState) {
            CacheHelper.saveData(
              key: 'uId',
              value: state.uId,
            ).then((value) {
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
        },
        builder: (BuildContext context, LoginStates state) {
          LoginCubit cubit = LoginCubit.get(context);
          return Scaffold(
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
                          'LOGIN',
                          style: Theme.of(context).textTheme.headline4.copyWith(
                                color: Colors.black,
                              ),
                        ),
                        Text(
                          'Login now ',
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                                color: Colors.grey,
                              ),
                        ),
                        SizedBox(
                          height: 40.0,
                        ),

                        //email
                        TextFormField(
                          controller: emailController,
                          //type: TextInputType.emailAddress,
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
                            labelStyle:
                                TextStyle(color: ToolsUtilites.mainColor),
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
                            labelStyle:
                                TextStyle(color: ToolsUtilites.mainColor),
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),

                        //button login
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, bottom: 8.0, left: 80, right: 80),
                          child: Container(
                            width: 200,
                            height: 60,
                            child: FlatButton(
                              color: ToolsUtilites.greenColor,
                              shape: StadiumBorder(),
                              onPressed: () async {
                                if (formKey.currentState.validate()) {
                                  cubit.userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );

                                  print('true');
                                } //else
                                // Navigator.pop(context);
                              },
                              child: Center(
                                child: Text(
                                  "Login",
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
                        // Register Button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account?',
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Register()),
                                );
                              },
                              child: Text(
                                'Register',
                                style:
                                    TextStyle(color: ToolsUtilites.mainColor),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
