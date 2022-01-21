import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';
import 'api.dart';

class HomePage extends StatefulWidget {
  String username;
  HomePage({Key? key, required this.username}) : super(key: key);

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
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
  Widget Share(int index) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Chi tiết bài viết'),
        ),
        body: Container(
            padding: const EdgeInsets.only(top: 20),
            child: SizedBox(
              child: Card(
                elevation: 4.0,
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                          s.length > 0
                              ? ('Name: ' +
                                  s.elementAt(index)["name"].toString())
                              : 'fail!',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      trailing: Icon(Icons.favorite_outline),
                    ),
                    Container(
                      height: 200.0,
                      child: Ink.image(
                        image: NetworkImage(s.length > 0
                            ? s.elementAt(index)["imagepath"].toString()
                            : 'https://bizflyportal.mediacdn.vn/bizflyportal/459/347/2020/06/02/17/37/70515910726734841.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(16.0),
                      alignment: Alignment.centerLeft,
                      child: Text(s.length > 0
                          ? ('Description: ' +
                              s.elementAt(index)["description"].toString())
                          : 'fail!'),
                    ),
                  ],
                ),
              ),
            )));
  }

  Widget build(BuildContext context) {
    API(url: "http://10.0.2.2/doan/api/lay_tat_ca_chia_se.php")
        .getDataString()
        .then((value) {
      s = json.decode(value);
      isUpdate = false;
      setState(() {});
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Trang Chủ'),
      ),
      body: Container(
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
                        title: Text(
                            'User: ' +
                                s.elementAt(index)["fullname"].toString(),
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        trailing: Icon(Icons.favorite_outline),
                      ),
                      Container(
                        height: 200.0,
                        child: Ink.image(
                          image: NetworkImage(
                              s.elementAt(index)["image"].toString()),
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(16.0),
                        alignment: Alignment.centerLeft,
                        child: Text('Cảm nghĩ: ' +
                            s.elementAt(index)["feeling"].toString()),
                      ),
                      ButtonBar(
                        children: [
                          TextButton(
                            child: const Text('LOCATION'),
                            onPressed: () {
                              local(
                                  double.parse(s.elementAt(index)["location1"]),
                                  double.parse(
                                      s.elementAt(index)["location2"]));
                            },
                          ),
                          TextButton(
                            child: const Text('DETAIL'),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Share(index)));
                            },
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
      ),
    );
  }
}
