// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:culturally/date_picker.dart';
import 'package:culturally/event_page.dart';
import 'package:culturally/bottom_bar.dart';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Startup Name Generator',
      theme: ThemeData(
        primaryColor: Colors.orange,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{
  DateTime selectedDate = DateTime.now();
  final _saved = Set<int>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 9.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {},
        ),
        title: Text('Events List',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 20.0,
            color: Colors.white)),
        actions: <Widget> [
          IconButton(
              icon: Icon(Icons.search, color: Colors.white),
              onPressed: () {}
          ),
          IconButton(
            icon: Icon(Icons.tune, color: Colors.white),
            onPressed: () {}
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(10.0),
        children: <Widget> [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 3.0,
                      blurRadius: 5.0)
                ],
                color: Colors.white),
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(left: 15, top: 15, bottom: 8),
                        child: Text('When', style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 16.0,
                          fontWeight: FontWeight.normal,
                          color: Colors.deepOrange)
                        ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15.0, bottom: 15.0, right: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${DateFormat('EEEE, d MMM, yyyy').format(selectedDate)}", style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 18.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.black)
                      ),
                      Icon(Icons.calendar_today, color: Colors.black, size: 20,)
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15.0),

          _buildCard(
              1,
              'Listen (2020)',
              'M14\nGenre: Drama \nDirector: Ana Rocha\n In the suburbs of London, Bela and Jota face serious challenges when Social Services raise doubts regarding the safety of their children. ',
              'assets/listen.png',
              'Cinema',
              false,
              context),
          _buildCard(
              2,
              'NOS Alive',
              'A music and arts festival which takes place in the Algés riverside in Oerias. Guests include Kendrick Lamar, Taylor Swift, Billie Eilish. Khalid, Alt-J and the Lumineers.',
              'assets/nos_alive.png',
              'Concert',
              false,
              context),
          _buildCard(
              3,
              'Pi 100 Pé',
              'M06\nComedy show by Fernando Rocha.\nSuper Bock Arena\n Campo Pequeno\nTickets available everywhere',
              'assets/pi100pe.png',
              'Comedy',
              true,
              context),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {},
      backgroundColor: Colors.deepOrange,
      child: Image.asset('assets/groups.png', height: 35, width: 35,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomBar(),
    );
  }
}



Widget _buildCard(int id, String name, String description, String imagePath, String type, bool isFavorite, context){
  return Padding(
      padding: EdgeInsets.only(left: 1.0, top: 1.0, right: 1.0, bottom: 8.0),
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 3.0,
                    blurRadius: 5.0)
              ],
              color: Colors.white),

          child: Row(
            children: <Widget>[
              Expanded(
                  child: Container(
                    //fit: BoxFit.contain,
                    alignment: Alignment.centerLeft,
                    child: Image.asset(imagePath),
                  )),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadiusDirectional.all(Radius.circular(20.0)),
                                  color: Colors.orange
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(6.0),
                                child: Text(type, style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white) ),
                              )
                          ),
                          isFavorite
                              ? IconButton(icon: Icon(Icons.favorite, color: Colors.deepOrange), onPressed: () => {isFavorite = !isFavorite})
                              : IconButton(icon: Icon(Icons.favorite_border, color: Colors.black), onPressed: () => {isFavorite = !isFavorite})
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
                      child: Text(name, style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrange) ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(description, style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 10.0,
                          fontWeight: FontWeight.normal,
                          color: Colors.black) ),
                    )

                  ],
                ),
              )
            ],
          )
      )
  );
}
