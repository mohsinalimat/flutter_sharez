import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:flutter_sharez/bootstrap.dart';
import 'package:platform_info/platform_info.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage(
  deferredLoading: true,
)
class QrScanPage extends StatefulWidget {
  const QrScanPage({Key? key}) : super(key: key);

  @override
  State<QrScanPage> createState() => _QrScanPageState();
}

class _QrScanPageState extends State<QrScanPage> {
  final scannerController = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
  );

  @override
  void dispose() {
    scannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Platform.I.isDesktop
          ? <Widget>[
              "QR Scanner not supported in desktop.Please connect manually. "
                  .text
                  .isIntrinsic
                  .make(),
              FilledButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: "OK".text.isIntrinsic.make(),
              ).p8()
            ].vStack(
              axisSize: MainAxisSize.min,
            )
          : AiBarcodeScanner(
              canPop: true,
              onScan: (String value) {
                talker.debug(value);
                scannerController.stop();
                Navigator.of(context).pop();
              },
              onDetect: (p0) {},
              controller: scannerController,
              hintWidget: <Widget>[].hStack(),
            ).hHalf(context),
    );
  }
}
