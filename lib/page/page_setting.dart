import 'package:flutter/material.dart';
import 'package:flutter_homework/main.dart';
import 'package:provider/provider.dart';
import 'package:flutter_homework/notifier/ui_change_notifier.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class PageSetting extends StatelessWidget {
  PageSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<UIChangeNotifier>();
    final isUseSytemSet = notifier.isUseSytemSet;

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
                    Switch(
                      //value: parent!.useLightMode,
                      value: isUseSytemSet,
                      //activeColor: Colors.red,
                      onChanged: (bool value) {
                        //parent.handleBrightness(value);
                        notifier.RefreshSystemSetting(value);
                      },
                    ),
                  ],
                ),
              ),
              ListTile(
                title: Row(
                  children: [
                    Expanded(
                        flex: 5,
                        child: Text(
                          '라이트/다크',
                        )),
                    Spacer(),
                    Switch(
                      //value: parent!.useLightMode,
                      value: true,
                      //activeColor: Colors.red,
                      onChanged: isUseSytemSet
                          ? null
                          : (bool value) {
                              //parent.handleBrightness(value);
                            },
                    ),
                  ],
                ),
              ),
              ListTile(
                title: Row(
                  children: [
                    Expanded(
                        flex: 5,
                        child: Text(
                          'iOS/Android 스타일 UI',
                        )),
                    Spacer(),
                    Switch(
                      //value: parent!.useLightMode,
                      value: true,
                      //activeColor: Colors.red,
                      onChanged: isUseSytemSet
                          ? null
                          : (bool value) {
                              //parent.handleBrightness(value);
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
                      //onChanged: (_) {},
                      onChanged: isUseSytemSet
                          ? null
                          : (double value) {
                              //parent.handleBrightness(value);
                            },
                      value: 1.0,
                    ),
                  ],
                ),
              ),
            ]));
  }
}
