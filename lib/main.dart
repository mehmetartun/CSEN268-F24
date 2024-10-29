import 'package:CSEN268_F24/firebase_options.dart';
import 'package:CSEN268_F24/navigation/router.dart';
import 'package:CSEN268_F24/pages/map_page.dart';
import 'package:CSEN268_F24/pages/messaging_page.dart';
import 'package:CSEN268_F24/repositories/authentication/authentication_repository.dart';
import 'package:firebase_app_installations/firebase_app_installations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';

import 'navigation/route_name.dart';
import 'pages/image_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print(await FirebaseInstallations.instance.getId());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) {
        return (OktaAuthenticationRepository() as AuthenticationRepository);
      },
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: MessagingPage()),
    );
  }
}
