import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:file_picker/file_picker.dart';
import '../main.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{

  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instanceFor();
  String username;
  String key = "username";
  double value = 0;
  var user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  //Si vous voulez changer la couleur de fond
                  Colors.blue[400],
                  Colors.blue[800]
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter
              )
            ),
          ),

          SafeArea(
            child: Container(
              width: 200.0,
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  DrawerHeader(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                      getImageProfile(),

                        SizedBox(
                          height: 10.0,
                        ),

                        //le nom d'utilisateur est unique et ne peut etre mis a jour qu'une fois
                        Text((user==null)? "Undefined" : user.displayName,style: TextStyle(color: Colors.white,fontSize: 20.0)),
                      ],
                    ),
                  ),

                  Expanded(
                    child: ListView(
                      children: [
                        ListTile(
                          onTap: (){
                          },
                          leading: Icon(Icons.home,color: Colors.white),
                          title: Text('Home',style: TextStyle(color:Colors.white),),
                        ),

                        ListTile(
                          onTap: (){
                          },
                          leading: Icon(Icons.book,color: Colors.white),
                          title: Text('Mes Cours',style: TextStyle(color:Colors.white),),
                        ),

                        ListTile(
                          onTap: (){
                            signOut();
                          },
                          leading: Icon(Icons.logout,color: Colors.white),
                          title: Text('Déconnexion',style: TextStyle(color:Colors.white),),
                        )

                      ],
                    ),
                  )
                ],
              ),
            ),
          ),


          TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: value),
              duration: Duration(milliseconds: 500),
              curve: Curves.easeIn,
              builder: (_,double val,__){
                return (Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..setEntry(0, 3, 200 * val)
                      ..rotateY((pi/6)*val),
                  child: Center(
                    child: Scaffold(
                      appBar: AppBar(
                        centerTitle: true,
                        title: Text("Bienvenue sur..."),
                        backgroundColor: Colors.blue,
                      ),
                      body: Center(

                        //Voir fonction userIsDefined pour inserer des elements dans le Scaffold ligne 233
                        child: userIsDefined(),
                        ),
                      ),
                    ),
                  )
                );
              }
          ),

          GestureDetector(
            onHorizontalDragUpdate: (e){
              if(e.delta.dx > 0){
                setState(() {
                  value = 1;
                });
              }else{
                setState(() {
                  value = 0;
                });
              }
            },
          )

        ],
      ),
    );
  }


  signOut() async{
    await FirebaseAuth.instance.signOut();
    Navigator.push(
        context,
        MaterialPageRoute(
        builder: (context) {
      return App();
      },
     )
    );
  }

  userIsDefined() {
    Size size = MediaQuery.of(context).size;
    if(FirebaseAuth.instance.currentUser.displayName==null){
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          //Textfield du username
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
                  username=value;
                });
              },
              cursorColor: Color(0xFF6F35A5),
              decoration: InputDecoration(
                icon: Icon(
                  Icons.person,
                  color: Color(0xFF6F35A5),
                ),
                hintText: "Entrez le nom d'utilisateur",
                border: InputBorder.none,
              ),
            ),
          ),


          //bouton de mise a jour du username
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            width: size.width * 0.8,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(29),
              child: FlatButton(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                color: Color(0xFF6F35A5),
                onPressed: () {

                  if(user !=null){
                    user.updateProfile(
                      displayName: username,
                    );
                  }
                  userIsDefined();
                },
                child: Text(
                  "Confirmer",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      );
    }
    else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //Inserer ce que vous voulez ici
          Text('Swipe to the right pour acceder au second menu')
        ],
      );
    }
  }

  Future <void>uploadImage() async{
    FilePickerResult result = await FilePicker.platform.pickFiles(type: FileType.image);
    user.updateProfile(
      photoURL: result.files.first.path
    );
    print(result.files.first.path);
    getImageProfile();
  }

  getImageProfile(){
    if (user.photoURL==null) {
      return GestureDetector(
        onTap: (){
          uploadImage();
        },
        child: CircleAvatar(
          radius: 50.0,
          backgroundColor: Colors.black12,
        ),
      );
    } else {
      return GestureDetector(
        onTap: (){
          uploadImage();
        },
        child: CircleAvatar(
          radius: 50.0,
          backgroundImage: NetworkImage(user.photoURL),
        ),
      );
    }
  }



}