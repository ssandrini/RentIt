import 'package:argon_flutter/backend/models/publication-model.dart';
import 'package:argon_flutter/widgets/card-square-listing.dart';
import 'package:argon_flutter/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:argon_flutter/constants/Theme.dart';
import 'package:argon_flutter/backend/net/flutterfire.dart';

import 'listing.dart';

class CategoryList extends StatefulWidget {
  final String category;

  CategoryList({Key key, @required this.category}) : super(key: key);

  @override
  State<CategoryList> createState() => _CategoryListState(category);
}

class _CategoryListState extends State<CategoryList> {
  final String category;

  _CategoryListState(this.category);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(searchBar: true, bgColor: MyTheme.primary,backButton:true),
      backgroundColor: MyTheme.bgColorScreen,
      body: FutureBuilder(builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null &&
            snapshot.data.length != 0) {
          return Container(
              padding: const EdgeInsets.only(
                  left: 24.0, right: 24.0, top: 16.0),
              child: ListView.builder(
                itemCount: snapshot.data == null ? 0 : snapshot.data.length,
                itemBuilder: (context, index) {
                  PublicationModel pm = snapshot.data[index];
                  return CardSquareListing(pm);
                },
              )
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Align(
            alignment: Alignment.center,
            child: Container(
                child: CircularProgressIndicator()
            ),
          );
        } else {
          return Align(
            alignment: Alignment.center,
            child: Container(
              child: Text(
                "No hay publicaciones",
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),);
        }
      },
        future: getPublicationsByCategory(category),
      ),
    );
  }
}

  // Widget getListView() {
  //   return FutureBuilder(
  //     builder: (context, snapshot) {
  //       if (snapshot.hasData &&
  //           snapshot.data != null &&
  //           snapshot.data.length != 0) {
  //         return Container(
  //             padding: const EdgeInsets.only(left: 10.0, right: 10.0),
  //             height: MediaQuery.of(context).size.height,
  //             child: ListView.builder(
  //               itemCount: snapshot.data == null ? 0 : snapshot.data.length,
  //               itemBuilder: (context, index) {
  //                 PublicationModel pm = snapshot.data[index];
  //                 return Column(children: [
  //                   ListTile(
  //                     onTap: () {
  //                       Navigator.push(
  //                           context,
  //                           MaterialPageRoute(
  //                               builder: (context) => ListingScreen(pm)));
  //                     },
  //                     leading: ConstrainedBox(
  //                       constraints: BoxConstraints(
  //                           minWidth: MediaQuery.of(context).size.width / 2.5),
  //                       child: Image.network(pm.images[0],
  //                           fit: BoxFit.cover, height: 70),
  //                     ),
  //                     title: Text(pm.name),
  //                     subtitle: Row(children: [
  //                       Text("\$ ",
  //                           style: const TextStyle(
  //                               fontWeight: FontWeight.bold,
  //                               fontSize: 20,
  //                               color: MyTheme.black)),
  //                       Text(pm.price,
  //                           style: const TextStyle(
  //                               fontWeight: FontWeight.bold,
  //                               fontSize: 20,
  //                               color: MyTheme.black)),
  //                       Text("\\",
  //                           style: const TextStyle(
  //                               fontWeight: FontWeight.bold,
  //                               fontSize: 20,
  //                               color: MyTheme.black)),
  //                       Text(pm.timeUnit,
  //                           style: const TextStyle(
  //                               fontWeight: FontWeight.bold,
  //                               fontSize: 20,
  //                               color: MyTheme.black))
  //                     ]),
  //                   ),
  //                   Divider(thickness: 0.5, color: Colors.grey),
  //                 ]);
  //               },
  //             ));
  //       } else if (snapshot.connectionState == ConnectionState.waiting) {
  //         return Align(
  //           alignment: Alignment.center,
  //           child: Container(child: CircularProgressIndicator()),
  //         );
  //       } else {
  //         return Align(
  //           alignment: Alignment.center,
  //           child: Container(
  //             child: Text(
  //               "No hay publicaciones",
  //               textAlign: TextAlign.center,
  //               overflow: TextOverflow.ellipsis,
  //               style:
  //                   const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
  //             ),
  //           ),
  //         );
  //       }
  //     },
  //     future: getPublicationsByCategory(category),
  //   );

  // Widget getListTile(PublicationModel pm) {
  //   return
  // }
