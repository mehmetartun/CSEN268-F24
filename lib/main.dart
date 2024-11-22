import 'package:CSEN268_F24/firebase_options.dart';
import 'package:CSEN268_F24/pages/firestore_test_page.dart';
import 'package:CSEN268_F24/pages/generic_page.dart';
import 'package:CSEN268_F24/pages/in_app_web_view_page.dart';
import 'package:CSEN268_F24/pages/web_view_page.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // FirebaseFunctions.instance.useFunctionsEmulator("localhost", 5001);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Builder(builder: (context) {
        return GenericPage(
            title: "WebView",
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    child: FilledButton(
                      child: Text("WebView"),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WebViewPage()));
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    child: FilledButton(
                      child: Text("InAppWebView"),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => InAppWebViewPage()));
                      },
                    ),
                  ),
                ],
              ),
            ));
      }),
    );
  }
}
