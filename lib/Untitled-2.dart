import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyBarcodeReaderWidget(),
    );
  }
}

class MyBarcodeReaderWidget extends StatefulWidget {
  @override
  _MyBarcodeReaderWidgetState createState() => _MyBarcodeReaderWidgetState();
}

class _MyBarcodeReaderWidgetState extends State<MyBarcodeReaderWidget> {
  final TextEditingController _barcodeController = TextEditingController(); // テキストボックスのコントローラ
  String barcodeData = ''; // バーコードデータを格納する変数

  @override
  void initState() {
    super.initState();
    _barcodeController.addListener(_onBarcodeTextChanged);
  }

  void _onBarcodeTextChanged() {
    setState(() {
      barcodeData = _barcodeController.text;
    });
  }

  @override
  void dispose() {
    _barcodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Barcode Reader Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Barcode Data:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            // テキストボックスを表示してバーコードデータを表示
            TextField(
              controller: _barcodeController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Scan Barcode',
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Scanned Data:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              barcodeData,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
