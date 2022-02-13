import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel/screens/home.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel/screens/place.dart';
import 'package:travel/screens/profile.dart';
import 'package:travel/screens/share.dart';

class ViewPage extends StatelessWidget {
  String username;
  ViewPage({Key? key, required this.username}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          bottomNavigationBar: menu(),
          body: TabBarView(
            children: [
              HomePage(username: username),
              MyGridScreen(
                username: username,
              ),
              Share(username: username),
              Profile(
                username: username,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget menu() {
  return Container(
    color: const Color(0x930E0F0F),
    child: const TabBar(
      labelColor: Colors.white,
      unselectedLabelColor: Colors.white70,
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorPadding: EdgeInsets.all(5.0),
      indicatorColor: Colors.white,
      tabs: [
        Tab(icon: Icon(Icons.home)),
        Tab(
          icon: Icon(FontAwesomeIcons.paperPlane),
        ),
        Tab(
          icon: Icon(FontAwesomeIcons.share),
        ),
        Tab(
          icon: Icon(FontAwesomeIcons.user),
        ),
      ],
    ),
  );
}
