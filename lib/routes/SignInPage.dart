import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/svg.dart';
import 'SignUpPage.dart';
import 'home.dart';

class SignInPage extends StatefulWidget {
  SignInPage(void Function() toggleView);



  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage>{

  String email;
  String password;
  bool obscureText=true;



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
         body: Container(
           width: double.infinity,
           height: size.height,
           child: Stack(
             alignment: Alignment.center,
             children: <Widget>[
               Positioned(
                 top: 0,
                 left: 0,
                 child: Image.asset(
                   'assets/image6.png',
                   width: size.width * 0.35,
                 ),
               ),
               Positioned(
                 bottom: 0,
                 right: 0,
                 child: Image.asset(
                   'assets/image7.png',
                   width: size.width * 0.4,
                 ),
               ),

               SingleChildScrollView(
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: <Widget>[
                     Text(
                       "LOGIN",
                       style: TextStyle(fontWeight: FontWeight.bold),
                     ),
                     SizedBox(height: size.height * 0.03),
                     SvgPicture.asset(
                       'assets/image4.png',
                       height: size.height * 0.35,
                     ),
                     SizedBox(height: size.height * 0.03),

                 Container(
                     margin: EdgeInsets.symmetric(vertical: 10),
                     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                     width: size.width * 0.8,
                     decoration: BoxDecoration(
                       color: Color(0xFFF1E6FF),
                       borderRadius: BorderRadius.circular(29),
                     ),
                     child: TextField(
                         onChanged: (value) {
                           setState(() {
                             email=value;
                           });
                         },
                         cursorColor: Color(0xFF6F35A5),
                         decoration: InputDecoration(
                           icon: Icon(
                             Icons.person,
                             color: Color(0xFF6F35A5),
                           ),
                           hintText: "Entrez l'email",
                           border: InputBorder.none,
                         ),
                       ),
                     ),

                 Container(
                   margin: EdgeInsets.symmetric(vertical: 10),
                   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                   width: size.width * 0.9,
                   decoration: BoxDecoration(
                     color: Color(0xFFF1E6FF),
                     borderRadius: BorderRadius.circular(29),
                   ),
                   child: TextField(
                       obscureText: obscureText,
                       onChanged: (value) {
                         setState(() {
                           password=value;
                         });
                       },
                       cursorColor: Color(0xFF6F35A5),
                       decoration: InputDecoration(
                         hintText: "Entrez le mot de passe",
                         icon: Icon(
                           Icons.lock,
                           color: Color(0xFF6F35A5),
                         ),
                         suffixIcon: IconButton(
                             icon: Icon(
                               Icons.visibility,
                               color: Color(0xFF6F35A5),
                             ),
                           onPressed: () {
                               setState(() {
                                 obscureText=!obscureText;
                               });
                           },
                         ),
                         border: InputBorder.none,
                       ),
                     ),
                   ),


                     Container(
                       margin: EdgeInsets.symmetric(vertical: 10),
                       width: size.width * 0.8,
                       child: ClipRRect(
                         borderRadius: BorderRadius.circular(29),
                         child: FlatButton(
                           padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                           color: Color(0xFF6F35A5),
                           onPressed: () {
                            signIn();
                           },
                           child: Text(
                             "Se connecter",
                             style: TextStyle(color: Colors.white),
                           ),
                         ),
                       ),
                     ),

                     SizedBox(height: size.height * 0.03),

                     Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: <Widget>[
                         Text(
                           "Pas encore inscrit ?",
                           style: TextStyle(color: Colors.purple),
                         ),
                         GestureDetector(
                           onTap: (){
                             Navigator.push(
                               context,
                               MaterialPageRoute(
                                 builder: (context) {
                                   return SignUpPage(signIn());
                                 },
                               ),
                             );
                           },
                           child: Text(
                             "Creez votre compte",
                             style: TextStyle(
                               color: Colors.purple,
                               fontWeight: FontWeight.bold,
                             ),
                           ),
                         )
                       ],
                     )


                   ],
                 ),
               ),
             ],
           ),
         ),
    );
  }



  signIn() async{
    try {
       await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
       Navigator.push(
         context,
         MaterialPageRoute(
           builder: (context) {
             return HomePage();
           },
         ),
       );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        alerte('Etes-vous sur d\'etre inscrit ?');
      } else if (e.code == 'wrong-password') {
        alerte('Mot de passe incorrect');
      }
    }
  }

  lostPassword(String email, String mdp) async{

    EmailAuthCredential credential = EmailAuthProvider.credential(email: email, password: password);

    await FirebaseAuth.instance.currentUser.reauthenticateWithCredential(credential);
  }

  alerte(String data){
      return showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return new AlertDialog(
              title: new Text(
                data,
              ),
            );
          }
      );
  }



}