import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:robocode/Setup/signIn.dart';

class Home extends StatefulWidget {
  const Home({
    Key key,
    @required this.user
}):super(key:key);
  final FirebaseUser user;
  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: Icon(Icons.home),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                /*Text(
                  "Hello " + widget.user.email,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),*/
                SizedBox(height: 45.0),
              ],
            ),
          ),
        ),
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              //child:Column(

              //),
              child: Text(widget.user.email),
              decoration: BoxDecoration(
                  shape:  BoxShape.circle,
                  //color: Colors.greenAccent,
                  image: new DecorationImage(
                    //fit: BoxFit.none,
                      centerSlice: new Rect.fromLTWH(50.0, 50.0, 220.0, 90.0),
                      image: new AssetImage(
                        "assets/logo.png",
                      )
                    //NetworkImage(
                    //"http://jlouage.com/images/author.jpg")
                  )),
            ),
            ListTile(
              title: Text('Chose level'),
              selected: true,
              onTap: () {
                // Update the state of the app.
                // ...
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Edit profile'),
              onTap: () {
                // Update the state of the app.
                // ...
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Logout'),

              onTap: () {
                // Update the state of the app.
                // ...
                // Then close the drawer.
                signOut();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );

  }
  Future<void> signOut() async {
      try {
        await FirebaseAuth.instance.signOut();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      } catch (e) {
        print(e.message);
      }
  }
}