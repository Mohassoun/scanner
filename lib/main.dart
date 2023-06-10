import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    String title = "";

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bar-Qr(scanner)',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: MyHomePage(title),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  MyHomePage(this.title);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey _gLobalkey = GlobalKey();
  QRViewController? controller;
  Barcode? result;
  String code = '';
  String cadreG = 'assets/cadreG.png';
  String cadreR = 'assets/cadreR.png';
  bool _enabled = false; // For Switch
  double _value = 0; // For Slider

  // This is the trick!
  void _reset() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: Duration.zero,
        pageBuilder: (_, __, ___) => MyHomePage("QR-BAR code"),
      ),
    );
  }

  void qr(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((event) {
      setState(() {
        result = event;
        code = result!.code.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Stack(
              children: [
                Container(
                  height: 300,
                  width: 300,
                  child: QRView(key: _gLobalkey, onQRViewCreated: qr),
                ),
                Container(
                  alignment: Alignment.center,
                  height: 300,
                  width: 300,
                  child: (result != null)
                      ? Image.asset(
                          cadreG,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          cadreR,
                          fit: BoxFit.cover,
                        ),
                ),
                //background

                // top widget
              ],
            ),
            Container(
              child: (result != null) ? Text(code) : Text('Scan a code'),
            ),
            ElevatedButton(
              onPressed: _reset,
              child: Text('RESET'),
            ),
          ],
        ),
      ),
    );
  }
}
