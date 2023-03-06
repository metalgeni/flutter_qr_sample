import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_homework/define/define_global.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter_homework/page/page_qrview.dart';
import 'package:flutter_homework/page/page_setting.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text('Cupertino, Material, DarkMode, QR Scan Demo'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: PlatformElevatedButton(
                child: PlatformText('설정'),
                onPressed: () {
                  // Navigator.of(context).push(MaterialPageRoute(
                  //   builder: (context) => const QRViewExample(),
                  // Navigator.of(context).push(MaterialPageRoute(
                  //   builder: (context) => PageSetting(),
                  // ));
                  Navigator.pushNamed(context, GlobalDefine.RouteNameSetting);
                }),
          ),
          Divider(thickness: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: PlatformElevatedButton(
                child: PlatformText('QRCode'),
                onPressed: () {
                  Navigator.pushNamed(context, GlobalDefine.RouteNameQR);
                }),
          ),
          Divider(thickness: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: PlatformElevatedButton(
                child: PlatformText('PLATFORM'),
                onPressed: () {
                  final p = PlatformProvider.of(context)!;

                  isMaterial(context)
                      ? p.changeToCupertinoPlatform()
                      : p.changeToMaterialPlatform();
                }),
          ),
          Divider(thickness: 10),
        ],
      ),
    );
  }
}
