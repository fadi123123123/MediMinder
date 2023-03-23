import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pro/shared/cubit.dart';
import 'package:pro/shared/login_cubit.dart';
import 'package:pro/shared/login_state.dart';
import 'package:pro/shared/states.dart';
import 'package:pro/utilites/ToolsUtilites.dart';

import '../constants.dart';
import 'login_screen.dart';

class HomePage extends StatelessWidget {
  GlobalKey _nenKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => AppCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => LoginCubit()
            ..getDoctorData2()
            ..getUserData(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
          listener: (BuildContext context, AppStates state) {},
          builder: (BuildContext context, AppStates state) {
            AppCubit cubit = AppCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                title: Text(cubit.title[cubit.currentIndex]),
                backgroundColor: ToolsUtilites.mainColor,
                actions: [
                  InkWell(
                    onTap: () => {
                      //cubit.getDoctorData(),
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.notifications,
                        size: 33,
                      ),
                    ),
                  ),
                ],
              ),
              drawer: Drawer(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      state is SocialGetDoctorLoadingState2 ||
                              state is SocialGetUserLoadingState2
                          ? Padding(
                              padding: const EdgeInsets.only(
                                  top: 100.0, bottom: 100.0),
                              child: Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.0,
                                  backgroundColor: ToolsUtilites.mainColor,
                                ),
                              ),
                            )
                          : Column(
                              children: <Widget>[
                                state is SocialGetDoctorLoadingState2 ||
                                        state is SocialGetUserLoadingState2
                                    ? CircularProgressIndicator(
                                        strokeWidth: 2.0,
                                        backgroundColor:
                                            ToolsUtilites.mainColor,
                                      )
                                    : UserAccountsDrawerHeader(
                                        accountName: Text(
                                          isdoc == true
                                              ? LoginCubit.get(context).model !=
                                                      null
                                                  ? ' ${LoginCubit.get(context).model.name}'
                                                  : 'test2'
                                              : LoginCubit.get(context)
                                                          .userModel !=
                                                      null
                                                  ? ' ${LoginCubit.get(context).userModel.name}'
                                                  : 'test2',
                                        ),
                                        accountEmail: Text(
                                          isdoc == true
                                              ? LoginCubit.get(context).model !=
                                                      null
                                                  ? ' ${LoginCubit.get(context).model.email}'
                                                  : 'test2'
                                              : LoginCubit.get(context)
                                                          .userModel !=
                                                      null
                                                  ? ' ${LoginCubit.get(context).userModel.email}'
                                                  : 'test2',
                                        ),
                                        currentAccountPicture: CircleAvatar(
                                          backgroundColor:
                                              ToolsUtilites.whiteColor,
                                          radius: 65.0,
                                          child: CircleAvatar(
                                              backgroundColor:
                                                  ToolsUtilites.whiteColor,
                                              radius: 60.0,
                                              child: Icon(
                                                FontAwesomeIcons.userCircle,
                                                size: 65,
                                                color: ToolsUtilites.mainColor,
                                              )),
                                        ),
                                      ),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.76,
                                  color: ToolsUtilites.whiteColor,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      /* ListTile(
                                  title: new Text(
                                    "Permission",
                                    style: TextStyle(
                                      color: ToolsUtilites.secondColor,
                                    ),
                                  ),
                                  leading: new Icon(
                                    Icons.perm_device_information,
                                    color: ToolsUtilites.secondColor,
                                  ),
                                  onTap: () async {
                                    // Map<Permission, PermissionStatus> statuses;

                                    if (await Permission.storage.status.isGranted) {
                                      // The user opted to never again see the permission request dialog for this
                                      // app. The only way to change the permission's status now is to let the
                                      // user manually enable it in the system settings.
                                      openAppSettings();
                                      Map<Permission, PermissionStatus> statuses =
                                          await [
                                        Permission.location,
                                        Permission.storage,
                                      ].request();
                                      cubit.onStatusRequested(statuses);
                                    }
                                    if (await Permission.contacts
                                        .request()
                                        .isGranted) {
                                      // Either the permission was already granted before or the user just granted it.
                                    }
                                  },
                                ),*/

                                      //Setting
                                      ListTile(
                                        title: new Text(
                                          "Settings",
                                          style: TextStyle(
                                            color: ToolsUtilites.secondColor,
                                          ),
                                        ),
                                        leading: new Icon(
                                          Icons.settings,
                                          color: ToolsUtilites.secondColor,
                                        ),
                                        onTap: () async {},
                                      ),

                                      //dark mode
                                      ListTile(
                                        title: new Text(
                                          "Dark Mode",
                                          style: TextStyle(
                                            color: ToolsUtilites.secondColor,
                                          ),
                                        ),
                                        leading: new Icon(
                                          Icons.brightness_4,
                                          color: ToolsUtilites.secondColor,
                                        ),
                                        onTap: () {
                                          cubit.changeAppMode();
                                        },
                                      ),
                                      //Log out
                                      ListTile(
                                        title: new Text(
                                          "Log out",
                                          style: TextStyle(
                                            color: ToolsUtilites.secondColor,
                                          ),
                                        ),
                                        leading: new Icon(
                                          FontAwesomeIcons.signOutAlt,
                                          color: ToolsUtilites.secondColor,
                                        ),
                                        onTap: () {
                                          LoginCubit.get(context).logingOut();
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginScreen(),
                                            ),
                                          );
                                        },
                                      ),
                                      ListTile(
                                        title: new Text(
                                          "Permission for Storage Device",
                                          style: TextStyle(
                                            color: ToolsUtilites.secondColor,
                                          ),
                                        ),
                                        leading: new Icon(
                                          Icons.perm_device_information,
                                          color: ToolsUtilites.secondColor,
                                        ),
                                        onTap: () async {
                                          var status =
                                              await Permission.storage.status;
                                          if (status.isUndetermined) {
                                            //openAppSettings();
                                            Map<Permission, PermissionStatus>
                                                statuses = await [
                                              Permission.storage,
                                              Permission.camera
                                            ].request();
                                            cubit.onStatusRequested(statuses);
                                          }
                                        },
                                      ),
                                      //about us
                                      ListTile(
                                        title: new Text(
                                          "about us",
                                          style: TextStyle(
                                            color: ToolsUtilites.secondColor,
                                          ),
                                        ),
                                        leading: new Icon(
                                          Icons.info,
                                          color: ToolsUtilites.secondColor,
                                        ),
                                        onTap: () async {},
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: CurvedNavigationBar(
                  key: _nenKey,
                  index: cubit.currentIndex,
                  items: [
                    Icon(FontAwesomeIcons.user,
                        color: ToolsUtilites.whiteColor, size: 33),
                    Icon(FontAwesomeIcons.pills,
                        color: ToolsUtilites.whiteColor, size: 33),
                    Icon(FontAwesomeIcons.userMd,
                        color: ToolsUtilites.whiteColor, size: 33),
                  ],
                  color: ToolsUtilites.mainColor,
                  backgroundColor: ToolsUtilites.whiteColor,
                  animationCurve: Curves.easeInOut,
                  onTap: (index) {
                    cubit.changeIndex(index);
                  }),
              body: cubit.tabs[cubit.currentIndex],
            );
          }),
    );
  }

  Widget listTile(String name, IconData ico, AppCubit c) {
    return ListTile(
      title: Text(
        name,
        style: TextStyle(
          color:
              c.isDark ? ToolsUtilites.whiteColor : ToolsUtilites.secondColor,
        ),
      ),
      leading: Icon(
        ico,
        color: c.isDark ? ToolsUtilites.whiteColor : ToolsUtilites.secondColor,
      ),
    );
  }
}
