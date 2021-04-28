import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/svg.dart';

import 'SignInPage.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage(void Function() toggleView);


  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage>{

  String email;
  String password;
  bool obscureText=true;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body:Container(
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              'assets/image11.png',
              width: size.width * 0.35,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(
              'assets/image12.png',
              width: size.width * 0.25,
            ),
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "SIGNUP",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: size.height * 0.03),
                SvgPicture.asset(
                  'assets/signUp.svg',
                  height: size.height * 0.35,
                ),

                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  width: size.width * 0.8,
                  decoration: BoxDecoration(
                    color: Color(0xFFF1E6FF),
                    borderRadius: BorderRadius.circular(29),
                  ),
                  child: TextField(
                    onChanged: (value){
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
                      hintText: "Entrez Email",
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
                        signUp();
                      },
                      child: Text(
                        "S'inscrire",
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
                      " Vous avez déja un compte ? ",
                      style: TextStyle(color: Colors.purple),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return SignInPage(signUp());
                            },
                          ),
                        );
                      },
                      child: Text(
                        "Connectez-vous",
                        style: TextStyle(
                          color: Colors.purple,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),

                Container(
                  margin: EdgeInsets.symmetric(vertical: size.height * 0.02),
                  width: size.width * 0.8,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Divider(
                          color: Color(0xFFD9D9D9),
                          height: 1.5,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "OU",
                          style: TextStyle(
                            color: Color(0xFFF1E6FF),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Color(0xFFD9D9D9),
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),


                //Supprimer la Row si l'auth par reseaux sociaux ne vous interesse plus
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 2,
                            color: Color(0xFFF1E6FF),
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset(
                          'assets/login.svg',
                          height: 20,
                          width: 20,
                        ),
                      ),
                    ),

                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 2,
                            color: Color(0xFFF1E6FF),
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset(
                          'assets/play.svg',
                          height: 20,
                          width: 20,
                        ),
                      ),
                    ),


                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 2,
                            color: Color(0xFFF1E6FF),
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset(
                          'assets/sun.png',
                          height: 20,
                          width: 20,
                        ),
                      ),
                    ),

                  ],
                )


              ],
            ),
          )
        ],
      ),
    )
   );
  }

  signUp() async{
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('Le mot de passe est trop faible');
      } else if (e.code == 'email-already-in-use') {
        print('Ce compt existe déja pour cet e-mail');
      }
    } catch (e) {
      print(e);
    }
    if (!FirebaseAuth.instance.currentUser.emailVerified) {
      await FirebaseAuth.instance.currentUser.sendEmailVerification();
    }
  }

}