
import 'package:argon_flutter/backend/net/flutterfire.dart';
import 'package:argon_flutter/constants/Theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class settingsUI extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "settings UI",
      home: EditProfilePage(),
    );
  }
}

class EditProfilePage extends StatefulWidget{

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}
class _EditProfilePageState extends State<EditProfilePage>{
  bool showPassword = false;
  final firstNameEditingController = new TextEditingController();
  final lastNameEditingController = new TextEditingController();
  final addressEditingController = new TextEditingController();
  final phoneNumberEditingController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: MyTheme.primary,
          ),
          onPressed: () =>Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: MyTheme.primary,
            ),
            onPressed: () {

            },
          ),
        ],
      ),
    body: Container(
      padding: EdgeInsets.only(left: 16, top: 25, right: 16),
      child: ListView(
        children: [
          Text(
            "Editar Perfil",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 15,
          ),
          //imagen de perfil
          Center(
            child: Stack(
              children: [
                Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 4,
                          color: Theme.of(context).scaffoldBackgroundColor),
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.1),
                            offset: Offset(0, 10))
                      ],
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            "https://images.pexels.com/photos/3307758/pexels-photo-3307758.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=250",
                          ))),
                ),
                Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 4,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                        color: MyTheme.primary,
                      ),
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    )),
              ],
            ),
          ),
          SizedBox(
            height: 35,
          ),
         FutureBuilder(
          future: getUserInfo(),
          builder: (context, snapshot) {
              if(snapshot.hasData) {
              return buildTextField("Nombre",snapshot.data['firstName'], false, firstNameEditingController);

              } else {return CircularProgressIndicator();
              }}),
          FutureBuilder(
              future: getUserInfo(),
              builder: (context, snapshot) {
                if(snapshot.hasData) {
                  return buildTextField("Apellido",snapshot.data['lastName'], false, lastNameEditingController);

                } else {return CircularProgressIndicator();
                }}),
          FutureBuilder(
              future: getUserInfo(),
              builder: (context, snapshot) {
                if(snapshot.hasData) {
                  return buildTextField("Dirección de Entrega","-", false, addressEditingController);

                } else {return CircularProgressIndicator();
                }}),
          FutureBuilder(
              future: getUserInfo(),
              builder: (context, snapshot) {
                if(snapshot.hasData) {
                  return buildTextField("Telefono",snapshot.data['phoneNumber'], false, phoneNumberEditingController);

                } else {return CircularProgressIndicator();
                }}),
          SizedBox(
            height: 35,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RaisedButton(
                onPressed: () async {
                  bool updated = await addInformation(firstNameEditingController.text, lastNameEditingController.text, addressEditingController.text, phoneNumberEditingController.text);
                  if(updated) {
                    // un toast
                  } else {
                    // otro toast, o cargando, vemos que queda mejor
                  }
                },
                color: MyTheme.primary,
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  "Guardar",
                  style: TextStyle(
                      fontSize: 14,
                      letterSpacing: 2.2,
                      color: Colors.white),
                ),
              )
            ],
          )
        ],
      ),
    ),
    );
  }
  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        controller: controller,
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
              onPressed: () {
                setState(() {
                  showPassword = !showPassword;
                });
              },
              icon: Icon(
                Icons.remove_red_eye,
                color: Colors.grey,
              ),
            )
                : null,
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }
}