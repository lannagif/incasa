import 'package:flutter/material.dart';
import 'package:incasa/app/telas/email_login_pgs/email_sign_in_form_change_notifier.dart';


class EmailSignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFFE985),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text('Login com Email',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            child: EmailSignInFormChangeNotifier.create(context),
          ),
        ),
      ),
      backgroundColor: Color(0xFFFFE985),
    );
  }
}
