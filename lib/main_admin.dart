import 'package:CSEN268_F24/firebase_options.dart';
import 'package:CSEN268_F24/pages/firestore_test_page.dart';
import 'package:CSEN268_F24/pages/generic_page.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // FirebaseFunctions.instance.useFunctionsEmulator("localhost", 5001);
  runApp(MyAdminApp());
}

class MyAdminApp extends StatelessWidget {
  const MyAdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo Admin',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: GenericPage(title: "Welcome to Web - Admin App"),
    );
  }
}
