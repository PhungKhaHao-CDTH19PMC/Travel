import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var color = Colors.blue;
  late TabController myControler;
  var like = Colors.black;
  var like2 = Colors.black;
  var likeComent = Colors.black;
  var likenumber = 45;
  var likenumber2 = 117;
  var likeGroups = 22;

  @override
  Widget build(BuildContext context) {
    var _colorlike = Colors.black;
    var _colorlike2 = Colors.black;
    var _colorlikeComment = Colors.black;
    var likenumber = 45;
    var likenumber2 = 5;
    bool _like = false;
    bool _likeComment = false;

    return Container(
      padding: EdgeInsets.fromLTRB(32, 0, 32, 32),
      child: ListView(
        children: [
          Container(
            color: Colors.white,
            width: double.infinity,
            margin: EdgeInsets.only(top: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  isThreeLine: false,
                  title: Text("Khả Hào",
                      style: TextStyle(fontFamily: 'RobotoBlack')),
                  subtitle: Text("Vừa xong · 🌍",
                      style: TextStyle(fontFamily: 'RobotoBlack')),
                  trailing: Icon(Icons.more_horiz),
                  leading: Container(
                    width: 55,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        image: DecorationImage(
                            image: AssetImage("assets/images/beach.jpg"),
                            fit: BoxFit.cover)),
                    child: null,
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: Text(
                    "Biển đẹp không mọi người❤️❤️❤️",
                    style: TextStyle(fontSize: 18, fontFamily: 'Roboto'),
                    textAlign: TextAlign.left,
                  ),
                ),
                Image.asset(
                  'assets/images/beach.jpg',
                  width: 600,
                  fit: BoxFit.cover,
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text("👍❤️ $likenumber ",
                              style: TextStyle(fontSize: 14))),
                      Container(
                          margin: EdgeInsets.only(right: 10),
                          child: Text(
                            "46 Comments",
                            style:
                                TextStyle(fontSize: 14, fontFamily: 'Roboto'),
                          )),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 2,
                  margin: EdgeInsets.only(top: 20),
                  color: Colors.black12,
                ),
                Container(
                  child: Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Container(
                            height: 45,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _like = !_like;
                                      if (_like == true) {
                                        _colorlike = Colors.blue;
                                        likenumber++;
                                      } else {
                                        _colorlike = Colors.black;
                                        likenumber--;
                                      }
                                    });
                                  },
                                  icon: Icon(Icons.thumb_up_outlined),
                                  color: _colorlike,
                                ),
                                SizedBox(
                                  width: 0,
                                ),
                                Text(
                                  "Like",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: _colorlike,
                                      fontFamily: 'Roboto'),
                                )
                              ],
                            ),
                          )),
                      Expanded(
                          flex: 1,
                          child: Container(
                            height: 45,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.comment_outlined),
                                SizedBox(
                                  width: 0,
                                ),
                                Text(
                                  "Comment",
                                  style: TextStyle(
                                      fontSize: 18, fontFamily: 'Roboto'),
                                )
                              ],
                            ),
                          )),
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 45,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.send_outlined),
                              SizedBox(
                                width: 0,
                              ),
                              Text(
                                "Send",
                                style: TextStyle(
                                    fontSize: 18, fontFamily: 'Roboto'),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    padding: EdgeInsets.all(5),
                    child: CircleAvatar(
                      backgroundColor: Colors.blue[400],
                      child: CircleAvatar(
                        radius: 18,
                        backgroundImage: AssetImage('assets/images/beach.jpg'),
                      ),
                    )),
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      width: 230,
                      padding: EdgeInsets.all(15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Crush của Hào",
                            style: TextStyle(fontFamily: 'RobotoBlack'),
                          ),
                          Text(
                            "Đẹp quá anh Hào ơi❤️❤️❤️❤️",
                            style:
                                TextStyle(fontSize: 16, fontFamily: 'Roboto'),
                            // textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 230,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                              onTap: () {
                                setState(
                                  () {
                                    setState(
                                      () {
                                        _likeComment = !_likeComment;
                                        if (_likeComment == true) {
                                          _colorlikeComment = Colors.blue;
                                          likenumber2++;
                                        } else {
                                          _colorlikeComment = Colors.black;
                                          likenumber2--;
                                        }
                                      },
                                    );
                                  },
                                );
                              },
                              child: Text(
                                "Like",
                                style: TextStyle(color: _colorlikeComment),
                              )),
                          Text(
                            "Reply",
                            style: TextStyle(fontFamily: 'Roboto'),
                          ),
                          Text("$likenumber2👍❤️"),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 7, left: 15),
                      width: 230,
                      child: Text(
                        "View 4 previous replies... ",
                        style: TextStyle(fontFamily: 'Roboto'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
