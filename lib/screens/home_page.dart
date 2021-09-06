import 'package:flutter/material.dart';
import 'package:flutter_auth_test/utils/authencation.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          title: Text('Welcome'),
          leading: Icon(Icons.exit_to_app),
          actions: <Widget>[
            TextButton.icon(
                onPressed: () {
                  AuthUtil().logOut();
                },
                icon: Icon(Icons.supervisor_account),
                label: SizedBox.shrink())
          ],
        ),
      ),
    );
  }
}
