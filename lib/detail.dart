import 'package:flutter/material.dart';

class Detail extends StatefulWidget {
  String docToView;
  Detail({Key key, @required this.docToView}) : super(key: key);
  _DetailState createState() => _DetailState(docToView);
}

class _DetailState extends State<Detail> {
  String topicName;
  _DetailState(this.topicName);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "assets/App_Logo.jpeg",
          fit: BoxFit.cover,
          alignment: Alignment.center,
        ),
        backgroundColor: Color(0xFFF2CBE8).withOpacity(0.5),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              topicName,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 32,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
