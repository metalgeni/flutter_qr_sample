import 'package:flutter/material.dart';
import 'package:flutter_homework/define/define_global.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text('QR Scan Demo'),
      ),
      body: ListView(
        children: [
          const Divider(thickness: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: PlatformElevatedButton(
                child: PlatformText('설정'),
                onPressed: () {
                  Navigator.pushNamed(context, GlobalDefine.RouteNameSetting);
                }),
          ),
          const Divider(thickness: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: PlatformElevatedButton(
                child: PlatformText('QRCode Detect'),
                onPressed: () {
                  Navigator.pushNamed(context, GlobalDefine.RouteNameQR);
                }),
          ),
          const Divider(thickness: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: PlatformElevatedButton(
                child: isMaterial(context)
                    ? PlatformText('iOS Style UI')
                    : PlatformText('Android Style UI'),
                onPressed: () {
                  final p = PlatformProvider.of(context)!;

                  isMaterial(context)
                      ? p.changeToCupertinoPlatform()
                      : p.changeToMaterialPlatform();
                }),
          ),
          const Divider(thickness: 10),
        ],
      ),
    );
  }
}
