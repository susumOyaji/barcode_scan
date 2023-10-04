import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyCanvasWidget(),
    );
  }
}

class MyCanvasWidget extends StatefulWidget {
  @override
  _MyCanvasWidgetState createState() => _MyCanvasWidgetState();
}

class _MyCanvasWidgetState extends State<MyCanvasWidget> {
  List<Offset> points = []; // マウスの座標を格納するリスト

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Circle and Mouse Trail Example'),
      ),
      body: Center(
        child: MouseRegion(
          onHover: (event) {
            setState(() {
              // マウス座標をリストに追加
              points.add(event.localPosition);
            });
          },
          child: Container(
            width: 300,
            height: 300,
            child: CustomPaint(
              painter: CircleAndMouseTrailPainter(points),
            ),
          ),
        ),
      ),
    );
  }
}

class CircleAndMouseTrailPainter extends CustomPainter {
  final List<Offset> points;
  CircleAndMouseTrailPainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint circlePaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    final Paint trailPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // 円を描画
    canvas.drawCircle(center, radius, circlePaint);

    // マウスの軌道を描画
    if (points.isNotEmpty) {
      final path = Path()..moveTo(points[0].dx, points[0].dy);
      for (var i = 1; i < points.length; i++) {
        path.lineTo(points[i].dx, points[i].dy);
      }
      canvas.drawPath(path, trailPaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
