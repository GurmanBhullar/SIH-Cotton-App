import 'package:flutter/gestures.dart';
import 'package:flutter_ui_collections/ui/page_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui_collections/utils/utils.dart';
import 'package:flutter_ui_collections/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'page_home.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _contController = TextEditingController();
  FocusNode _nameFocusNode = FocusNode();
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passFocusNode = FocusNode();
  FocusNode _confirmPassFocusNode = FocusNode();
  String _name, _email, _password, _confirmPassword;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Screen size;

  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);

    return Scaffold(
        backgroundColor: backgroundColor,
        resizeToAvoidBottomInset: true,
        body: Stack(children: <Widget>[
          ClipPath(
              clipper: BottomShapeClipper(),
              child: Container(
                color: colorCurve,
              )),
          SingleChildScrollView(
            child: SafeArea(
              top: true,
              bottom: false,
              child: Container(
                margin: EdgeInsets.symmetric(
                    horizontal: size.getWidthPx(20),
                    vertical: size.getWidthPx(20)),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              color: colorCurve,
                            ),
                            onPressed: () => Navigator.pop(context, false),
                          ),
                          SizedBox(width: size.getWidthPx(10)),
                          _signUpGradientText(),
                        ],
                      ),
                      SizedBox(height: size.getWidthPx(10)),
                      SizedBox(height: size.getWidthPx(30)),
                      registerFields()
                    ]),
              ),
            ),
          )
        ]));
  }

//  RichText _textAccount() {
//    return RichText(
//      text: TextSpan(
//          text: "Hae you registed already? ",
//          children: [
//            TextSpan(
//              style: TextStyle(color: Colors.deepOrange),
//              text: 'Login here',
//              recognizer: TapGestureRecognizer()
//                ..onTap = () => Navigator.pop(context),
//            )
//          ],
//          style: TextStyle(fontFamily: 'Exo2',color: Colors.black87, fontSize: 16)),
//    );
//  }

  GradientText _signUpGradientText() {
    return GradientText('Sign Up',
        gradient: LinearGradient(colors: [
          Color.fromRGBO(97, 6, 165, 1.0),
          Color.fromRGBO(45, 160, 240, 1.0)
        ]),
        style: TextStyle(
            fontFamily: 'Exo2', fontSize: 36, fontWeight: FontWeight.bold));
  }

  BoxField _nameWidget() {
    return BoxField(
        controller: _nameController,
        focusNode: _nameFocusNode,
        hintText: "Enter Name",
        lableText: "Name",
        obscureText: false,
        onSaved: (String val) {
          _name = val;
        },
        onFieldSubmitted: (String value) {
          FocusScope.of(context).requestFocus(_emailFocusNode);
        },
        icon: Icons.person,
        iconColor: colorCurve);
  }

  BoxField _emailWidget() {
    return BoxField(
        controller: _emailController,
        focusNode: _emailFocusNode,
        hintText: "Enter Email ID",
        lableText: "Email",
        obscureText: false,
        onSaved: (String val) {
          _email = val;
        },
        onFieldSubmitted: (String value) {
          FocusScope.of(context).requestFocus(_passFocusNode);
        },
        icon: Icons.email,
        iconColor: colorCurve);
  }

  BoxField _passwordWidget() {
    return BoxField(
        controller: _passwordController,
        focusNode: _passFocusNode,
        hintText: "Enter Password",
        lableText: "Password",
        obscureText: true,
        icon: Icons.lock_outline,
        onSaved: (String val) {
          _password = val;
        },
        iconColor: colorCurve);
  }

  BoxField _contWidget() {
    return BoxField(
        controller: _contController,
        focusNode: _passFocusNode,
        hintText: "Enter Contact",
        lableText: "Phone No.",
        obscureText: false,
        icon: Icons.person,
        onSaved: (String val) {
          _password = val;
        },
        iconColor: colorCurve);
  }

  BoxField _confirmPasswordWidget() {
    return BoxField(
        controller: _confirmPasswordController,
        focusNode: _confirmPassFocusNode,
        hintText: "Enter Confirm Password",
        lableText: "Confirm Password",
        obscureText: true,
        icon: Icons.lock_outline,
        onSaved: (String val) {
          _confirmPassword = val;
        },
        iconColor: colorCurve);
  }

  Container _signUpButtonWidget() {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: size.getWidthPx(20), horizontal: size.getWidthPx(16)),
      width: size.getWidthPx(200),
      child: RaisedButton(
        elevation: 8.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        padding: EdgeInsets.all(size.getWidthPx(12)),
        child: Text(
          "Sign Up",
          style: TextStyle(
              fontFamily: 'Exo2', color: Colors.white, fontSize: 20.0),
        ),
        color: colorCurve,
        onPressed: () {
          signIn();
          // Going to DashBoard
        },
      ),
    );
  }

  GestureDetector socialCircleAvatar(String assetIcon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        maxRadius: size.getWidthPx(20),
        backgroundColor: Colors.white,
        child: Image.asset(assetIcon),
      ),
    );
  }

  registerFields() => Container(
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _nameWidget(),
                _contWidget(),
                _emailWidget(),
                _passwordWidget(),
                _confirmPasswordWidget(),
                SizedBox(
                  height: 20,
                ),
                _signUpButtonWidget(),
              ],
            )),
      );

  Future<void> signIn() async {
    final formState = _formKey.currentState;
    if (_passwordController.text == _confirmPasswordController.text) {
      if (formState.validate()) {
        formState.save();
        try {
          Fluttertoast.showToast(
              msg: "Fetching Location", toastLength: Toast.LENGTH_LONG);
          AuthResult user = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: _emailController.text,
                  password: _passwordController.text);
          Position position = await Geolocator()
              .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
          List<Placemark> p = await Geolocator()
              .placemarkFromCoordinates(position.latitude, position.longitude);
          Placemark place = p[0];
          String city = place.locality;
          Firestore.instance
              .collection('users')
              .document(_emailController.text)
              .setData({
            'Username': _nameController.text,
            'Phone': _contController.text,
            'Location': city
          });
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginPage()));
        } catch (e) {
          Fluttertoast.showToast(
              msg: "Wrong Credentials",
              toastLength: Toast.LENGTH_LONG,
              backgroundColor: Colors.black87,
              textColor: Colors.white);
          print(e.message);
        }
      }
    } else {
      Fluttertoast.showToast(
          msg: "Passwords Dont Match",
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.black87,
          textColor: Colors.white);
    }
  }
}
