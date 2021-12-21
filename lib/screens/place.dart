import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class MyGridScreen extends StatefulWidget {
  MyGridScreen({Key? key}) : super(key: key);

  @override
  _MyGridScreenState createState() => _MyGridScreenState();
}

class _MyGridScreenState extends State<MyGridScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              buildCard(),
              buildCard(),
              buildCard(),
              buildCard(),
              buildCard(),
              buildCard(),
              buildCard(),
            ],
          )),
    );
  }
}

Card buildCard() {
  var heading = '\Biển Vũng Tàu';
  var subheading = 'Nước xanh tươi';
  var cardImage = AssetImage('assets/images/beach.jpg');
  var supportingText =
      'Một trong những bãi biển đẹp nhất Việt Nam.Nước trong xanh mát mẻ.';
  return Card(
      elevation: 4.0,
      child: Column(
        children: [
          ListTile(
            title: Text(heading),
            subtitle: Text(subheading),
            trailing: Icon(Icons.favorite_outline),
          ),
          Container(
            height: 200.0,
            child: Ink.image(
              image: cardImage,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            alignment: Alignment.centerLeft,
            child: Text(supportingText),
          ),
          ButtonBar(
            children: [
              TextButton(
                child: const Text('CONTACT AGENT'),
                onPressed: () {/* ... */},
              ),
              TextButton(
                child: const Text('LEARN MORE'),
                onPressed: () {/* ... */},
              )
            ],
          )
        ],
      ));
}
