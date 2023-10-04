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
  final TextEditingController _barcodeController =
      TextEditingController(); // テキストボックスのコントローラ
  final FocusNode _barcodeFocusNode = FocusNode();
  final FocusNode _nextFocusNode = FocusNode();
  String barcodeData = ''; // バーコードデータを格納する変数

  @override
  void initState() {
    super.initState();

    // ウィジェットがロードされた直後にフォーカスを移動
    //WidgetsBinding.instance.addPostFrameCallback((_) {
    //  FocusScope.of(context).requestFocus(_barcodeFocusNode);
    //});
    _barcodeController.addListener(_onBarcodeTextChanged);
  }

  void _onBarcodeTextChanged() {
    setState(() {
      barcodeData = _barcodeController.text;
    });
    // バーコードデータが入力されたときの処理
    // ここでデータが完了したかどうかを確認し、完了したら一時的にフォーカスを移動し、その後元のフォーカスに戻す
    if (isBarcodeDataComplete(_barcodeController.text)) {
      _moveFocusToNextField();
      Future.delayed(Duration(seconds: 1), () {
        _moveFocusBackToBarcodeField();
      });
    }
  }

  bool isBarcodeDataComplete(String data) {
    // バーコードデータが完了したかどうかを判定
    // 例: バーコードのデータが10桁である場合、10桁のデータが揃ったら完了とする
    return data.length == 10;
  }

  void _moveFocusToNextField() {
    FocusScope.of(context).requestFocus(_nextFocusNode);
  }

  void _moveFocusBackToBarcodeField() {
    FocusScope.of(context).requestFocus(_barcodeFocusNode);
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
        title: const Text('Barcode Reader'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Barcode Data:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            // テキストボックスを表示してバーコードデータを表示
            TextField(
              controller: _barcodeController,
              focusNode: _barcodeFocusNode, // FocusNodeを設定
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
              "$barcodeData\n",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            // フォーカスを移動させたい次のウィジェット
            TextField(
              focusNode: _nextFocusNode,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Next Field',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // ボタンが押されたときにフォーカスを移動
                FocusScope.of(context).requestFocus(_barcodeFocusNode);
              },
              child: const Text('Move Focus to TextField'),
            ),
          ],
        ),
      ),
    );
  }
}
