import 'dart:convert';
import 'package:flutter/material.dart';
import 'api.dart';

class AddScreen extends StatefulWidget {
  AddScreen({Key? key}) : super(key: key);

  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  TextEditingController name = new TextEditingController();
  TextEditingController linkanh = new TextEditingController();
  TextEditingController location1 = new TextEditingController();
  TextEditingController location2 = new TextEditingController();
  TextEditingController description = new TextEditingController();
  String c = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form thêm địa danh'),
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: TextField(
                  controller: name,
                  decoration: InputDecoration(
                    hintText: 'name',
                    border: OutlineInputBorder(),
                  )),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
              child: TextField(
                  controller: linkanh,
                  decoration: InputDecoration(
                    hintText: 'Link image',
                    border: OutlineInputBorder(),
                  )),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
              child: TextField(
                  controller: location1,
                  decoration: InputDecoration(
                    hintText: 'Location1',
                    border: OutlineInputBorder(),
                  )),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
              child: TextField(
                  controller: location2,
                  decoration: InputDecoration(
                    hintText: 'Location2',
                    border: OutlineInputBorder(),
                  )),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
              child: TextField(
                  controller: description,
                  decoration: InputDecoration(
                    hintText: 'Description',
                    border: OutlineInputBorder(),
                  )),
            ),
            OutlinedButton(
                child: Text('Add'),
                style: OutlinedButton.styleFrom(
                  primary: Colors.cyan[400],
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                ),
                onPressed: () {
                  if (name.text == '' ||
                      linkanh.text == '' ||
                      location1.text == '' ||
                      location2.text == '' ||
                      description.text == '') {
                    c = 'Vui lòng nhập đầy đủ thông tin';
                  } else {
                    c = '';
                    API(
                            url:
                                "http://10.0.2.2/doan/api/themdiadanh.php?name=" +
                                    name.text +
                                    "&imagepath=" +
                                    linkanh.text +
                                    "&location1=" +
                                    location1.text +
                                    "&location2=" +
                                    location2.text +
                                    "&description=" +
                                    description.text)
                        .getDataString()
                        .then((value) {});
                    Navigator.pop(context);
                  }
                  setState(() {});
                }),
            Container(
              padding: EdgeInsets.only(top: 10),
              child: Text(c),
            )
          ],
        ),
      ),
    );
  }
}
