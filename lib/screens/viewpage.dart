import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel/screens/home.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel/screens/place.dart';

class ViewPage extends StatelessWidget {
  const ViewPage({Key? key}) : super(key: key);

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
              Home(),
              MyGridScreen(),
              Container(child: Icon(Icons.directions_bike)),
              Container(child: Icon(Icons.directions_bike)),
            ],
          ),
        ),
      ),
    );
  }
}

Widget menu() {
  return Container(
    color: Color(0xFF50B5E4),
    child: TabBar(
      labelColor: Colors.white,
      unselectedLabelColor: Colors.white70,
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorPadding: EdgeInsets.all(5.0),
      indicatorColor: Colors.blue,
      tabs: [
        Tab(text: "HOME", icon: Icon(Icons.home)),
        Tab(
          text: "Bills",
          icon: Icon(FontAwesomeIcons.route),
        ),
        Tab(
          text: "Balance",
          icon: Icon(FontAwesomeIcons.bell),
        ),
        Tab(
          text: "Options",
          icon: Icon(FontAwesomeIcons.user),
        ),
      ],
    ),
  );
}
