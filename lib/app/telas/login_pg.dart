// import 'package:flutter/material.dart';
// import 'dart:async';
// import 'package:google_fonts/google_fonts.dart';
// //import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:incasa/app/servicos/autenticacao.dart';
//
// import 'package:incasa/app/components/const.dart';
// //import 'package:incasa/app/components/login/login_button.dart';
// //import 'package:incasa/app/telas/home_pg.dart';
//
//
//
// class LoginPg extends StatelessWidget {
//
//   LoginPg({@required this.auth});
//   final BaseAutenticacao auth;
//
//   Future<void> _signInWithGoogle() async {
//     try{
//       await auth.signInWithGoogle();
//       //return HomePg(auth: auth);
//     } catch (e){
//       print(e.toString());
//     }
//   }
//
//
//
//   //final TextEditingController nomeController = TextEditingController();
//   //final TextEditingController senhaController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: kPrimaryColor,
//         body: Padding(
//           padding: const EdgeInsets.only(top: 80),
//           child: Container(
//             alignment: Alignment.topCenter,
//             margin: EdgeInsets.symmetric(horizontal: 30),
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: <Widget>[
//                   Container(
//                       child: Image.asset('assets/imgs/casa.png'),
//                       decoration: BoxDecoration(
//                       color: Colors.yellow[100],
//                         borderRadius: BorderRadius.circular(36),
//                       ),
//                   ),
//                   SizedBox(height: 20,),
//                   Text(
//                     'InCasa',
//                     textAlign: TextAlign.center,
//                     style:
//                     GoogleFonts.openSans(color: Colors.black, fontSize: 28),
//                   ),
//                   SizedBox(height: 20),
//                   Text(
//                     'Escolha um método para entrar',
//                     textAlign: TextAlign.center,
//                     style:
//                     GoogleFonts.openSans(color: Colors.black, fontSize: 14),
//                   ),
//                   /*
//                   SizedBox(
//                     height: 50,
//                   ),
//                   // SizedBox(
//                   //   height: 50.0,
//                   //   child: _buildHeader(),
//                   // ),
//
//                   _buildTextField(null, 'Email'),
//                   SizedBox(height: 20),
//                   _buildTextField(null, 'Senha'),
//                   */
//
//
//                   SizedBox(height: 30),
//                   MaterialButton(
//                     color: Colors.black87,
//                     elevation: 0.1,
//                     minWidth: double.maxFinite,
//                     height: 50,
//                     onPressed: () {}, //() async {
//
//                     //},
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         //Icon(FontAwesomeIcons.google,
//                         //color: Colors.white,),
//                         Image.asset('assets/imgs/logos/email.png'),
//                         SizedBox(width: 15),
//                         Text('Entrar com o Email',
//                             style: TextStyle(color: kPrimaryColor, fontSize: 18.0)),
//                       ],
//                     ),
//                     textColor: Colors.white,
//                   ),
//                   SizedBox(height: 30),
//
//                   MaterialButton(
//                     elevation: 0.1,
//                     minWidth: double.maxFinite,
//                     height: 50,
//                     onPressed: _signInWithGoogle, //() async {
//                       /*
//                       final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
//                       final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//
//                       final AuthCredential credential = GoogleAuthProvider.credential(idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
//                       final User user = (await FirebaseAuth.instance.signInWithCredential(credential)).user;
//
//                        */
//                     //},
//                     color: Colors.black87,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         //Icon(FontAwesomeIcons.google,
//                         //color: Colors.white,),
//                         Image.asset('assets/imgs/logos/google-logo.png'),
//                         SizedBox(width: 15),
//                         Text('Entrar com o Google',
//                             style: TextStyle(color: kPrimaryColor, fontSize: 18.0)),
//                       ],
//                     ),
//                     textColor: Colors.white,
//                   ),
//                   SizedBox(height: 20),
//                 ],
//               ),
//             ),
//           ),
//         ));
//   }
//
//
//
//   _buildTextField(
//       TextEditingController controller, String labelText) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//       decoration: BoxDecoration(
//           color: kPrimaryColor, border: Border.all(color: Colors.black)),
//       child: TextField(
//         controller: controller,
//         style: TextStyle(color: Colors.black),
//         decoration: InputDecoration(
//             contentPadding: EdgeInsets.symmetric(horizontal: 10),
//             labelText: labelText,
//             labelStyle: TextStyle(color: Colors.black),
//             // prefix: Icon(icon),
//             border: InputBorder.none),
//       ),
//     );
//   }
// }
//
// /*
// Widget _buildHeader() {
//   if (isLoading) {
//     return Center(
//       child: CircularProgressIndicator(),
//     );
//   }
//   return Text(
//     'Entre',
//     textAlign: TextAlign.center,
//     style: TextStyle(
//       fontSize: 32.0,
//       fontWeight: FontWeight.w600,
//     ),
//   );
// }*/
