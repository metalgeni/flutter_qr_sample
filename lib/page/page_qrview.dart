import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_homework/notifier/ui_change_notifier.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class PageQRView extends StatefulWidget {
  const PageQRView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PageQRViewState();
}

class _PageQRViewState extends State<PageQRView> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  Widget buildCameraWidget(BuildContext context) {
    bool isPressQRDetect = context.watch<UIChangeNotifier>().isPressQRDetect;
    if (isPressQRDetect == true) {
      return Expanded(flex: 3, child: _buildQrView(context));
    } else {
      return Expanded(
          flex: 3,
          child: Container(
              alignment: Alignment.center,
              child: Text('Long press QR Detect Button')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final notifier = context.read<UIChangeNotifier>();

    return PlatformScaffold(
      appBar: PlatformAppBar(title: Text('QRCode')),
      body: Column(
        children: <Widget>[
          //Expanded(flex: 3, child: _buildQrView(context)),
          buildCameraWidget(context),
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  if (result != null)
                    Text('detected:\n ${result!.code}', maxLines: 3)
                  else
                    const Text('Scan a code'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        onLongPressStart: (_) async {
                          print(" longPress Start ");
                          notifier.RefreshUseQRDetect(true);
                          await controller?.resumeCamera();
                        },
                        onLongPressEnd: (_) async {
                          print("longPress End ");
                          notifier.RefreshUseQRDetect(false);
                          await controller?.pauseCamera();
                        },
                        child: PlatformElevatedButton(
                          onPressed: () {},
                          child: Text('QR Detect'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    return Container(
        margin: EdgeInsets.all(20),
        child: QRView(
          key: qrKey,
          onQRViewCreated: _onQRViewCreated,
          overlay: QrScannerOverlayShape(
              borderColor: Colors.red,
              borderRadius: 10,
              borderLength: 30,
              borderWidth: 10,
              cutOutSize: scanArea),
          onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
        ));
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      print('no permission');
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
