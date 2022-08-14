import 'dart:io';

import 'package:flutter/material.dart';
import 'package:petagon_admin/check_qr.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanQrCodePage extends StatefulWidget {
  final String partnerName;
  const ScanQrCodePage({Key? key, required this.partnerName}) : super(key: key);

  @override
  State<ScanQrCodePage> createState() => _ScanQrCodePageState();
}

class _ScanQrCodePageState extends State<ScanQrCodePage> {
  final qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? barcode;
  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() async {
    super.reassemble();

    if (Platform.isAndroid) {
      await controller!.pauseCamera();
    }

    controller!.resumeCamera();
    super.reassemble();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            alignment: Alignment.center,
            children: [
              buildQrView(context),
            ],
          )),
    );
  }

  Widget buildQrView(BuildContext context) => QRView(
        cameraFacing: CameraFacing.back,
        key: qrKey,
        onQRViewCreated: onQRViewCreated,
        overlay: QrScannerOverlayShape(
            cutOutSize: MediaQuery.of(context).size.width * 0.7,
            borderLength: 20,
            borderRadius: 10,
            borderWidth: 10),
      );

  void onQRViewCreated(QRViewController controller) async {
    setState((() => this.controller = controller));

    if (Platform.isAndroid) {
      await this.controller!.pauseCamera();
    }

    this.controller!.resumeCamera();

    controller.scannedDataStream.listen((qrcode) => setState(() {
          barcode = qrcode;
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => CheckQrPage(
                    partnerName: widget.partnerName,
                    petID: barcode!.code!,
                  )));
        }));
  }
}
