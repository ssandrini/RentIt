import 'package:argon_flutter/backend/models/publication-model.dart';
import 'package:argon_flutter/backend/net/flutterfire.dart';
import 'package:argon_flutter/constants/Theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:argon_flutter/widgets/navbar.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:smart_select/smart_select.dart';

class settingsUI extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "settings UI",
      home: NewPublicationScreen(),
    );
  }
}

class NewPublicationScreen extends StatefulWidget{

  @override
  NewPublicationScreenState createState() => NewPublicationScreenState();
}
class NewPublicationScreenState extends State<NewPublicationScreen> {
  static TextEditingController _nameField = TextEditingController();
  static TextEditingController _detailField = TextEditingController();
  static TextEditingController _priceField = TextEditingController();
  static List<S2Choice<String>> options = [
    S2Choice<String>(value: 'Bicicletas', title: 'Bicicletas'),
    S2Choice<String>(value: 'Consolas', title: 'Consolas'),
    S2Choice<String>(value: 'Disfraces', title: 'Disfraces'),
  ];
  static String value;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(
          rightOptions: false,
          favOption: false,
          backButton: true,
          bgColor: MyTheme.primary,
          title: "Nueva publicación",
      ),

      body: Container(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(25.0),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: TextField(
                    controller: _nameField,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Nombre'),
                  ),
                ),
                ImageSlideshow(
                  width: double.infinity,
                  height: 250,
                  initialPage: 0,
                  indicatorColor: Colors.blue,
                  indicatorBackgroundColor: Colors.grey,
                  children: [

                    Image.network(
                      "https://i.blogs.es/86b11e/ps51/1366_2000.jpeg",
                      fit: BoxFit.cover,
                    ),
                    Image.network(
                      "http://d2r9epyceweg5n.cloudfront.net/stores/001/239/905/products/ene-3-plastico1-ca76755057a823aeea16165340604100-640-0.jpg",
                      fit: BoxFit.cover,
                    ),
                    Image.network(
                      "https://d3ugyf2ht6aenh.cloudfront.net/stores/051/422/products/reposera-milona-ambas11-21eea12ee05e8ebfbf15793578714056-1024-1024.jpeg",
                      fit: BoxFit.cover,
                    ),
                  ],
                  onPageChanged: (value) {
                    print('Page changed: $value');
                  },
                  isLoop: false,
                ),
                Padding(
                    padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: _priceField,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), hintText: 'Price'),
                    ),
                  ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Divider(
                      thickness: 1.0,
                      color: Colors.grey
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Text(
                    "Descripción",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: TextField(
                    controller: _detailField,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Escribe aquí una descripción'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Divider(
                      thickness: 1.0,
                      color: Colors.grey
                  ),
                ),
                Column(
                  children: <Widget>[
                    const SizedBox(height: 7),
                    SmartSelect<String>.single(
                        placeholder: "seleccionar",
                        title: 'Categorias',
                        value: value,
                        choiceItems: options,
                        onChange: (selected) => value = selected.value
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 30.0),
                ),
                ButtonTheme(
                  minWidth: MediaQuery.of(context).size.width - 50.0,
                  child: RaisedButton(
                    onPressed: () async {
                      if(value != "" && _nameField.text != "" && _detailField.text != "" && _priceField.text != "") {
                        PublicationModel pm = PublicationModel();
                        pm.name = _nameField.text;
                        pm.detail = _detailField.text;
                        pm.category = value;
                        pm.price = _priceField.text;
                        pm.images = null;
                        DocumentReference docRef = await addPublication(pm);
                      } else {
                        // TOAST DE QUE FALTA ALGUN CAMPO
                      }
                    },
                    color: MyTheme.blue,
                    padding: EdgeInsets.symmetric(horizontal: 100, vertical: 20),
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
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}