import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';
import 'api.dart';

class MyGridScreen extends StatefulWidget {
  MyGridScreen({Key? key}) : super(key: key);

  @override
  _MyGridScreenState createState() => _MyGridScreenState();
}

class _MyGridScreenState extends State<MyGridScreen> {
  Iterable s = [];
  bool isUpdate = true;
  Future<void> local(double a, double b) async {
    final availableMap = await MapLauncher.installedMaps;
    await availableMap.first.showMarker(
      coords: Coords(a, b),
      title: "Local",
    );
  }

  @override
  Widget build(BuildContext context) {
    API(url: "http://10.0.2.2/travel/api/lay_dia_danh.php")
        .getDataString()
        .then((value) {
      s = json.decode(value);
      isUpdate = false;
      setState(() {});
    });
    return Container(
      padding: const EdgeInsets.only(top: 20),
      child: SizedBox(
        child: Expanded(
          child: ListView.builder(
            itemCount: s.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                elevation: 4.0,
                child: Column(
                  children: [
                    ListTile(
                      title: Text(s.elementAt(index)["name"].toString()),
                      trailing: Icon(Icons.favorite_outline),
                    ),
                    Container(
                      height: 200.0,
                      child: Ink.image(
                        image: AssetImage('assets/images/beach.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(16.0),
                      alignment: Alignment.centerLeft,
                      child: Text(s.elementAt(index)["description"].toString()),
                    ),
                    ButtonBar(
                      children: [
                        TextButton(
                          child: const Text('CONTACT AGENT'),
                          onPressed: () {
                            local(double.parse(s.elementAt(index)["location1"]),
                                double.parse(s.elementAt(index)["location2"]));
                          },
                        ),
                        TextButton(
                          child: const Text('LEARN MORE'),
                          onPressed: () {/* ... */},
                        )
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
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
