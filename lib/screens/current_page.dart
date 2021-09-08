

import 'package:flutter/material.dart';
import 'package:flutter_auth_test/screens/auth_page.dart';
import 'package:flutter_auth_test/screens/home_page.dart';
import 'package:flutter_auth_test/utils/authuser.dart';
import 'package:provider/provider.dart';

class CurrentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthUser? user = Provider.of<AuthUser?>(context);
    final bool isSignIn = user != null;

    return isSignIn ? HomePage() : AuthPage();
  }
}
