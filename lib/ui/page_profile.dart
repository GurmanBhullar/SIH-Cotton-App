import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ui_collections/ui/edit_profile.dart';
import 'package:flutter_ui_collections/ui/page_login.dart';
import 'package:flutter_ui_collections/ui/photo_list.dart';
import 'package:flutter_ui_collections/utils/utils.dart';
import 'package:flutter_ui_collections/widgets/utils_widget.dart';
import 'package:flutter_ui_collections/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  String email;

  ProfilePage({this.email});

  @override
  _ProfilePageState createState() => _ProfilePageState(email);
}

class _ProfilePageState extends State<ProfilePage> {
  Screen size;
  String email;

  _ProfilePageState(this.email);

  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);
    return StreamBuilder(
        stream:
            Firestore.instance.collection('users').document(email).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return new Text("Loading");
          }
          var userDocument = snapshot.data;
          return new Scaffold(
            drawer: Drawer(
              child: ListView(
                // Important: Remove any padding from the ListView.
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    child: Center(
                        child: Text(
                      'CottN',
                      style: TextStyle(color: Colors.white),
                    )),
                    decoration: BoxDecoration(
                      color: colorCurve,
                    ),
                  ),
                  ListTile(
                    title: Text('Contact Us'),
                    onTap: () {
                      // Update the state of the app.
                      // ...
                    },
                  ),
                  ListTile(
                    title: Text('Log Out'),
                    onTap: () {
                      // Update the state of the app.
                      // ...
                    },
                  ),
                ],
              ),
            ),
            appBar: AppBar(
              title: Center(child: Text("Profile")),
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(Icons.share),
                ),
              ],
              backgroundColor: colorCurve,
              elevation: 50.0,
            ),
            body: AnnotatedRegion(
              value: SystemUiOverlayStyle(
                  statusBarColor: colorCurveSecondary,
                  statusBarBrightness: Brightness.dark,
                  statusBarIconBrightness: Brightness.dark,
                  systemNavigationBarIconBrightness: Brightness.dark,
                  systemNavigationBarColor: backgroundColor),
              child: Container(
                child: SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  child: Column(
                    children: <Widget>[
                      upperPart(userDocument["Username"].toString()),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Divider(thickness: 4, color: colorCurve),
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                          child: Container(
                            width: 330,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: colorCurveSecondary, width: 3),
                                borderRadius: new BorderRadius.circular(20.0)),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        latestText("Email : "),
                                        latestText(email)
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        latestText("Username : "),
                                        latestText(
                                            userDocument["Username"].toString())
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        latestText("Phone Number : "),
                                        latestText(
                                            userDocument["Phone"].toString())
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        latestText("Location : "),
                                        latestText(
                                            userDocument["Location"].toString())
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
          ;
        });
  }

  Widget upperPart(String username) {
    return Stack(children: <Widget>[
      ClipPath(
        clipper: UpperClipper(),
        child: Container(
          height: size.getWidthPx(160),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo, Colors.indigoAccent],
            ),
          ),
        ),
      ),
      Column(
        children: <Widget>[
          profileWidget(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              followersWidget(),
              nameWidget(username),
              likeWidget(),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
                top: size.getWidthPx(8),
                left: size.getWidthPx(20),
                right: size.getWidthPx(20)),
            child: Container(height: size.getWidthPx(4), color: colorCurve),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: size.getWidthPx(4),
                    horizontal: size.getWidthPx(12)),
                child: RaisedButton(
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(22.0)),
                  padding: EdgeInsets.all(size.getWidthPx(2)),
                  child: Text(
                    "Edit Profile",
                    style: TextStyle(
                        fontFamily: 'Exo2',
                        color: Colors.white,
                        fontSize: 14.0),
                  ),
                  color: colorCurve,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditProfile(
                                  email: email,
                                )));
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: size.getWidthPx(4),
                    horizontal: size.getWidthPx(12)),
                child: RaisedButton(
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(22.0)),
                  padding: EdgeInsets.all(size.getWidthPx(2)),
                  child: Text(
                    'Log Out',
                    style: TextStyle(
                        fontFamily: 'Exo2',
                        color: Colors.white,
                        fontSize: 14.0),
                  ),
                  color: colorCurve,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                ),
              ),
              //buttonWidget("Log Out"),
            ],
          ),
        ],
      )
    ]);
  }

  GestureDetector followerAvatarWidget(String assetIcon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        maxRadius: size.getWidthPx(24),
        backgroundColor: Colors.transparent,
        child: Icon(Icons.account_circle),
      ),
    );
  }

  Container buttonWidget(text) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: size.getWidthPx(4), horizontal: size.getWidthPx(12)),
      child: RaisedButton(
        elevation: 8.0,
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(22.0)),
        padding: EdgeInsets.all(size.getWidthPx(2)),
        child: Text(
          text,
          style: TextStyle(
              fontFamily: 'Exo2', color: Colors.white, fontSize: 14.0),
        ),
        color: colorCurve,
        onPressed: () {},
      ),
    );
  }

  Align profileWidget() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        margin: EdgeInsets.only(top: size.getWidthPx(60)),
        child: CircleAvatar(
          foregroundColor: backgroundColor,
          maxRadius: size.getWidthPx(50),
          backgroundColor: Colors.white,
          child: CircleAvatar(
            maxRadius: size.getWidthPx(72),
            foregroundColor: colorCurve,
            backgroundImage: NetworkImage(
                'https://cdn4.iconfinder.com/data/icons/linecon/512/photo-512.png'),
          ),
        ),
      ),
    );
  }

  Column likeWidget() {
    return Column(
      children: <Widget>[
        Text("",
            style: TextStyle(
                fontFamily: "Exo2",
                fontSize: 16.0,
                color: textSecondary54,
                fontWeight: FontWeight.w700)),
        SizedBox(height: size.getWidthPx(4)),
        Text("",
            style: TextStyle(
                fontFamily: "Exo2",
                fontSize: 14.0,
                color: textSecondary54,
                fontWeight: FontWeight.w500))
      ],
    );
  }

  Column nameWidget(String username) {
    return Column(
      children: <Widget>[
        Text(username,
            style: TextStyle(
                fontFamily: "Exo2",
                fontSize: 16.0,
                color: colorCurve,
                fontWeight: FontWeight.w700)),
        SizedBox(height: size.getWidthPx(4)),
        Text("Farmer",
            style: TextStyle(
                fontFamily: "Exo2",
                fontSize: 14.0,
                color: textSecondary54,
                fontWeight: FontWeight.w500))
      ],
    );
  }

  Column followersWidget() {
    return Column(
      children: <Widget>[
        Text("",
            style: TextStyle(
                fontFamily: "Exo2",
                fontSize: 16.0,
                color: textSecondary54,
                fontWeight: FontWeight.w700)),
        SizedBox(height: size.getWidthPx(4)),
        Text("",
            style: TextStyle(
                fontFamily: "Exo2",
                fontSize: 14.0,
                color: textSecondary54,
                fontWeight: FontWeight.w500))
      ],
    );
  }
}

GradientText latestText(String text) {
  return GradientText(text,
      gradient: LinearGradient(colors: [
//        Color.fromRGBO(45, 160, 240, 1.0),
//        Color.fromRGBO(45, 160, 240, 1.0)
        colorCurve, colorCurve
      ]),
      style: TextStyle(
          fontFamily: 'Exo2', fontSize: 18, fontWeight: FontWeight.bold));
}
