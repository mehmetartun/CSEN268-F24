import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirestoreTestPage extends StatefulWidget {
  const FirestoreTestPage({super.key});

  @override
  State<FirestoreTestPage> createState() => _FirestoreTestPageState();
}

class _FirestoreTestPageState extends State<FirestoreTestPage> {
  bool data_added = false;
  bool data_retrieved = false;
  String first_name = "";
  DocumentReference? ref;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Firestore Test"),
        ),
        body: Center(
          child: Column(
            children: [
              FilledButton(
                child: Text("Add Data"),
                onPressed: () async {
                  ref = await FirebaseFirestore.instance
                      .collection("test_firestore")
                      .add({'firstName': 'John'});
                  data_added = true;
                  setState(() {});
                },
              ),
              Text("Data Added: $data_added"),
              FilledButton(
                child: Text("Retrieve Data"),
                onPressed: () async {
                  final DocumentSnapshot ds = await ref!.get();
                  first_name =
                      (ds.data()! as Map<String, dynamic>)['firstName'];
                  data_retrieved = true;
                  setState(() {});
                },
              ),
              Text("Data Retrieved: $data_retrieved"),
              Text("First Name: $first_name"),
            ],
          ),
        ));
  }
}
