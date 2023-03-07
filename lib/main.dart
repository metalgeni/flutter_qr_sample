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

  bool isUseSystemSetting = true;
  bool isLightMode = false;
  bool isCupertinoUI = false;
  double customTextScaleFactor = 1.0;

  @override
  void initState() {
    super.initState();
  }

  static updateThemes(bool _useLightMode) {
    var bright = _useLightMode ? Brightness.light : Brightness.dark;
    materialTheme = ThemeData(
      brightness: bright,
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

  SetUseSystemSet(bool _isUseSystemSetting) {
    setState(() {
      isUseSystemSetting = _isUseSystemSetting;
    });
  }

  SetLightMode(bool _isLightMode) {
    setState(() {
      isLightMode = _isLightMode;
    });
  }

  SetCupertino(bool _isCupertinoUI) {
    setState(() {
      isCupertinoUI = _isCupertinoUI;
    });
  }

  SetScaleFactor(double _customTextScaleFactor) {
    setState(() {
      customTextScaleFactor = _customTextScaleFactor;
    });
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var textScaleFactor = mediaQuery.textScaleFactor;
    Brightness brightness = mediaQuery.platformBrightness;

    print("textScaleFactor $textScaleFactor");
    print("brightness $brightness");

    late bool isCurLightMode;
    late bool isCurCupertino;
    late double curTextScaleFactor;

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

      curTextScaleFactor = textScaleFactor;

      isLightMode = isCurLightMode;
      isCupertinoUI = isCurCupertino;
      customTextScaleFactor = textScaleFactor;
    } else {
      isCurLightMode = isLightMode;
      isCurCupertino = isCupertinoUI;
      curTextScaleFactor = customTextScaleFactor;
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
                    data: mediaQuery.copyWith(
                        textScaleFactor: curTextScaleFactor),
                    child: child!);
              },
              title: 'qr demo',
              material: (_, __) => MaterialAppData(
                theme: materialTheme,
              ),
              cupertino: (_, __) => CupertinoAppData(
                theme: cupertinoTheme,
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
