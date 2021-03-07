import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shastho_kiron/detail.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HealthApp(),
    );
  }
}

class HealthApp extends StatefulWidget {
  @override
  _HealthAppState createState() => _HealthAppState();
}

class _HealthAppState extends State<HealthApp> {
  final _formKey = GlobalKey<FormState>();
  String title;
  String desc;
  String topic;
  CollectionReference topicRef = FirebaseFirestore.instance
      .collection('taskLists')
      .doc('firestore12-12-2020')
      .collection('taskList_CRUD');
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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFF2CBE8).withOpacity(0.8),
              Color(0xFFCBD1F2).withOpacity(0.8),
              Color(0xFFD3F2CB).withOpacity(0.8),
            ],
            stops: [0.3, 0.6, 1],
          ),
        ),
        child: ListView(
          key: _formKey,
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: topicRef.snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                return new Column(
                  children: snapshot.data.docs.map((DocumentSnapshot document) {
                    topic = document.data()['description'];

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFF5ED6D0),
                            border: Border.all(
                              width: 0.55,
                              color: Color(0xFF5ED6D0),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.all(8.0),
                          margin: const EdgeInsets.all(8.0),
                          width: MediaQuery.of(context).size.width / 1.4,
                          height: 100.0,
                          child: new Text(
                            document.data()['title'],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 30,
                            ),
                          ),
                        ),
                        IconButton(
                            icon: Icon(Icons.arrow_right_outlined),
                            color: Colors.black,
                            iconSize: 40.0,
                            onPressed: () {
                              _fetchData(topicRef, document);
                            })
                      ],
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  _fetchData(CollectionReference collectionReference,
      DocumentSnapshot documentSnapshot) {
    String desc = documentSnapshot.data()['description'];
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => Detail(docToView: desc),
    ));
  }
}
