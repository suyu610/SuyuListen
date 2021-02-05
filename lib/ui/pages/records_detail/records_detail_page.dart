import 'package:flutter/material.dart';

class RecordsDetailPage extends StatefulWidget {
  RecordsDetailPage({Key key}) : super(key: key);

  @override
  _RecordsDetailPageState createState() => _RecordsDetailPageState();
}

class _RecordsDetailPageState extends State<RecordsDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("学习记录"),
      ),
    );
  }
}
