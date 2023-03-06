import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

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
  static late ThemeData materialTheme;
  static late CupertinoThemeData cupertinoTheme;

  static bool isUseSystemSetting = true;
  static bool isLightMode = false;
  static bool isCupertinoUI = false;
  static double customTextScaleFactor = 1.0;

  @override
  void initState() {
    super.initState();
  }

  static updateThemes(bool _useLightMode) {
    materialTheme = ThemeData(
      brightness: _useLightMode ? Brightness.light : Brightness.dark,
      cupertinoOverrideTheme: CupertinoThemeData(
        primaryColor: Color(0xff127EFB),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.all(18.0)),
          foregroundColor:
              MaterialStateProperty.all(Color.fromARGB(255, 111, 0, 255)),
        ),
      ),
    );

    cupertinoTheme =
        MaterialBasedCupertinoThemeData(materialTheme: materialTheme);
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var textScaleFactor = mediaQuery.textScaleFactor;
    Brightness brightness = mediaQuery.platformBrightness;

    print("textScaleFactor $textScaleFactor");
    print("brightness $brightness");

    //isLightMode = brightness == Brightness.light;

    late bool isCurLightMode;
    late bool isCurCupertino;
    late double curtextScaleFactor;

    if (isUseSystemSetting) {
      isCurLightMode = brightness == Brightness.light;

      if (kIsWeb == false) {
        if (Platform.isAndroid) {
          isCurCupertino = false;
        } else {
          isCurCupertino = true;
        }
      } else {
        isCurCupertino = false;
      }

      curtextScaleFactor = textScaleFactor;

      isLightMode = isCurLightMode;
      isCupertinoUI = isCurCupertino;
      customTextScaleFactor = textScaleFactor;
    } else {
      isCurLightMode = isLightMode;
      isCurCupertino = isCupertinoUI;
      curtextScaleFactor = customTextScaleFactor;
    }

    updateThemes(isCurLightMode);

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UIChangeNotifier()),
        ],
        child: Theme(
          data: materialTheme,
          child: PlatformProvider(
            initialPlatform:
                isCurCupertino ? TargetPlatform.iOS : TargetPlatform.android,
            settings: PlatformSettingsData(
              iosUsesMaterialWidgets: true,
              iosUseZeroPaddingForAppbarPlatformIcon: true,
            ),
            builder: (context) => PlatformApp(
              builder: (context, child) {
                return MediaQuery(
                    data: mediaQuery.copyWith(textScaleFactor: 3.8),
                    child: child!);
              },
              title: 'qr demo',
              material: (_, __) => MaterialAppData(
                theme: materialTheme,
              ),
              cupertino: (_, __) => CupertinoAppData(
                theme: cupertinoTheme,
                // CupertinoThemeData(
                //   brightness: Brightness.dark,
                //   primaryColor: Color(0xff127EFB),
                // ),
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
