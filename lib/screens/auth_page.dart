import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:flutter_auth_test/utils/authencation.dart';
import 'package:flutter_auth_test/utils/authuser.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  late String _password;
  late String _email;
  bool showRegister = false;
  AuthUtil _authUtil = AuthUtil();

  @override
  Widget build(BuildContext context) {
    Widget _input(Icon icon, String hint, TextEditingController controller,
        bool obscureText) {
      return Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: TextField(
          obscureText: obscureText,
          controller: controller,
          decoration: InputDecoration(
              hintText: hint,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 3),
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70, width: 1)),
              prefixIcon: Padding(
                padding: EdgeInsets.only(left: 8, right: 8),
                child: IconTheme(
                  data: IconThemeData(color: Colors.white),
                  child: icon,
                ),
              )),
        ),
      );
    }

    Widget _btn(String text, void func()) {
      return ElevatedButton(
          onPressed: () {
            func();
          },
          child: Text(text));
    }

    Widget _regForm(String label, void func()) {
      return Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 25, top: 10),
              child:
                  _input(Icon(Icons.email), 'EMAIL', _emailController, false),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 25),
              child: _input(
                  Icon(Icons.lock), 'PASSWORD', _passwordController, true),
            ),
            SizedBox(height: 25),
            Padding(
                padding: const EdgeInsets.only(left: 25, right: 25),
                child: Container(
                  height: 50,
                  width: 300,
                  child: _btn(label, func),
                )),
          ],
        ),
      );
    }

    void _signInButtonClick() async {
      _password = _passwordController.text;
      _email = _emailController.text;

      if (_email.isEmpty || _password.isEmpty) return;

      AuthUser? user = await _authUtil.signInWithEmailAndPassword(
          _email.trimLeft(), _password.trimLeft());
      if (user == null) {
        Fluttertoast.showToast(
            msg: "Something wrong! Please, check Email or Password",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        _passwordController.clear();
        _emailController.clear();
      }
    }

    void _signUpButtonClick() async {
      _password = _passwordController.text;
      _email = _emailController.text;

      if (_email.isEmpty || _password.isEmpty) return;

      AuthUser? user = await _authUtil.signUpWithEmailAndPassword(
          _email.trimLeft(), _password.trimLeft());
      if (user == null) {
        Fluttertoast.showToast(
            msg: "Can\'t registration! Please, check Email or Password",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        _passwordController.clear();
        _emailController.clear();
      }
    }

    return Scaffold(
        backgroundColor: Theme.of(context).primaryColorLight,
        body: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 30),
            child: Center(
                child: Text(
              'Registration Form',
              style: TextStyle(fontSize: 30, color: Colors.white),
            )),
          ),
          (!showRegister
              ? Column(
                  children: <Widget>[
                    _regForm('SIGN IN', _signInButtonClick),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: GestureDetector(
                        child: Text('If you haven\'t an account, SIGN UP!'),
                        onTap: () {
                          setState(() {
                            showRegister = true;
                          });
                        },
                      ),
                    )
                  ],
                )
              : Column(
                  children: <Widget>[
                    _regForm('SIGN UP', _signUpButtonClick),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: GestureDetector(
                        child: Text('Have an account? SIGN IN!'),
                        onTap: () {
                          setState(() {
                            showRegister = false;
                          });
                        },
                      ),
                    )
                  ],
                ))
        ]));
  }
}
