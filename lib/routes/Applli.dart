import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mobilehospital/routes/SignUpPage.dart';
import 'SignInPage.dart';
import 'Loading.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(Applli());
}

class Applli extends StatefulWidget {
  _ApplliState createState() => _ApplliState();
}

class _ApplliState extends State<Applli> {
  bool _initialized = false;
  bool _error = false;

  void Function() get toggleView => null;


  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch(e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }


  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    if(_error) {
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: Text(
                "Queleque chose s'est mal passé...Veuillez vérifiez que tout est bon de votre coté"
            ),
          ),
        ),
      );
    }

    // Show a loader until FlutterFire is initialized(loading screen)
    if (!_initialized) {
      return Loading();
    }

    //s'il y a internet on peut démarrer
    // if(_connectionStatus == true){
      MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primaryColor: Color(0xFF6F35A5),
            scaffoldBackgroundColor: Colors.white
        ),
        // home: MyHomePage(title: 'Flutter Demo Home Page'),
        home: Scaffold(
          body: SignInPage(toggleView),
        ),
        debugShowCheckedModeBanner: false,
      );
    // }

  }

}
