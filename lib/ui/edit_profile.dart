import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ui_collections/utils/utils.dart';
import 'package:flutter_ui_collections/widgets/boxfield.dart';

class EditProfile extends StatefulWidget {
  String email;
  EditProfile({this.email});
  @override
  _EditProfileState createState() => _EditProfileState(email);
}

class _EditProfileState extends State<EditProfile> {
  String email;
  String Username;
  String PhoneNo;
  String Location;
  Screen size;
  String _Username;
  _EditProfileState(this.email);
  TextEditingController unController;
  TextEditingController pnController;
  TextEditingController lcController;
  @override
  void initState() {
    // TODO: implement initState
    Firestore.instance
        .collection('users')
        .document(email)
        .get()
        .then((DocumentSnapshot ds) {
      unController = TextEditingController(text: ds["Username"]);
      pnController = TextEditingController(text: ds["Phone"]);
      lcController = TextEditingController(text: ds["Location"]);
      // use ds as a snapshot
    });
    super.initState();
  }

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
            appBar: AppBar(
              title: Center(child: Text("Edit Profile")),
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
                margin: EdgeInsets.symmetric(
                    horizontal: size.getWidthPx(20),
                    vertical: size.getWidthPx(20)),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 40, 0, 0),
                          child: Text(
                            "Username",
                            style: TextStyle(
                                fontSize: 16,
                                color: colorCurve,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                          child: BoxField(
                              controller: unController,
                              lableText: "Username",
                              obscureText: false,
                              onChanged: (String val) {
                                setState(() {
                                  _Username = val;
                                });
                              },
                              icon: Icons.person,
                              hintText: userDocument["Username"].toString(),
                              iconColor: colorCurve),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                          child: Text(
                            "Phone Number",
                            style: TextStyle(
                                fontSize: 16,
                                color: colorCurve,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                          child: BoxField(
                              controller: pnController,
                              lableText: "Phone Number",
                              obscureText: false,
                              onChanged: (String val) {
                                PhoneNo = val;
                              },
                              icon: Icons.phone,
                              hintText: userDocument["Phone"].toString(),
                              iconColor: colorCurve),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                          child: Text(
                            "Location",
                            style: TextStyle(
                                fontSize: 16,
                                color: colorCurve,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                          child: BoxField(
                              controller: lcController,
                              lableText: "Location",
                              obscureText: false,
                              onChanged: (String val) {
                                Location = val;
                              },
                              icon: Icons.location_on,
                              hintText: userDocument["Location"].toString(),
                              iconColor: colorCurve),
                        ),
                        Center(
                            child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: Container(
                            child: RaisedButton(
                              elevation: 8.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 14, 20, 14),
                                child: Text(
                                  "Confirm Changes",
                                  style: TextStyle(
                                      fontFamily: 'Exo2',
                                      color: Colors.white,
                                      fontSize: 16.0),
                                ),
                              ),
                              color: colorCurve,
                              onPressed: () {
                                Firestore.instance
                                    .collection('users')
                                    .document(email)
                                    .updateData({
                                  'Username': unController.text,
                                  'Phone': pnController.text,
                                  'Location': lcController.text
                                });
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
