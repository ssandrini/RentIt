import 'package:argon_flutter/screens/home.dart';
import 'package:argon_flutter/widgets/register-input.dart';
import 'package:flutter/material.dart';
import 'package:argon_flutter/constants/Theme.dart';
import 'package:argon_flutter/widgets/input.dart';
import 'package:argon_flutter/backend/net/flutterfire.dart';

import '../main.dart';
import 'onboarding.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  // final firstNameEditingController = new TextEditingController();
  // final lastNameEditingController = new TextEditingController();
  final emailEditingController = new TextEditingController();
  // final ageEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  // final confirmPasswordEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    //email field
    final emailField = TextFormField(
        autofocus: false,
        controller: emailEditingController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value.isEmpty) {
            return ("Ingrese un email válido");
          }
          // reg expression for email validation
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Ingrese un email válido");
          }
          return null;
        },
        // onSaved: (value) {
        //   firstNameEditingController.text = value;
        // },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //password field
    final passwordField = TextFormField(
        autofocus: false,
        controller: passwordEditingController,
        obscureText: true,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{6,}$');
          if (value.isEmpty) {
            return ("Este campo es requerido");
          } else if (!regex.hasMatch(value)) {
            return ("Mínimo 6 caracteres");
          }
          return "";
        },
        // onSaved: (value) {
        //   firstNameEditingController.text = value;
        // },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Contraseña",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //signup button
    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: MyTheme.primary,
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: null,
          // () async {
          //   bool shouldNavigate = await register(
          //       emailEditingController.text, passwordEditingController.text);
          //   if (shouldNavigate) {
          //     shouldNavigate = await addInformation(
          //         firstNameEditingController.text,
          //         lastNameEditingController.text,
          //         ageEditingController.text);
          //   }
          //   if (shouldNavigate) {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => MainPage(),
          //       ),
          //     );
          //   }
          // },
          child: Text(
            "Ingresar",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.red),
          onPressed: () {
            // passing this to our root
            Navigator.pushReplacementNamed(context, '/onboarding');
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                        height: 180,
                        child: Image.asset(
                          "assets/img/rentItLogo.png",
                          fit: BoxFit.contain,
                        )),
                    SizedBox(height: 20),
                    emailField,
                    SizedBox(height: 20),
                    passwordField,
                    SizedBox(height: 20),
                    loginButton,
                    SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
