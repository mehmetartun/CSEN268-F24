import 'package:CSEN268_F24/model/event.dart';
import 'package:CSEN268_F24/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DataPage extends StatefulWidget {
  const DataPage({super.key});

  @override
  State<DataPage> createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  List<User> users = [];
  bool usersAdded = false;
  int usersReceived = 0;
  bool initialized = false;
  int usersAK = 0;
  int usersAKLZ = 0;

  @override
  void initState() {
    // TODO: implement initState
    initializeDB();
    super.initState();
  }

  void initializeDB() async {
    List<Future> futs = [];
    QuerySnapshot users =
        await FirebaseFirestore.instance.collection('users_test').get();
    for (QueryDocumentSnapshot userDoc in users.docs) {
      futs.add(userDoc.reference.delete());
    }
    QuerySnapshot events =
        await FirebaseFirestore.instance.collection('events_test').get();
    for (QueryDocumentSnapshot eventDoc in events.docs) {
      futs.add(eventDoc.reference.delete());
    }
    await Future.wait(futs);
    initialized = true;
    setState(() {});
  }

  void createMockUsers() {
    users = List.generate(10, (index) {
      return User.createMockUser();
    });
    setState(() {});
  }

  void addUsers() async {
    List<Future> futs = [];

    for (User user in users) {
      futs.add(FirebaseFirestore.instance
          .collection('users_test')
          .add(user.toMap()));
    }

    await Future.wait(futs);
    setState(() {
      usersAdded = true;
    });
  }

  void getUsersFirstNameStartsA_K() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users_test')
        .where("firstName", isLessThan: "L")
        .get();
    usersAK = (querySnapshot.docs.length);
    setState(() {});
  }

  void getUsersFirstNameStartsA_K_and_LastNameL_Z() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users_test')
        .where("firstName", isLessThan: "L")
        .where("lastName", isGreaterThan: "K")
        .get();
    usersAKLZ = (querySnapshot.docs.length);
    setState(() {});
  }

  void enterAnEvent() async {
    await FirebaseFirestore.instance.collection('events_test').add(
        Event(title: "Halloween", date: DateTime(2023, 10, 31))
            .toFirestoreMap());
  }

  void readAnEvent() async {
    var qs = await FirebaseFirestore.instance.collection('events_test').get();
    var ev = Event.fromFirestoreMap(qs.docs[0].data());
    print(ev);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Data with Firestore"),
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: AnimatedCrossFade(
            duration: Duration(milliseconds: 500),
            crossFadeState: initialized
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            firstChild: Center(child: CircularProgressIndicator()),
            secondChild: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FilledButton.tonal(
                    child: Text("Create Mock Users"),
                    onPressed: users.length == 0
                        ? () {
                            createMockUsers();
                          }
                        : null),
                Text("Number of Mock Users: ${users.length}"),
                FilledButton.tonal(
                    child: Text("Add Users to Firestore"),
                    onPressed: usersAdded
                        ? null
                        : () {
                            addUsers();
                          }),
                Text("Users Added: ${usersAdded}"),
                FilledButton.tonal(
                    child: Text("Get Users with FirstName A-K"),
                    onPressed: () {
                      getUsersFirstNameStartsA_K();
                    }),
                Text("Users with Firstname A-K: ${usersAK}"),
                FilledButton.tonal(
                    child: Text("Users with FName A-K & LName L-Z"),
                    onPressed: () {
                      getUsersFirstNameStartsA_K_and_LastNameL_Z();
                    }),
                Text("Users with Fname A-K & Lname L-Z: ${usersAKLZ}"),
                FilledButton.tonal(
                    child: Text("Enter an Event"),
                    onPressed: () {
                      enterAnEvent();
                    }),
                FilledButton.tonal(
                    child: Text("Read an Event"),
                    onPressed: () {
                      readAnEvent();
                    }),
              ],
            ),
          ),
        )));
  }
}
