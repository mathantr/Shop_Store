import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop_store/constants/theme.dart';
import 'package:shop_store/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:shop_store/provider/app_provider.dart';
import 'package:shop_store/screens/auth_ui/welcome/wecome_screen.dart';
import 'package:shop_store/screens/bottom_navigator/bottom_navigator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Shoping App',
          theme: themeData,
          home: StreamBuilder(
            stream: FireBaseAuthHelper.instance.getAuthChange,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return BottomNavigator();
              }
              return WelcomeScreen();
            },
          )),
    );
  }
}
