import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:incasa/app/telas/email_login_pgs/email_sign_in_page.dart';
import 'package:incasa/app/telas/email_login_pgs/sign_in_manager.dart';
import 'package:incasa/app/telas/email_login_pgs/sign_in_button.dart';
import 'package:incasa/app/telas/email_login_pgs/social_sign_in_button.dart';
import 'package:incasa/app/components/show_exception_alert_dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:incasa/app/services/autentication.dart';
import 'package:incasa/app/components/const.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({
    Key key,
    @required this.manager,
    @required this.isLoading,
  }) : super(key: key);
  final SignInManager manager;
  final bool isLoading;

  static const Key emailPasswordKey = Key('email-password');

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return ChangeNotifierProvider<ValueNotifier<bool>>(
      create: (_) => ValueNotifier<bool>(false),
      child: Consumer<ValueNotifier<bool>>(
        builder: (_, isLoading, __) => Provider<SignInManager>(
          create: (_) => SignInManager(auth: auth, isLoading: isLoading),
          child: Consumer<SignInManager>(
            builder: (context, manager, _) => SignInPage(
              manager: manager,
              isLoading: isLoading.value,
            ),
          ),
        ),
      ),
    );
  }

  void _showSignInError(BuildContext context, FirebaseException exception) {
    showExceptionAlertDialog(
      context,
      title: 'Algo deu errado ao entrar',
      exception: exception,
    );
  }



  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      await manager.signInWithGoogle();
    } on FirebaseException catch (e) {
      if (e.code != 'ERROR_ABORTED_BY_USER') {
        _showSignInError(context, e);
      }
    }
  }


  void _signInWithEmail(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (context) => EmailSignInPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 30,),
                Container(
                  child: Image.asset('assets/imgs/casa2.png'),
                  decoration: BoxDecoration(
                    color: Colors.yellow[100],
                    borderRadius: BorderRadius.circular(36),
                  ),
                ),
                SizedBox(height: 20,),
                _buildContent(context),
              ],
            ),
          ),
        ),

      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildHeader(),
          SizedBox(height: 20.0),
          SocialSignInButton(
            assetName: 'assets/imgs/logos/google-logo.png',
            text: 'Entrar com Google',
            textColor: Colors.white,
            color: Colors.black87,
            onPressed: isLoading ? null : () => _signInWithGoogle(context),
          ),
          SizedBox(height: 20.0),
          SignInButton(
            assetName: 'assets/imgs/logos/email.png',
            key: emailPasswordKey,
            text: 'Entrar com Email',
            textColor: Colors.white,
            color: Colors.black87,
            onPressed: isLoading ? null : () => _signInWithEmail(context),
          ),
          SizedBox(height: 8.0),

        ],
      ),
    );
  }

  Widget _buildHeader() {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Column(
      children: [
        Text(
          'InCasa',
          textAlign: TextAlign.center,
          style:
          GoogleFonts.openSans(color: Colors.black, fontSize: 28),
        ),
        SizedBox(height: 20),
        Text(
          'Escolha um método para entrar',
          textAlign: TextAlign.center,
          style:
          GoogleFonts.openSans(color: Colors.black, fontSize: 14),
        ),
        SizedBox(height: 20.0),
      ],
    );
  }
}