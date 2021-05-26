import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ui_collections/ui/page_news.dart';
import 'package:flutter_ui_collections/ui/page_profile.dart';
import 'package:flutter_ui_collections/ui/page_profile.dart';
import 'package:flutter_ui_collections/ui/page_news.dart';
import 'package:flutter_ui_collections/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_ui_collections/ui/page_login.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_ui_collections/widgets/gradient_text.dart';

class SearchPage extends StatefulWidget {
  String email;

  SearchPage({this.email});

  @override
  _SearchPageState createState() => _SearchPageState(email);
}

class _SearchPageState extends State<SearchPage> {
  String email;
  String latitude, longitude;
  String locationString = "Location Not Detected";
  String city;

  _SearchPageState(this.email);

  void getLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> p = await Geolocator()
        .placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = p[0];
    city = place.locality;
    setState(() {
      latitude = position.latitude.toString();
      longitude = position.longitude.toString();
      locationString = "You're in $city";
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor:
          colorCurveSecondary, //or set color with: Color(0xFF0000FF)
    ));
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
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                children: <Widget>[
                  new SizedBox(
                    height: 170.0,
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: new DrawerHeader(
                          decoration: new BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: <Color>[
                                    colorCurve,
                                    colorCurveSecondary
                                  ]),
                              image: DecorationImage(
                                image:
                                    AssetImage("assets/icons/logo_splash.png"),
                                fit: BoxFit.scaleDown,
                              )),
                          child:
                              new Text('', style: TextStyle(color: colorCurve)),
                          margin: EdgeInsets.fromLTRB(0.0, 24, 0, 20),
                          padding: EdgeInsets.fromLTRB(0.0, 0, 0, 0)),
                    ),
                  ),
                  CustomListTile(
                      Icons.person,
                      "Profile",
                      () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProfilePage())),
                          }),
                  CustomListTile(
                      Icons.forum,
                      "Forum",
                      () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage())),
                          }),
                  CustomListTile(
                      Icons.dvr,
                      "Cotton News",
                      () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NewsPage())),
                          }),
                  CustomListTile(
                      Icons.phone,
                      "Contact Us",
                      () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage())),
                          }),
                  CustomListTile(
                      Icons.exit_to_app,
                      "Log Out",
                      () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage())),
                          }),
                ],
              ),
            ),
            appBar: AppBar(
              title: Center(child: Text("Dashboard")),
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(Icons.share),
                ),
              ],
              backgroundColor: colorCurve,
              elevation: 50.0,
            ),
            body: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child:
                      latestText("Welcome " + userDocument["Username"] + "!"),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 0, 25, 25),
                  child: Card(
                    color: colorCurveSecondary,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
                          child: Center(
                              child: Column(
                            children: <Widget>[
                              Text(
                                "You are in: ",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                                child: Text(userDocument["Location"],
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white)),
                              )
                            ],
                          )),
                        ),
                        Divider(
                          thickness: 2,
                          color: Colors.white,
                        ),
                        ButtonBar(
                          children: <Widget>[
                            FlatButton(
                              child: const Text(
                                'UPDATE LOCATION',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: getLocation,
                            ),
                            FlatButton(
                              child: const Text('',
                                  style: TextStyle(color: Colors.white)),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage()));
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                RaisedButton(
                  padding: const EdgeInsets.fromLTRB(78, 14, 78, 14),
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(20.0)),
                  color: colorCurveSecondary,
                  onPressed: () {},
                  child: new Text(
                    "Check Future Cotton Prices",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

GradientText latestText(String text) {
  return GradientText(text,
      gradient: LinearGradient(colors: [
        Color.fromRGBO(97, 6, 165, 1.0),
        Color.fromRGBO(45, 160, 240, 1.0)
      ]),
      style: TextStyle(
          fontFamily: 'Exo2', fontSize: 24, fontWeight: FontWeight.bold));
}

class CustomListTile extends StatelessWidget {
  IconData icon;
  String text;
  Function onTap;

  CustomListTile(this.icon, this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: InkWell(
          splashColor: colorCurveSecondary,
          onTap: onTap,
          child: Container(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(icon),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        text,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                if (icon != null) Icon(Icons.arrow_forward_ios)
              ],
            ),
          )),
    );
  }
}
