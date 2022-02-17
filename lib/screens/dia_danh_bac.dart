import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';
import 'api.dart';

class Bac extends StatefulWidget {
  String username;
  Bac({Key? key, required this.username}) : super(key: key);

  @override
  _BacState createState() => _BacState();
}
int _iApi=0;
String _urlFind = "http://10.0.2.2:8000/doan/api/tim_kiem.php/?find=";
String _iUrl="";
class _BacState extends State<Bac> {
  Iterable s = [];
  bool isUpdate = true;
  TextEditingController _controller= new TextEditingController();
  Future<void> local(double a, double b) async {
    final availableMap = await MapLauncher.installedMaps;
    await availableMap.first.showMarker(
      coords: Coords(a, b),
      title: "Local",
    );
  }

  @override
  
  Widget Share(int index) {
    TextEditingController _feeling = TextEditingController();
    TextEditingController _imagepath = TextEditingController();
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
                  controller: _imagepath,
                  obscureText: false,
                  decoration: InputDecoration(
                    hintText: 'imagepath',
                    border: OutlineInputBorder(),
                  )),
            ),
            OutlinedButton(
                child: Text('share'),
                style: OutlinedButton.styleFrom(
                  primary: Colors.cyan[400],
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                ),
                onPressed: () {
                  API(
                          url:
                              "http://10.0.2.2:8000/doan/api/chia_se.php/?nguoi_dung_id=" +
                                  widget.username +
                                  "&dia_danh_id=" +
                                  s.elementAt(index)["id"].toString() +
                                  "&feeling=" +
                                  _feeling.text +
                                  "&imagepath=" +
                                  _imagepath.text)
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
  Widget buildList(){
    double height=MediaQuery.of(context).size.height;
  return Container(
    
        padding: const EdgeInsets.only(top: 20,),
        child: SizedBox(
          height: height-150,
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
                              s.elementAt(index)["imagepath"].toString()),
                          fit: BoxFit.cover,
                        ),
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
                                      builder: (context) => detail(index)));
                            },
                          ),
                          TextButton(
                            child: const Text('SHARE'),
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
      );
}
Widget detail(int index){
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
    API(url: "http://10.0.2.2:8000/doan/api/lay_dia_danh_bac.php")
          .getDataString()
          .then((value) {
          s = json.decode(value);
          isUpdate = false;
          setState(() {});
        });
    return Scaffold(
      appBar: AppBar(
        title: Text('Địa điểm ở miền bắc'),
      ),
      body: ListView(
        children: [
        buildList()
      ],)
    );
  }
  
}

