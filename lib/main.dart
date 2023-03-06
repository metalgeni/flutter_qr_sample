import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_homework/define/define_global.dart';
import 'package:flutter_homework/notifier/ui_change_notifier.dart';
import 'package:flutter_homework/page/page_setting.dart';
import 'package:flutter_homework/page/page_qrview.dart';

import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter_homework/page/page_home.dart';

void main() => runApp(const MaterialApp(home: MGApp()));

class MGApp extends StatefulWidget {
  const MGApp({Key? key}) : super(key: key);

  @override
  State<MGApp> createState() => MGAppState();
}

class MGAppState extends State<MGApp> {
  @override
  void initState() {
    super.initState();
  }

  static ThemeData updateThemes(bool useLightMode) {
    return ThemeData(
        colorSchemeSeed: Color(0xff6750a4),
        brightness: useLightMode ? Brightness.light : Brightness.dark);
  }

  @override
  Widget build(BuildContext context) {
    var t = MediaQuery.of(context).textScaleFactor;
    //var t2 = MediaQuery.of(context).

    final materialTheme = ThemeData(
      cupertinoOverrideTheme: CupertinoThemeData(
        primaryColor: Color(0xff127EFB),
      ),
      //primarySwatch: Colors.blue,
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.all(16.0)),
          foregroundColor:
              MaterialStateProperty.all(Color.fromARGB(255, 111, 0, 255)),
        ),
      ),
    );

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UIChangeNotifier()),
        ],
        child: Theme(
          data: materialTheme,
          child: PlatformProvider(
            settings: PlatformSettingsData(
              iosUsesMaterialWidgets: true,
              iosUseZeroPaddingForAppbarPlatformIcon: true,
            ),
            builder: (context) => PlatformApp(
              localizationsDelegates: <LocalizationsDelegate<dynamic>>[
                DefaultMaterialLocalizations.delegate,
                DefaultWidgetsLocalizations.delegate,
                DefaultCupertinoLocalizations.delegate,
              ],
              //themeMode: ThemeMode.system, //ThemeMode.light ,
              title: 'qr demo',
              material: (_, __) => MaterialAppData(
                theme: materialTheme,
              ),
              cupertino: (_, __) => CupertinoAppData(
                theme: CupertinoThemeData(
                  brightness: Brightness.light,
                  primaryColor: Color(0xff127EFB),
                ),
              ),
              initialRoute: GlobalDefine.RouteNameRoot,
              routes: {
                GlobalDefine.RouteNameRoot: (context) => MainPage(),
                GlobalDefine.RouteNameSetting: (context) => PageSetting(),
                GlobalDefine.RouteNameQR: (context) => PageQRView(),
              },
            ),
          ),
        ));
  }
}
