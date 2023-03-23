import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pro/Pages/home_page.dart';
import 'package:pro/Pages/login_screen.dart';
import 'package:pro/constants.dart';
import 'package:pro/shared/constance.dart';
import 'package:pro/shared/cubit.dart';
import 'package:pro/shared/local/cachHelper.dart';
import 'package:pro/shared/login_cubit.dart';
import 'package:pro/shared/states.dart';
import 'package:pro/utilites/ToolsUtilites.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

//import 'package:foods_app_ui/widgets/myTitle.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var initializationSettingsAndroid =
      AndroidInitializationSettings('codex_logo');
  var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification:
          (int id, String title, String body, String payload) async {});

  var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
  });

  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  //DioHelper.init();
  await CacheHelper.init();
  //AppCubit.get(BuildContext context).createDatabase();
  Widget screenWidget;
  //bool onBoarding = CacheHelper.getData(key: 'onBoarding');
  //token = CacheHelper.getData(key: 'token');

  uId = CacheHelper.getData(key: 'uId');
  String s = CacheHelper.getData(key: 'isdoc');
  if (uId != null) {
    isdoc = (s == 'yes');
    screenWidget = HomePage(); //LoginScreen();
  } else {
    screenWidget = LoginScreen();
  }
  /*WidgetsFlutterBinding.ensureInitialized();

  bool isDark = CachHelper.getData(key: 'isDark');943
*/

  runApp(MyApp(
    startWidget: screenWidget,
  ));
}

class MyApp extends StatelessWidget {
  // final bool isDark;
  final Widget startWidget;
  MyApp({
    this.startWidget,
  });
  // MyApp(this.isDark);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => AppCubit()..createDatabase(),
        ),
        BlocProvider(
          create: (BuildContext context) => LoginCubit()
            ..getDoctorData2()
            ..getAllDoctor()
            ..getMyDoctors(),
        ),
      ], //..changeAppMode(fromShared: isDark),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          // AppCubit cubit = AppCubit.get(context);

          return MaterialApp(
            title: 'MideMinder',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              //primarySwatch: ToolsUtilites.mainColor,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              primaryColor: ToolsUtilites.mainColor,
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: ToolsUtilites.mainColor,
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor: ToolsUtilites.whiteColor,
              ),
              textTheme: TextTheme(
                  bodyText1: TextStyle(
                      fontSize: 18.0,
                      //fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color: ToolsUtilites.secondColor)),
            ),
            darkTheme: ThemeData(
              // primaryColor: ToolsUtilites.mainColor,
              //scaffoldBackgroundColor: ToolsUtilites.secondColor,
              appBarTheme: AppBarTheme(
                // backwardsCompatibility: false,
                /* systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: HexColor('333739'),
              statusBarBrightness: Brightness.light,
            ),*/
                // backgroundColor: ToolsUtilites.whiteColor,
                elevation: 0.0,
                /*titleTextStyle: TextStyle(
              color: ToolsUtilites.whiteColor,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),*/
                iconTheme: IconThemeData(
                  color: ToolsUtilites.whiteColor,
                ),
              ),
              //cardTheme: CardTheme(color: ToolsUtilites.whiteColor),
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: ToolsUtilites.mainColor,
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                elevation: 20.0,
                backgroundColor:
                    ToolsUtilites.secondColor, //HexColor('333739'),
              ),
              textTheme: TextTheme(
                bodyText1: TextStyle(
                  fontSize: 18.0,
                  //fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: ToolsUtilites.whiteColor,
                ),
              ),
              iconTheme: IconThemeData(
                color: ToolsUtilites.whiteColor,
              ),
              inputDecorationTheme: InputDecorationTheme(
                hoverColor: ToolsUtilites.whiteColor,
                focusColor: ToolsUtilites.whiteColor,
                fillColor: ToolsUtilites.whiteColor,
              ),
            ),
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: startWidget,
            //home: HomePage(),
          );
        },
      ),
    );
  }
}
