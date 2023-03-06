import 'package:flutter/material.dart';
import 'package:flutter_homework/main.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class PageSetting extends StatelessWidget {
  PageSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MGAppState? parent = context.findAncestorStateOfType<MGAppState>();

    return PlatformScaffold(
        appBar: PlatformAppBar(title: Text('설정')),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(height: 50),
              ListTile(
                title: Row(
                  children: [
                    Expanded(
                        flex: 5,
                        child: Text(
                          '시스템설정 UI 사용',
                        )),
                    Spacer(),
                    PlatformSwitch(
                      value: parent!.isUseSystemSetting,
                      onChanged: (bool value) {
                        parent.SetUseSystemSet(value);
                      },
                    ),
                  ],
                ),
              ),
              Divider(thickness: 10),
              ListTile(
                title: Row(
                  children: [
                    Expanded(
                        flex: 5,
                        child: Text(
                          '라이트/다크',
                        )),
                    Spacer(),
                    PlatformSwitch(
                      value: parent.isLightMode,
                      //activeColor: Colors.red,
                      onChanged: parent.isUseSystemSetting
                          ? null
                          : (bool value) {
                              parent.SetLightMode(value);
                            },
                    ),
                  ],
                ),
              ),
              ListTile(
                title: Column(
                  children: [
                    Text(
                      '글꼴 크기',
                      overflow: TextOverflow.ellipsis,
                    ),
                    PlatformSlider(
                      min: 0.8,
                      max: 4.0,
                      divisions: 8,
                      onChanged: parent.isUseSystemSetting
                          ? null
                          : (double value) {
                              parent.SetScaleFactor(value);
                            },
                      value: parent.customTextScaleFactor,
                    ),
                  ],
                ),
              ),
            ]));
  }
}
