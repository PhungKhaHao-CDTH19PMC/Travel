import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';
import 'api.dart';

class Share extends StatefulWidget {
  String username;
  Share({Key? key, required this.username}) : super(key: key);

  @override
  _Share createState() => _Share();
}

class _Share extends State<Share> {
  Iterable s = [];
  Iterable u = [];
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

  Widget Update(int index) {
    TextEditingController _feeling =
        TextEditingController(text: s.elementAt(index)["feeling"].toString());
    TextEditingController _image =
        TextEditingController(text: s.elementAt(index)["image"].toString());
    String them = "";
    return Scaffold(
      appBar: AppBar(
        title: Text('Nội dung bài chia sẽ'),
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: TextField(
                  controller: _feeling,
                  decoration: InputDecoration(
                    hintText: 'feeling',
                    border: OutlineInputBorder(),
                  )),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
              child: TextField(
                  controller: _image,
                  obscureText: false,
                  decoration: InputDecoration(
                    hintText: '_image',
                    border: OutlineInputBorder(),
                  )),
            ),
            OutlinedButton(
                child: Text('Update'),
                style: OutlinedButton.styleFrom(
                  primary: Colors.cyan[400],
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                ),
                onPressed: () {
                  API(
                          url:
                              "http://10.0.2.2:8000/doan/api/cap_nhat_bai_chia_se.php?feeling=" +
                                  _feeling.text +
                                  "&image=" +
                                  _image.text +
                                  "&id=" +
                                  s.elementAt(index)["idcs"].toString())
                      .getDataString()
                      .then((value) {
                    them = value;
                    print(value);
                    isUpdate = false;
                  });
                  Navigator.pop(context);
                  setState(() {});
                }),
          ],
        ),
      ),
    );
  }

  Widget Delete(int index) {
    TextEditingController _feeling =
        TextEditingController(text: s.elementAt(index)["feeling"].toString());
    TextEditingController _image =
        TextEditingController(text: s.elementAt(index)["image"].toString());
    String them = "";
    return Scaffold(
      appBar: AppBar(
        title: Text('Nội dung bài chia sẽ'),
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: TextField(
                  enabled: false,
                  controller: _feeling,
                  decoration: InputDecoration(
                    hintText: 'feeling',
                    border: OutlineInputBorder(),
                  )),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
              child: TextField(
                  enabled: false,
                  controller: _image,
                  obscureText: false,
                  decoration: InputDecoration(
                    hintText: '_image',
                    border: OutlineInputBorder(),
                  )),
            ),
            OutlinedButton(
                child: Text('delete'),
                style: OutlinedButton.styleFrom(
                  primary: Colors.cyan[400],
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                ),
                onPressed: () {
                  API(
                          url:
                              "http://10.0.2.2:8000/doan/api/xoa_bai_chia_se.php?id=" +
                                  s.elementAt(index)["idcs"].toString())
                      .getDataString()
                      .then((value) {
                    them = value;
                    print(value);
                    isUpdate = false;
                  });
                  Navigator.pop(context);
                  setState(() {});
                }),
          ],
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    API(
            url: "http://10.0.2.2:8000/doan/api/bai_chia_se.php/?nguoi_dung_id=" +
                widget.username)
        .getDataString()
        .then((value) {
      s = json.decode(value);
      isUpdate = false;
      setState(() {});
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('Bài Chia Sẻ'),
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
                            'Name: ' + s.elementAt(index)["name"].toString(),
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
                          ),
                          TextButton(
                            child: const Text('UPDATE'),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Update(index)));
                            },
                          ),
                          TextButton(
                            child: const Text('DELETE'),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Delete(index)));
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
