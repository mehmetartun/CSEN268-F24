import 'package:CSEN268_F24/blocs/notifications/bloc/notifications_bloc.dart';
import 'package:CSEN268_F24/firebase_options.dart';
import 'package:CSEN268_F24/navigation/router.dart';
import 'package:CSEN268_F24/pages/map_page.dart';
import 'package:CSEN268_F24/pages/messaging_page.dart';
import 'package:CSEN268_F24/repositories/authentication/authentication_repository.dart';
import 'package:firebase_app_installations/firebase_app_installations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';

import 'navigation/route_name.dart';
import 'pages/image_page.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
  print('Message data: ${message.data}');
  print('Message notification: ${message.notification?.title}');
  print('Message notification: ${message.notification?.body}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print(await FirebaseInstallations.instance.getId());

  final messaging = FirebaseMessaging.instance;
  final settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  const vapidKey =
      "BPOASuZbPYH-LNIIbBd7XC1Ajh67dW99OyRpj5kmexmMfvBqYTLnwUbXfGZJVd_gNuJMjMu6JJ1ZQyiv1OnMRXA";
  String? token;

  if (DefaultFirebaseOptions.currentPlatform == DefaultFirebaseOptions.web) {
    token = await messaging.getToken(
      vapidKey: vapidKey,
    );
  } else {
    try {
      token = await messaging.getToken();
    } catch (e) {
      print("Error getting token $e");
    }
  }
  print("Messaging token: $token");

  if (kIsWeb) {
    FirebaseMessaging.onBackgroundMessage((message) async {
      // Do what you need to do with the message
    });
  } else {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

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
      child: BlocProvider(
        create: (context) => NotificationsBloc()..init(),
        child: MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            builder: (context, child) {
              Widget _child = child ?? Container();
              return BlocListener<NotificationsBloc, NotificationsState>(
                listener: (context, state) {
                  // TODO: implement listener
                  print(state.runtimeType);
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("Test Message")));
                },
                child: _child,
              );
            },
            home: MessagingPage()),
      ),
    );
  }
}
