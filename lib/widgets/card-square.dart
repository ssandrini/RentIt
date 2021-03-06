import 'package:flutter/material.dart';
import 'package:argon_flutter/constants/Theme.dart';
import 'package:argon_flutter/screens/listing.dart';


class CardSquare extends StatelessWidget {
  CardSquare(
      {this.price = "",
        this.timeUnit = "",
        this.title = "Placeholder Title",
      this.cta = "",
      this.img = "https://via.placeholder.com/200",
      this.tap = defaultFunc});

  final String cta;
  final String img;
  final Function tap;
  final String title;
  final String price;
  final String timeUnit;

  static void defaultFunc(BuildContext context) {
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 250,
        width: null,
        child: GestureDetector(
          onTap: tap, //() {Navigator.push(context,MaterialPageRoute(builder: (context) => ListingScreen()));},
          child: Card(
              elevation: 0.4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                      flex: 3,
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(6.0),
                                  topRight: Radius.circular(6.0)),
                              image: DecorationImage(
                                image: NetworkImage(img),
                                fit: BoxFit.cover,
                              )))),
                  Flexible(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 10.0, top:1.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(title,
                                style: TextStyle(
                                    color: MyTheme.header, fontSize: 13)),
                            Text("\$" + price + " \\" + timeUnit,
                                style: TextStyle(
                                    color: MyTheme.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ))
                ],
              )),
        ));
  }
}
