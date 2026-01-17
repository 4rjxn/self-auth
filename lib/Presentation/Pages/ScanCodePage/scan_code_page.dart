//needs ui improvement
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qauth/Presentation/Pages/HomePage/Bloc/home_page_bloc.dart';

@RoutePage()
class ScanCodePage extends StatelessWidget {
  ScanCodePage({super.key});
  final MobileScannerController _controller = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    bool isScanning = false;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: MobileScanner(
          controller: _controller,
          onDetect: (barcodes) async {
            if (!isScanning) {
              isScanning = true;
              if (barcodes.barcodes.last.rawValue != null) {
                context.read<HomePageBloc>().add(
                  AddScannedAccountEvent(
                    qrdata: barcodes.barcodes.last.rawValue!,
                  ),
                );
                await _controller.stop();
              }
            }
            if (context.mounted) {
              Navigator.of(context).pop();
            }
          },
        ),
      ),
    );
  }
}
