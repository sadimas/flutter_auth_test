import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_test/screens/current_page.dart';
import 'package:flutter_auth_test/utils/authencation.dart';
import 'package:flutter_auth_test/utils/authuser.dart';
import 'package:provider/provider.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

 
  @override
  Widget build(BuildContext context) {
    return StreamProvider <AuthUser?>.value(
      value: AuthUtil().currentUser,
        initialData: null,
        child: MaterialApp(
        title: 'Flutter Auth Test',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: CurrentPage(),
      ),
    );
    
  }
}

