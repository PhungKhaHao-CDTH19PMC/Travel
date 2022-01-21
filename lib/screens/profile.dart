import 'dart:convert';
import 'package:flutter/material.dart';
import 'api.dart';

class Profile extends StatefulWidget {
  String username;
  Profile({Key? key, required this.username}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Iterable s = [];
  int index = 0;
  bool isUpdate = true;
  String c='';
  String d='';
  @override

  Widget Update() {
    TextEditingController name = new TextEditingController(text: s.elementAt(0)["fullname"].toString());
    TextEditingController email = new TextEditingController(text: s.elementAt(0)["email"].toString());
    TextEditingController phone = new TextEditingController(text: s.elementAt(0)["phone"].toString());
    String them = "";
    return Scaffold(
      appBar: AppBar(
        title: Text('Chi tiết tài khoản'),
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
                  controller: phone,
                  
                  decoration: InputDecoration(
                    hintText: 'phone',
                    border: OutlineInputBorder(),
                  )),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
              child: TextField(
                  controller: email,
                  
                  decoration: InputDecoration(
                    hintText: 'email',
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
                  if(name.text==''||email.text==''||phone.text=='')
                  {
                    c='Vui lòng nhập đầy đủ thông tin';
                  }
                  
                  else
                  {
                    c='';
                    API(
                          url:
                              "http://10.0.2.2:8000/doan/api/cap_nhat_tai_khoan.php?name=" +
                                  name.text +
                                  "&email=" +
                                  email.text+
                                  "&phone=" +
                                  phone.text+"&id=" +
                                  s.elementAt(0)["id"].toString())
                      .getDataString()
                      .then((value) {
                    them = value;
                    print(value);
                    isUpdate = false;
                  });
                  Navigator.pop(context);
                  }
                  setState(() {});
                }),
                OutlinedButton(
                child: Text('Change Password'),
                style: OutlinedButton.styleFrom(
                  primary: Colors.cyan[400],
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                ),
                onPressed: () {
                  Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  ChangePass()));
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

  Widget ChangePass() {
    TextEditingController password = new TextEditingController();
    TextEditingController newpassword = new TextEditingController();
    TextEditingController confirnpassword = new TextEditingController();
    String them = "";
    return Scaffold(
      appBar: AppBar(
        title: Text('Chi tiết tài khoản'),
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: TextField(
                  controller: password,
                  decoration: InputDecoration(
                    hintText: 'password',
                    border: OutlineInputBorder(),
                  )),
            ),
            
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
              child: TextField(
                  controller: newpassword,
                  
                  decoration: InputDecoration(
                    hintText: 'newpassword',
                    border: OutlineInputBorder(),
                  )),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
              child: TextField(
                  controller: confirnpassword,
                  
                  decoration: InputDecoration(
                    hintText: 'confirnpassword',
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
                  if(password.text==''||newpassword.text==''||confirnpassword.text=='')
                  {
                    d='Vui lòng nhập đầy đủ thông tin';
                  }
                  else if(password.text!=s.elementAt(0)["password"].toString())
                  {
                    d='Mật khẩu sai';
                  }
                  else if(confirnpassword.text!=newpassword.text)
                  {
                    d='Mật khẩu không trùng khớp';
                  }
                  else
                  {
                    d='';
                    API(
                          url:
                              "http://10.0.2.2:8000/doan/api/cap_nhat_password.php?password=" +
                                  newpassword.text +
                                  "&id=" +
                                  s.elementAt(0)["id"].toString())
                      .getDataString()
                      .then((value) {
                    them = value;
                    print(value);
                    isUpdate = false;
                  });
                  Navigator.pop(context);
                  }
                  setState(() {});
                }),
                Container(
              padding: EdgeInsets.only(top: 10),
              child: Text(d),
            )
          ],
        ),
      ),
    );
  }
  Widget build(BuildContext context) {
      API(
              url:
                  "http://10.0.2.2/doan/api/lay_thong_tin_nguoi_dung.php/?id=" +
                      widget.username)
          .getDataString()
          .then((value) {
        s = json.decode(value);
        isUpdate = false;
        setState(() {});
      });
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/beach.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                width: double.infinity,
                height: 350.0,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          "https://scontent.fvca1-4.fna.fbcdn.net/v/t1.6435-9/118387249_926204791198426_1997447177852213166_n.jpg?_nc_cat=109&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=v5-AUFObwsAAX-IMxnq&_nc_ht=scontent.fvca1-4.fna&oh=00_AT_q0L9qUyUz807px1Z6oQxygbm_cJkKB4DGT9cn5CIYwA&oe=61F91327",
                        ),
                        radius: 50.0,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        s.length > 0
                            ? s.elementAt(0)["fullname"].toString()
                            : 'fail!s',
                        style: TextStyle(
                            fontSize: 25.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Card(
                        margin: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 5.0),
                        clipBehavior: Clip.antiAlias,
                        color: Colors.white,
                        elevation: 5.0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 22.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      "Posts",
                                      style: TextStyle(
                                        color: Colors.redAccent,
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      "5200",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.pinkAccent,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      "Followers",
                                      style: TextStyle(
                                        color: Colors.redAccent,
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      "28.5K",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.pinkAccent,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      "Follow",
                                      style: TextStyle(
                                        color: Colors.redAccent,
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      "1300",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.pinkAccent,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )),
          Container(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 30.0, horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    s.length > 0
                        ? 'Phone: ' +
                            s.elementAt(0)["phone"].toString() +
                            '\n'
                                'Email: ' +
                            s.elementAt(0)["email"].toString()
                        : 'fail!',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      letterSpacing: 2.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            width: 300.00,
            child: RaisedButton(
                onPressed: () {
                  Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  Update()));
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.0)),
                elevation: 0.0,
                padding: EdgeInsets.all(0.0),
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                        colors: [Colors.redAccent, Colors.pinkAccent]),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Container(
                    constraints:
                        BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                    alignment: Alignment.center,
                    child: Text(
                      "Update",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 26.0,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
