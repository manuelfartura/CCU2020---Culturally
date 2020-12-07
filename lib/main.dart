// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import './firstPage.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Culturally',
      theme: ThemeData(
        primaryColor: Colors.orange,
      ),
      home: FirstPage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  DateTime selectedDate = DateTime.now();
  final _favorites = Set<int>();
  OverlayEntry _overlayEntry;
  OverlayState overlayState;
  String dropdownValue = ' Alphabetical Asc.        ';
  double _currentPriceSliderValue = 100;
  double _currentCapacitySliderValue = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* -------------------------------- App bar, at the top of the screen --------------------------*/
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 9.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Events List',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 20.0,
                color: Colors.white)),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search, color: Colors.white),
              onPressed: () {}
          ),
          IconButton(
              icon: Icon(Icons.tune, color: Colors.white),
              onPressed: () {
                showFilterOverlay(context);
              }
          ),
        ],
      ),
/* ------------------------------- Main screen body, has event cards ------------------------------*/
      body: ListView(
        padding: EdgeInsets.all(10.0),
        children: <Widget>[
/* --------------------------------- Date picker box --------------------------------*/
          InkWell(
            onTap: () => _selectDate(context),
            child:
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
                    padding: EdgeInsets.only(
                        left: 15.0, bottom: 15.0, right: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("${DateFormat('EEEE, d MMM, yyyy').format(
                            selectedDate)}", style: TextStyle(
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
          ),
          SizedBox(height: 15.0),

/* --------------------------------------- Event cards list ----------------------------------*/
          if(selectedDate.day.isOdd && _currentPriceSliderValue >= 8)
            _buildCard(
                1,
                'Listen (2020)',
                'M14\nGenre: Drama \nDirector: Ana Rocha\n In the suburbs of London, Bela and Jota face serious challenges when Social Services raise doubts regarding the safety of their children. ',
                'assets/listen.png',
                'Cinema',
                context),
          if(selectedDate.day.isEven && _currentPriceSliderValue >= 68)
            _buildCard(
                2,
                'NOS Alive',
                'A music and arts festival which takes place in the Algés riverside in Oerias.\n\n Guests include Kendrick Lamar, Taylor Swift, Billie Eilish. Khalid, Alt-J and the Lumineers.\n\nCome have the time of your life!',
                'assets/nos_alive.png',
                'Concert',
                context),
          if(selectedDate.day.isOdd && _currentPriceSliderValue >= 22)
            _buildCard(
                3,
                'Pi 100 Pé',
                'M06\n\nComedy show by Fernando Rocha.\nSit back, relax and have a laugh!\n\nSuper Bock Arena\n Campo Pequeno\nTickets available everywhere',
                'assets/pi100pe.png',
                'Comedy',
                context),
          if(selectedDate.day.isEven && _currentPriceSliderValue >= 18 )
            _buildCard(
                4,
                'Primeiro Modernismo às Novas Vanguardas do Século XX',
                'The Berardo Collection brings together a remarkable of works that marked the history of art of the twentieth century',
                'assets/berardo.png',
                'Museum',
                context),
          if(selectedDate.day.isOdd && _currentPriceSliderValue >= 18 )
            _buildCard(
                5,
                'Uma Mulher Não Chora',
                'M06\nMusical\nFor 80 minutes, the singers join the musical universe of Renato Júnior. Paying homage to the reality of being a woman in the twenty first century, lending their voice to eradicate violence against women.',
                'assets/teatro.png',
                'Theater',
                context),
        ],
      ),

      /* ------------------- Central, flaoting action button for the match -------------------*/

      floatingActionButton: FloatingActionButton(onPressed: pushMatchScreenInterests,
        backgroundColor: Colors.deepOrange,
        child: Image.asset('assets/groups.png', height: 35, width: 35,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      /* ---------------------- Bottom Navigation Bar with the 4 icons ----------------------*/

      bottomNavigationBar: _bottomAppBar(),

    );
  }
/*---------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/*----------------------------------------------------------- FUNCTION FOR CREATING  BOTTOM NAVIGATION  ---------------------------------------------------------*/
/*---------------------------------------------------------------------------------------------------------------------------------------------------------------*/

  Widget _bottomAppBar(){
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 6.0,
      color: Colors.transparent,
      elevation: 9.0,
      clipBehavior: Clip.antiAlias,
      child: Container(
          height: 50.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  topRight: Radius.circular(25.0)
              ),
              color: Colors.orange
          ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    height: 50.0,
                    width: MediaQuery.of(context).size.width /2 - 30.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        IconButton(
                            icon: Icon(Icons.home, color: Colors.white),
                            onPressed: (){
                              Navigator.pop(context);
                            }
                        ),
                        IconButton(
                            icon: Icon(Icons.favorite, color: Colors.white),
                            onPressed: pushFavorites
                        ),
                      ],
                    )
                ),
                Container(
                    height: 50.0,
                    width: MediaQuery.of(context).size.width /2 - 30.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        IconButton(
                            icon: Icon(Icons.forum, color: Colors.white),
                            onPressed: pushChat),
                        IconButton(
                            icon: Icon(Icons.account_box, color: Colors.white),
                            onPressed: pushProfile),
                      ],
                    )
                ),
              ]
          )
      ),
    );
  }

/*---------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------ CREATE EVENT CARDS GIVEN THE RELEVANT INFORMATION ------------------------------------------------------*/
/*---------------------------------------------------------------------------------------------------------------------------------------------------------------*/

  Widget _buildCard(int id, String name, String description, String imagePath, String type, context) {
    final isFavorite = _favorites.contains(id);
    return InkWell(
        onTap: () {pushEventDetails(id);},
        child: Padding(
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
                    /*------------------- Image on the left -------------------*/
                    Expanded(
                        child: Container(
                          //fit: BoxFit.contain,
                          alignment: Alignment.centerLeft,
                          child: Image.asset(imagePath),
                        )),
                    /*------------------- Info on the right -------------------*/
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 8.0,),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadiusDirectional.all(
                                            Radius.circular(20.0)),
                                        color: Colors.orange
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(6.0),
                                      /* ------------------- Type orange tag -------------------*/
                                      child: Text(type, style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)),
                                    )
                                ),
                                IconButton(
                                  icon: Icon(
                                    /*------------------- Favorite icon, with color and fill check -------------------*/
                                    isFavorite ? Icons.favorite : Icons.favorite_border,
                                    color: isFavorite ? Colors.red : null,
                                  ),
                                  onPressed: (){
                                    setState(() {
                                      if(isFavorite){
                                        _favorites.remove(id);
                                      } else {
                                        _favorites.add(id);
                                      }
                                    });
                                  },
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 8.0, top: 8.0, bottom: 8.0, right: 8.0),
                            /* ------------------- Event Title -------------------*/
                            child: Text(name, style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.deepOrange)),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            /*------------------- Event description -------------------*/
                            child: Text(description, style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 10.0,
                                fontWeight: FontWeight.normal,
                                color: Colors.black)),
                          )

                        ],
                      ),
                    )
                  ],
                )
            )
        )
    );
  }

/*---------------------------------- FUNCTION FOR NAVIGATING TO HOME WITH BOTTOM BAR ICON ----------------------------------*/

  void pushHomepage(){
    Navigator.of(context).push(
      MaterialPageRoute<void>(
          builder: (BuildContext context) {
            return HomePage();
          }
      ),
    );
  }


/*---------------------------------- FUNCTION FOR NAVIGATING TO REVIEWS WITH BOTTOM BAR ICON ----------------------------------*/
  void pushReviews(){
    //VAI E CONSTROI ECRA REVIEWS
    Navigator.of(context).push(
      MaterialPageRoute<void>(
          builder: (BuildContext context) {

            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.orange,
                elevation: 9.0,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: Text('Reviews',
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 20.0,
                        color: Colors.white)),
              ),

              body: ListView(
                  //padding: EdgeInsets.only(top: 30.0),
                  children: <Widget>[
                    Expanded(
                        child: Container(
                          //fit: BoxFit.contain,
                          alignment: Alignment.centerLeft,
                          child: Image.asset('assets/reviews.PNG'),
                        )
                    ),
                    /*
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("No reviews yet", style: TextStyle(fontSize: 30, color: Colors.grey, fontFamily: 'Roboto'),),
                      ],

                    ),
                     */
                  ]),
              floatingActionButton: FloatingActionButton(onPressed: () {},
                backgroundColor: Colors.deepOrange,
                child: Icon(Icons.rate_review, size: 25,),
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            );


          }
      ),
    );
  }

/*gohere*/

/*---------------------------------- FUNCTION FOR NAVIGATING TO EVENT DETAILS  ----------------------------------*/
  void pushEventDetails(int id){
    bool isFavorite = _favorites.contains(id);
// CASO PARA CADA EVENTO, DESENHA  O ECRA
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        // Add lines from here...
        builder: (BuildContext context) {
          if (id == 1){
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.orange,
                elevation: 9.0,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: Text('Event details',
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 20.0,
                        color: Colors.white)),
              ),

              body: ListView(
                //padding: EdgeInsets.all(10.0),
                children: <Widget>[

                  Expanded(
                      child: Container(
                        //fit: BoxFit.contain,
                        alignment: Alignment.centerLeft,
                        child: Image.asset('assets/listen_banner.png'),
                      )
                  ),
                  Expanded(
                    child:
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(20.0),
                            child:
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Listen (2020)",
                                  style: TextStyle(fontFamily: 'Roboto', fontSize: 20, color: Colors.deepOrange),),

                                IconButton(
                                  icon: Icon(
                                    /*------------------- Favorite icon, with color and fill check -------------------*/
                                    isFavorite ? Icons.favorite : Icons.favorite_border,
                                    color: isFavorite ? Colors.red : null,
                                  ),
                                  onPressed: (){
                                    setState(() {
                                      if(isFavorite){
                                        _favorites.remove(id);
                                      } else {
                                        _favorites.add(id);
                                      }
                                    });
                                  },
                                )
                              ],),
                          ),

                          Wrap(
                            direction: Axis.horizontal,
                            children: [
                              Padding(padding: EdgeInsets.only(left: 20, right: 15), child:
                              Text("M14. In the suburbs of London, Bela and Jota face serious challenges when Social Services raise doubts regarding the safety of their children. ",
                                  style: TextStyle(fontFamily: 'Roboto', fontSize: 14, color: Colors.black))),
                            ],
                          ),
                          Row(
                            children: <Widget> [
                              Padding(
                                padding: EdgeInsets.only(left: 15, top: 15),
                                child: Icon(Icons.place, color: Colors.black),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 15, top: 15),
                                child:
                                Text("Rua Pêro da Covilhã, 36 1400-296 Lisboa",
                                    style: TextStyle(fontFamily: 'Roboto', fontSize: 14, color: Colors.black)),
                              )
                            ],
                          ),
                          Row(
                            children: <Widget> [
                              Padding(
                                padding: EdgeInsets.only(left: 15, top: 15),
                                child: Icon(Icons.access_time, color: Colors.black),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 15, top: 15),
                                child:
                                Text("December 7, 18:00, 20:00, 22:00, 24:00",
                                    style: TextStyle(fontFamily: 'Roboto', fontSize: 14, color: Colors.black)),
                              )
                            ],
                          ),
                          Row(
                            children: <Widget> [
                              Padding(
                                padding: EdgeInsets.only(left: 15, top: 15),
                                child: Icon(Icons.call, color: Colors.black),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 15, top: 15),
                                child:
                                Text("cinemas.nos.pt",
                                    style: TextStyle(fontFamily: 'Roboto', fontSize: 14, color: Colors.black)),
                              )
                            ],
                          ),
                          Row(
                            children: <Widget> [
                              Padding(
                                padding: EdgeInsets.only(left: 15, top: 15),
                                child: Icon(Icons.shopping_cart, color: Colors.black),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 15, top: 15),
                                child:
                                Text("8€",
                                    style: TextStyle(fontFamily: 'Roboto', fontSize: 14, color: Colors.black)),
                              )
                            ],
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:[
                                Padding(
                                    padding: EdgeInsets.only(top:15, left: 15),
                                    child:
                                    InkWell(
                                      onTap: pushReviews,
                                      child:
                                      Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            borderRadius: BorderRadiusDirectional.all(
                                                Radius.circular(25.0)),
                                            color: Colors.orange,
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.only(top: 10, bottom: 10, left: 40, right: 40),
                                            child: Text('   See reviews   ', style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                decoration: TextDecoration.none)),
                                          )
                                      ),
                                    )
                                )
                              ]
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:[
                                Padding(
                                    padding: EdgeInsets.only(top:15, left: 15),
                                    child:
                                    InkWell(
                                      onTap: pushReviews,
                                      child:
                                      Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            borderRadius: BorderRadiusDirectional.all(
                                                Radius.circular(25.0)),
                                            color: Colors.orange,
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.only(top: 10, bottom: 10, left: 35, right: 35),
                                            child: Text('Purchase a ticket', style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                decoration: TextDecoration.none)),
                                          )
                                      ),
                                    )
                                )
                              ]
                          ),

                        ]
                    ),
                  )
                ],
              ),
              floatingActionButton: FloatingActionButton(onPressed: pushMatchScreenInterests,
                backgroundColor: Colors.deepOrange,
                child: Image.asset('assets/groups.png', height: 35, width: 35,),
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,


            );
          }
          if (id == 2){
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.orange,
                elevation: 9.0,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: Text('Event details',
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 20.0,
                        color: Colors.white)),
              ),

              body: ListView(
                //padding: EdgeInsets.all(10.0),
                children: <Widget>[

                  Expanded(
                      child: Container(
                        //fit: BoxFit.contain,
                        alignment: Alignment.centerLeft,
                        child: Image.asset('assets/nos_alive_banner.png'),
                      )
                  ),
                  Expanded(
                    child:
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(20.0),
                            child:
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("NOS Alive",
                                  style: TextStyle(fontFamily: 'Roboto', fontSize: 20, color: Colors.deepOrange),),

                                IconButton(
                                  icon: Icon(
                                    /*------------------- Favorite icon, with color and fill check -------------------*/
                                    isFavorite ? Icons.favorite : Icons.favorite_border,
                                    color: isFavorite ? Colors.red : null,
                                  ),
                                  onPressed: (){
                                    setState(() {
                                      if(isFavorite){
                                        _favorites.remove(id);
                                      } else {
                                        _favorites.add(id);
                                      }
                                    });
                                  },
                                )
                              ],),
                          ),

                          Wrap(
                            direction: Axis.horizontal,
                            children: [
                              Padding(padding: EdgeInsets.only(left: 20, right: 15), child:
                              Text("A music and arts festival which takes place in the Algés riverside in Oerias.  Guests include Kendrick Lamar, Taylor Swift, Billie Eilish. Khalid, Alt-J and the Lumineers",
                                  style: TextStyle(fontFamily: 'Roboto', fontSize: 14, color: Colors.black))),
                            ],
                          ),
                          Row(
                            children: <Widget> [
                              Padding(
                                padding: EdgeInsets.only(left: 15, top: 15),
                                child: Icon(Icons.place, color: Colors.black),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 15, top: 15),
                                child:
                                Text("Rua Pêro da Covilhã, 36 1400-296 Lisboa",
                                    style: TextStyle(fontFamily: 'Roboto', fontSize: 14, color: Colors.black)),
                              )
                            ],
                          ),
                          Row(
                            children: <Widget> [
                              Padding(
                                padding: EdgeInsets.only(left: 15, top: 15),
                                child: Icon(Icons.access_time, color: Colors.black),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 15, top: 15),
                                child:
                                Text("December 8, 17:00 - 24:00",
                                    style: TextStyle(fontFamily: 'Roboto', fontSize: 14, color: Colors.black)),
                              )
                            ],
                          ),
                          Row(
                            children: <Widget> [
                              Padding(
                                padding: EdgeInsets.only(left: 15, top: 15),
                                child: Icon(Icons.call, color: Colors.black),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 15, top: 15),
                                child:
                                Text("213 933 770",
                                    style: TextStyle(fontFamily: 'Roboto', fontSize: 14, color: Colors.black)),
                              )
                            ],
                          ),
                          Row(
                            children: <Widget> [
                              Padding(
                                padding: EdgeInsets.only(left: 15, top: 15),
                                child: Icon(Icons.shopping_cart, color: Colors.black),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 15, top: 15),
                                child:
                                Text("Diary 68€, 3-Day Pass 159€, 4-Day Pass 189€",
                                    style: TextStyle(fontFamily: 'Roboto', fontSize: 14, color: Colors.black)),
                              )
                            ],
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:[
                                Padding(
                                    padding: EdgeInsets.only(top:15, left: 15),
                                    child:
                                    InkWell(
                                      onTap: pushReviews,
                                      child:
                                      Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            borderRadius: BorderRadiusDirectional.all(
                                                Radius.circular(25.0)),
                                            color: Colors.orange,
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.only(top: 10, bottom: 10, left: 40, right: 40),
                                            child: Text('   See reviews   ', style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                decoration: TextDecoration.none)),
                                          )
                                      ),
                                    )
                                )
                              ]
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:[
                                Padding(
                                    padding: EdgeInsets.only(top:15, left: 15),
                                    child:
                                    InkWell(
                                      onTap: pushReviews,
                                      child:
                                      Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            borderRadius: BorderRadiusDirectional.all(
                                                Radius.circular(25.0)),
                                            color: Colors.orange,
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.only(top: 10, bottom: 10, left: 35, right: 35),
                                            child: Text('Purchase a ticket', style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                decoration: TextDecoration.none)),
                                          )
                                      ),
                                    )
                                )
                              ]
                          ),

                        ]
                    ),
                  )
                ],
              ),
              floatingActionButton: FloatingActionButton(onPressed: pushMatchScreenInterests,
                backgroundColor: Colors.deepOrange,
                child: Image.asset('assets/groups.png', height: 35, width: 35,),
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,


            );
          }
          if (id == 3){
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.orange,
                elevation: 9.0,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: Text('Event details',
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 20.0,
                        color: Colors.white)),
              ),

              body: ListView(
                //padding: EdgeInsets.all(10.0),
                children: <Widget>[

                  Expanded(
                      child: Container(
                        //fit: BoxFit.contain,
                        alignment: Alignment.centerLeft,
                        child: Image.asset('assets/pi100pe_banner.png'),
                      )
                  ),
                  Expanded(
                    child:
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(20.0),
                            child:
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Pi 100 Pé",
                                  style: TextStyle(fontFamily: 'Roboto', fontSize: 20, color: Colors.deepOrange),),

                                IconButton(
                                  icon: Icon(
                                    /*------------------- Favorite icon, with color and fill check -------------------*/
                                    isFavorite ? Icons.favorite : Icons.favorite_border,
                                    color: isFavorite ? Colors.red : null,
                                  ),
                                  onPressed: (){
                                    setState(() {
                                      if(isFavorite){
                                        _favorites.remove(id);
                                      } else {
                                        _favorites.add(id);
                                      }
                                    });
                                  },
                                )
                              ],),
                          ),

                          Wrap(
                            direction: Axis.horizontal,
                            children: [
                              Padding(padding: EdgeInsets.only(left: 20, right: 15), child:
                              Text("M06. Comedy show by Fernando Rocha. Super Bock Arena Campo Pequeno. Tickets available everywhere",
                                  style: TextStyle(fontFamily: 'Roboto', fontSize: 14, color: Colors.black))),
                            ],
                          ),
                          Row(
                            children: <Widget> [
                              Padding(
                                padding: EdgeInsets.only(left: 15, top: 15),
                                child: Icon(Icons.place, color: Colors.black),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 15, top: 15),
                                child:
                                Text("Pavilhão Rosa Mota",
                                    style: TextStyle(fontFamily: 'Roboto', fontSize: 14, color: Colors.black)),
                              )
                            ],
                          ),
                          Row(
                            children: <Widget> [
                              Padding(
                                padding: EdgeInsets.only(left: 15, top: 15),
                                child: Icon(Icons.access_time, color: Colors.black),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 15, top: 15),
                                child:
                                Text("December 7, 19, 22:00",
                                    style: TextStyle(fontFamily: 'Roboto', fontSize: 14, color: Colors.black)),
                              )
                            ],
                          ),
                          Row(
                            children: <Widget> [
                              Padding(
                                padding: EdgeInsets.only(left: 15, top: 15),
                                child: Icon(Icons.call, color: Colors.black),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 15, top: 15),
                                child:
                                Text("facebook.com/100peoficial",
                                    style: TextStyle(fontFamily: 'Roboto', fontSize: 14, color: Colors.black)),
                              )
                            ],
                          ),
                          Row(
                            children: <Widget> [
                              Padding(
                                padding: EdgeInsets.only(left: 15, top: 15),
                                child: Icon(Icons.shopping_cart, color: Colors.black),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 15, top: 15),
                                child:
                                Text("22€",
                                    style: TextStyle(fontFamily: 'Roboto', fontSize: 14, color: Colors.black)),
                              )
                            ],
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:[
                                Padding(
                                    padding: EdgeInsets.only(top:15, left: 15),
                                    child:
                                    InkWell(
                                      onTap: pushReviews,
                                      child:
                                      Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            borderRadius: BorderRadiusDirectional.all(
                                                Radius.circular(25.0)),
                                            color: Colors.orange,
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.only(top: 10, bottom: 10, left: 40, right: 40),
                                            child: Text('   See reviews   ', style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                decoration: TextDecoration.none)),
                                          )
                                      ),
                                    )
                                )
                              ]
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:[
                                Padding(
                                    padding: EdgeInsets.only(top:15, left: 15),
                                    child:
                                    InkWell(
                                      onTap: pushReviews,
                                      child:
                                      Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            borderRadius: BorderRadiusDirectional.all(
                                                Radius.circular(25.0)),
                                            color: Colors.orange,
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.only(top: 10, bottom: 10, left: 35, right: 35),
                                            child: Text('Purchase a ticket', style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                decoration: TextDecoration.none)),
                                          )
                                      ),
                                    )
                                )
                              ]
                          ),

                        ]
                    ),
                  )
                ],
              ),
              floatingActionButton: FloatingActionButton(onPressed: pushMatchScreenInterests,
                backgroundColor: Colors.deepOrange,
                child: Image.asset('assets/groups.png', height: 35, width: 35,),
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,


            );
          }
          if (id == 4){
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.orange,
                elevation: 9.0,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: Text('Event details',
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 20.0,
                        color: Colors.white)),
              ),

              body: ListView(
                //padding: EdgeInsets.all(10.0),
                children: <Widget>[

                  Expanded(
                      child: Container(
                        //fit: BoxFit.contain,
                        alignment: Alignment.centerLeft,
                        child: Image.asset('assets/berardo_banner.png'),
                      )
                  ),
                  Expanded(
                    child:
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(20.0),
                            child:
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Primeiro Modernismo às Novas\nVanguardas do Século XX",
                                  style: TextStyle(fontFamily: 'Roboto', fontSize: 20, color: Colors.deepOrange),),

                                IconButton(
                                  icon: Icon(
                                    /*------------------- Favorite icon, with color and fill check -------------------*/
                                    isFavorite ? Icons.favorite : Icons.favorite_border,
                                    color: isFavorite ? Colors.red : null,
                                  ),
                                  onPressed: (){
                                    setState(() {
                                      if(isFavorite){
                                        _favorites.remove(id);
                                      } else {
                                        _favorites.add(id);
                                      }
                                    });
                                  },
                                )
                              ],),
                          ),

                          Wrap(
                            direction: Axis.horizontal,
                            children: [
                              Padding(padding: EdgeInsets.only(left: 20, right: 15), child:
                              Text("The Berardo Collection brings together a remarkable of works that marked the history of art of the twentieth century",
                                  style: TextStyle(fontFamily: 'Roboto', fontSize: 14, color: Colors.black))),
                            ],
                          ),
                          Row(
                            children: <Widget> [
                              Padding(
                                padding: EdgeInsets.only(left: 15, top: 15),
                                child: Icon(Icons.place, color: Colors.black),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 15, top: 15),
                                child:
                                Text("Praça do Império 1449-003 Lisboa",
                                    style: TextStyle(fontFamily: 'Roboto', fontSize: 14, color: Colors.black)),
                              )
                            ],
                          ),
                          Row(
                            children: <Widget> [
                              Padding(
                                padding: EdgeInsets.only(left: 15, top: 15),
                                child: Icon(Icons.access_time, color: Colors.black),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 15, top: 15),
                                child:
                                Text("Everyday, 10:00 - 19:00",
                                    style: TextStyle(fontFamily: 'Roboto', fontSize: 14, color: Colors.black)),
                              )
                            ],
                          ),
                          Row(
                            children: <Widget> [
                              Padding(
                                padding: EdgeInsets.only(left: 15, top: 15),
                                child: Icon(Icons.call, color: Colors.black),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 15, top: 15),
                                child:
                                Text("21 361 287 8",
                                    style: TextStyle(fontFamily: 'Roboto', fontSize: 14, color: Colors.black)),
                              )
                            ],
                          ),
                          Row(
                            children: <Widget> [
                              Padding(
                                padding: EdgeInsets.only(left: 15, top: 15),
                                child: Icon(Icons.shopping_cart, color: Colors.black),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 15, top: 15),
                                child:
                                Text("18€",
                                    style: TextStyle(fontFamily: 'Roboto', fontSize: 14, color: Colors.black)),
                              )
                            ],
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:[
                                Padding(
                                    padding: EdgeInsets.only(top:15, left: 15),
                                    child:
                                    InkWell(
                                      onTap: pushReviews,
                                      child:
                                      Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            borderRadius: BorderRadiusDirectional.all(
                                                Radius.circular(25.0)),
                                            color: Colors.orange,
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.only(top: 10, bottom: 10, left: 40, right: 40),
                                            child: Text('   See reviews   ', style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                decoration: TextDecoration.none)),
                                          )
                                      ),
                                    )
                                )
                              ]
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:[
                                Padding(
                                    padding: EdgeInsets.only(top:15, left: 15),
                                    child:
                                    InkWell(
                                      onTap: pushReviews,
                                      child:
                                      Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            borderRadius: BorderRadiusDirectional.all(
                                                Radius.circular(25.0)),
                                            color: Colors.orange,
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.only(top: 10, bottom: 10, left: 35, right: 35),
                                            child: Text('Purchase a ticket', style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                decoration: TextDecoration.none)),
                                          )
                                      ),
                                    )
                                )
                              ]
                          ),

                        ]
                    ),
                  )
                ],
              ),
              floatingActionButton: FloatingActionButton(onPressed: pushMatchScreenInterests,
                backgroundColor: Colors.deepOrange,
                child: Image.asset('assets/groups.png', height: 35, width: 35,),
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,


            );
          }
          if (id == 5){
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.orange,
                elevation: 9.0,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: Text('Event details',
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 20.0,
                        color: Colors.white)),
              ),

              body: ListView(
                //padding: EdgeInsets.all(10.0),
                children: <Widget>[

                  Expanded(
                      child: Container(
                        //fit: BoxFit.contain,
                        alignment: Alignment.centerLeft,
                        child: Image.asset('assets/teatro_banner.png'),
                      )
                  ),
                  Expanded(
                    child:
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(20.0),
                            child:
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Uma Mulher Não Chora",
                                  style: TextStyle(fontFamily: 'Roboto', fontSize: 20, color: Colors.deepOrange),),

                                IconButton(
                                  icon: Icon(
                                    /*------------------- Favorite icon, with color and fill check -------------------*/
                                    isFavorite ? Icons.favorite : Icons.favorite_border,
                                    color: isFavorite ? Colors.red : null,
                                  ),
                                  onPressed: (){
                                    setState(() {
                                      if(isFavorite){
                                        _favorites.remove(id);
                                      } else {
                                        _favorites.add(id);
                                      }
                                    });
                                  },
                                )
                              ],),
                          ),

                          Wrap(
                            direction: Axis.horizontal,
                            children: [
                              Padding(padding: EdgeInsets.only(left: 20, right: 15), child:
                              Text("For 80 minutes, the singers join the musical universe of Renato Júnior. Paying homage to the reality of being a woman in the twenty first century, lending their voice to eradicate violence against women.",
                                  style: TextStyle(fontFamily: 'Roboto', fontSize: 14, color: Colors.black))),
                            ],
                          ),
                          Row(
                            children: <Widget> [
                              Padding(
                                padding: EdgeInsets.only(left: 15, top: 15),
                                child: Icon(Icons.place, color: Colors.black),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 15, top: 15),
                                child:
                                Text("Av. Frei Miguel Contreiras 52-53, Lisboa",
                                    style: TextStyle(fontFamily: 'Roboto', fontSize: 14, color: Colors.black)),
                              )
                            ],
                          ),
                          Row(
                            children: <Widget> [
                              Padding(
                                padding: EdgeInsets.only(left: 15, top: 15),
                                child: Icon(Icons.access_time, color: Colors.black),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 15, top: 15),
                                child:
                                Text("December 7, 21:00",
                                    style: TextStyle(fontFamily: 'Roboto', fontSize: 14, color: Colors.black)),
                              )
                            ],
                          ),
                          Row(
                            children: <Widget> [
                              Padding(
                                padding: EdgeInsets.only(left: 15, top: 15),
                                child: Icon(Icons.call, color: Colors.black),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 15, top: 15),
                                child:
                                Text("teatromariamatos.pt",
                                    style: TextStyle(fontFamily: 'Roboto', fontSize: 14, color: Colors.black)),
                              )
                            ],
                          ),
                          Row(
                            children: <Widget> [
                              Padding(
                                padding: EdgeInsets.only(left: 15, top: 15),
                                child: Icon(Icons.shopping_cart, color: Colors.black),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 15, top: 15),
                                child:
                                Text("18€",
                                    style: TextStyle(fontFamily: 'Roboto', fontSize: 14, color: Colors.black)),
                              )
                            ],
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:[
                                Padding(
                                    padding: EdgeInsets.only(top:15, left: 15),
                                    child:
                                    InkWell(
                                      onTap: pushReviews,
                                      child:
                                      Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            borderRadius: BorderRadiusDirectional.all(
                                                Radius.circular(25.0)),
                                            color: Colors.orange,
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.only(top: 10, bottom: 10, left: 40, right: 40),
                                            child: Text('   See reviews   ', style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                decoration: TextDecoration.none)),
                                          )
                                      ),
                                    )
                                )
                              ]
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:[
                                Padding(
                                    padding: EdgeInsets.only(top:15, left: 15),
                                    child:
                                    InkWell(
                                      onTap: pushReviews,
                                      child:
                                      Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            borderRadius: BorderRadiusDirectional.all(
                                                Radius.circular(25.0)),
                                            color: Colors.orange,
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.only(top: 10, bottom: 10, left: 35, right: 35),
                                            child: Text('Purchase a ticket', style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                decoration: TextDecoration.none)),
                                          )
                                      ),
                                    )
                                )
                              ]
                          ),

                        ]
                    ),
                  )
                ],
              ),
              floatingActionButton: FloatingActionButton(onPressed: pushMatchScreenInterests,
                backgroundColor: Colors.deepOrange,
                child: Image.asset('assets/groups.png', height: 35, width: 35,),
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,


            );
          }else {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.orange,
                elevation: 9.0,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: Text('Event details',
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 20.0,
                        color: Colors.white)),
              ),
            );
          }
        }, // ...to here.
      ),
    );
  }


/*---------------------------------- FUNCTION FOR NAVIGATING TO FAVORITES WITH BOTTOM BAR ICON ----------------------------------*/
  void pushFavorites() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        // Add lines from here...
        builder: (BuildContext context) {


          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.orange,
              elevation: 9.0,
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text('Favorites',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 20.0,
                      color: Colors.white)),
            ),
            body: ListView(
                padding: EdgeInsets.all(10.0),
                children: [
                  /*Hard coded favorites check*/
                  if(_favorites.contains(1))
                    _buildCard(
                        1,
                        'Listen (2020)',
                        'M14\nGenre: Drama \nDirector: Ana Rocha\n In the suburbs of London, Bela and Jota face serious challenges when Social Services raise doubts regarding the safety of their children. ',
                        'assets/listen.png',
                        'Cinema',
                        context),
                  if(_favorites.contains(2))
                    _buildCard(
                        2,
                        'NOS Alive',
                        'A music and arts festival which takes place in the Algés riverside in Oerias.\n\n Guests include Kendrick Lamar, Taylor Swift, Billie Eilish. Khalid, Alt-J and the Lumineers.\n\nCome have the time of your life!',
                        'assets/nos_alive.png',
                        'Concert',
                        context),
                  if(_favorites.contains(3))
                    _buildCard(
                        3,
                        'Pi 100 Pé',
                        'M06\n\nComedy show by Fernando Rocha.\nSit back, relax and have a laugh!\n\nSuper Bock Arena\n Campo Pequeno\nTickets available everywhere',
                        'assets/pi100pe.png',
                        'Comedy',
                        context),
                  if(_favorites.contains(4))
                    _buildCard(
                        4,
                        'Primeiro Modernismo às Novas Vanguardas do Século XX',
                        'The Berardo Collection brings together a remarkable of works that marked the history of art of the twentieth century',
                        'assets/berardo.png',
                        'Museum',
                        context),
                  if(_favorites.contains(5))
                    _buildCard(
                        5,
                        'Uma Mulher Não Chora',
                        'M06\nMusical\nFor 80 minutes, the singers join the musical universe of Renato Júnior. Paying homage to the reality of being a woman in the twenty first century, lending their voice to eradicate violence against women.',
                        'assets/teatro.png',
                        'Theater',
                        context),
                ]
            ),
            floatingActionButton: FloatingActionButton(onPressed: pushMatchScreenInterests,
              backgroundColor: Colors.deepOrange,
              child: Image.asset('assets/groups.png', height: 35, width: 35,),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

            bottomNavigationBar: _bottomAppBar(),

          );
        }, // ...to here.
      ),
    );
  }


/*---------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/*----------------------------------------------------------------------- DATE PICKER THINGS --------------------------------------------------------------------*/
/*---------------------------------------------------------------------------------------------------------------------------------------------------------------*/


  /// This decides which day will be enabled
  /// This will be called every time while displaying day in calender.
  bool _decideWhichDayToEnable(DateTime day) {
    if ((day.isAfter(DateTime.now().subtract(Duration(days: 1))) &&
        day.isBefore(DateTime.now().add(Duration(days: 1))))) {
      return true;
    }
    return false;
  }

  _selectDate(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    assert(theme.platform != null);
    switch (theme.platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return buildMaterialDatePicker(context);
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return buildCupertinoDatePicker(context);
    }
  }

  buildCupertinoDatePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height / 3,
            color: Colors.white,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              backgroundColor: Colors.yellow,
              onDateTimeChanged: (picked) {
                if (picked != null && picked != selectedDate)
                  setState(() {
                    selectedDate = picked;
                  });
              },
              initialDateTime: selectedDate,
              minimumYear: 2000,
              maximumYear: 2025,
            ),
          );
        });
  }

  buildMaterialDatePicker(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
      initialEntryMode: DatePickerEntryMode.calendar,
      initialDatePickerMode: DatePickerMode.day,
      selectableDayPredicate: _decideWhichDayToEnable,
      helpText: 'Select event date',
      cancelText: 'Cancel',
      confirmText: 'Select',
      errorFormatText: 'Enter valid date',
      errorInvalidText: 'Enter date in valid range',
      fieldLabelText: 'Event date',
      fieldHintText: 'Month/Date/Year',
      builder: (context, child) {
        return Theme(
          data: ThemeData.light(),
          child: child,
        );
      },
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

/*---------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/*-------------------------------------------------------------------- FILTERING MENU OVERLAY -------------------------------------------------------------------*/
/*---------------------------------------------------------------------------------------------------------------------------------------------------------------*/

  showFilterOverlay  (BuildContext context) async {
    overlayState = Overlay.of(context);
    //_overlayEntry?.remove();
    _overlayEntry = OverlayEntry(
        builder: (context) => Positioned(
            top: 40,
            right: 3,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 3.0,
                      blurRadius: 5.0)
                ],
                color: Colors.white,),
              child: Column(
                children: [
                  /* -----------------  FILTER TITLE -------------------*/
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 15.0, bottom: 10.0, left: 15, right: 15),
                          child:
                          Text('Filters',
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 20.0,
                                  color: Colors.black,
                                  decoration: TextDecoration.none)
                          ),
                        ),
                      ]
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                            padding: EdgeInsets.only(top: 5.0, bottom: 10.0, left: 15, right: 15),
                            child: Material (child: DropdownButton<String>(
                              value: dropdownValue,
                              icon: Icon(Icons.arrow_downward),
                              iconSize: 20,
                              elevation: 16,
                              style: TextStyle(fontFamily: 'Roboto', color: Colors.black),
                              underline: Container(
                                height: 2,
                                color: Colors.orange,
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  dropdownValue = newValue;
                                });
                              },
                              items: <String>[' Alphabetical Asc.        ', 'Alphabetical Dsc.', 'Price Ascending', 'Price Descending']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            )
                            )
                        ),
                      ]
                  ),
                  /* ----------------------- PRICE SLIDER --------------------------------------------*/

                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 3.0, bottom: 1.0, left: 15, right: 15),
                          child:
                          Text('Max Price (€)',
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 14.0,
                                  color: Colors.grey,
                                  decoration: TextDecoration.none)
                          ),
                        ),
                      ]
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Material(

                            child: SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  activeTrackColor: Colors.orange,
                                  inactiveTrackColor: Colors.grey,
                                  trackShape: RoundedRectSliderTrackShape(),
                                  trackHeight: 10.0,
                                  thumbColor: Colors.deepOrange,
                                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
                                  overlayColor: Colors.red.withAlpha(32),
                                  overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
                                ),
                                child: Slider(
                                  value: _currentPriceSliderValue,
                                  min: 0,
                                  max: 100,
                                  divisions: 5,
                                  label: _currentPriceSliderValue.round().toString(),
                                  onChanged: (double value) {
                                    setState(() {
                                      _currentPriceSliderValue = value;
                                    });
                                  },
                                )
                            )
                        )
                      ]
                  ),

                  /* ----------------------- CAPACITY SLIDER --------------------------------------------*/
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 3.0, bottom: 1.0, left: 15, right: 15),
                          child:
                          Text('Capacity (no. of people)',
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 14.0,
                                  color: Colors.grey,
                                  decoration: TextDecoration.none)
                          ),
                        ),
                      ]
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Material(

                            child: SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  activeTrackColor: Colors.orange,
                                  inactiveTrackColor: Colors.grey,
                                  trackShape: RoundedRectSliderTrackShape(),
                                  trackHeight: 10.0,
                                  thumbColor: Colors.deepOrange,
                                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
                                  overlayColor: Colors.red.withAlpha(32),
                                  overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
                                ),
                                child: Slider(
                                  value: _currentCapacitySliderValue,
                                  min: 0,
                                  max: 20,
                                  divisions: 5,
                                  label: _currentCapacitySliderValue.round().toString(),
                                  onChanged: (double value) {
                                    setState(() {
                                      _currentCapacitySliderValue = value;
                                    });
                                  },
                                )
                            )
                        )
                      ]
                  ),
                  GestureDetector(
                    onTap: () {_overlayEntry.remove(); },
                    child:
                    Padding(
                      padding: EdgeInsets.all(15),
                      child:
                      Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadiusDirectional.all(
                                Radius.circular(25.0)),
                            color: Colors.deepOrange,
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 20),
                            /* ------------------- Type orange tag -------------------*/
                            child: Text('Done', style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                decoration: TextDecoration.none)),
                          )
                      ),
                    ),
                  ),

                ],
              ),
            )
        ));

    overlayState.insert(_overlayEntry);
    //await Future.delayed(Duration(seconds: 15));
    //overlayEntry.remove();
  }

  /*---------------------------------- FUNCTIONS MATCH INTERFACE ----------------------------------*/
  Widget _buildCardForMatch(int id, String name, String description, String imagePath, String type, context) {
    final isFavorite = _favorites.contains(id);
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
                /*------------------- Image on the left -------------------*/
                Expanded(
                    child: Container(
                      //fit: BoxFit.contain,
                      alignment: Alignment.centerLeft,
                      child: Image.asset(imagePath),
                    )),
                /*------------------- Info on the right -------------------*/
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 8.0,),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadiusDirectional.all(
                                        Radius.circular(20.0)),
                                    color: Colors.orange
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(6.0),
                                  /* ------------------- Type orange tag -------------------*/
                                  child: Text(type, style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                                )
                            ),
                            IconButton(
                              icon: Icon(
                                /*------------------- Favorite icon, with color and fill check -------------------*/
                                isFavorite ? Icons.favorite : Icons.favorite_border,
                                color: isFavorite ? Colors.red : null,
                              ),
                              onPressed: (){
                                setState(() {
                                  if(isFavorite){
                                    _favorites.remove(id);
                                  } else {
                                    _favorites.add(id);
                                  }
                                });
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                /*------------------- Favorite icon, with color and fill check -------------------*/
                                Icons.six_ft_apart_rounded,
                                color: Colors.orange,
                              ),
                              onPressed: pushMatchMadeScreen
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 8.0, top: 8.0, bottom: 8.0, right: 8.0),
                        /* ------------------- Event Title -------------------*/
                        child: Text(name, style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrange)),
                      ),
                      Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadiusDirectional.all(
                                  Radius.circular(40.0)),
                              color: Colors.orange
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(6.0),
                            /* ------------------- Type orange tag -------------------*/
                            child: Text('Info', style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                          )
                      ),

                    ],
                  ),
                )
              ],
            )
        )
    );
  }

  Widget _buildMessage(int id, String name, String message, Color color, context) {
    return Padding(
        padding: EdgeInsets.only(left: 1.0, top: 1.0, right: 1.0, bottom: 8.0),
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                      color: Colors.white,
                      spreadRadius: 3.0,
                      blurRadius: 5.0)
                ],
                color: Colors.white),

            child: Row(
              children: <Widget>[
                /*------------------- Message -------------------*/
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: 2.0, top: 8.0, bottom: 8.0, right: 8.0),
                        /* ------------------- Event Title -------------------*/
                        child: Text(name, style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: color)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 8.0, top: 8.0, bottom: 8.0, right: 8.0),
                        child: Text(message, style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 10.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                      )

                    ],
                  ),
                )
              ],
            )
        )
    );
  }

  Widget _buildCardForFriend(int id, String name, bool friend, context) {
    final isFavorite = _favorites.contains(id);
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
                /*------------------- Info on the right -------------------*/
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
                            if(friend)
                              Text(name,
                                  style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 18.0,
                                      color: Colors.orange))
                            else if(!friend)
                              Text(name,
                                  style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 18.0,
                                      color: Colors.black)),

                            Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadiusDirectional.all(
                                        Radius.circular(20.0)),
                                    color: Colors.orange
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(6.0),
                                  /* ------------------- Type orange tag -------------------*/
                                  child: Text('See profile', style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                                )
                            ),
                            IconButton(
                              icon: Icon(
                                /*------------------- Favorite icon, with color and fill check -------------------*/
                                friend ? Icons.group : Icons.group_add,
                                color: friend ? Colors.orange : Colors.black,
                              ),
                            ),
                            if(friend)
                              Text('Friend',
                                  style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 8.0,
                                      color: Colors.orange))
                            else if(!friend)
                              Text('Add friend',
                                  style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 8.0,
                                      color: Colors.black)),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
        )
    );
  }

  void pushMatchScreenInterests() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        // Add lines from here...
        builder: (BuildContext context) {

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.orange,
              elevation: 9.0,
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text('Random Match Made!',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 20.0,
                      color: Colors.white)),
            ),
            body: ListView(
                children:[
                      Expanded(
                        child: Container(
                        //fit: BoxFit.contain,
                        alignment: Alignment.centerLeft,
                        child: Image.asset('assets/match.PNG'),
                      )),
                ]
/*
                padding: EdgeInsets.all(10.0),
                children: [
                  /*Hard coded favorites check*/
                  Text('Events found based on your interests',
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 15.0,
                          color: Colors.black)),
                  if(_favorites.contains(1))
                    _buildCardForMatch(
                        1,
                        'Listen (2020)',
                        'M14\nGenre: Drama \nDirector: Ana Rocha\n In the suburbs of London, Bela and Jota face serious challenges when Social Services raise doubts regarding the safety of their children. ',
                        'assets/listen.png',
                        'Cinema',
                        context),
                  if(_favorites.contains(2))
                    _buildCardForMatch(
                        2,
                        'NOS Alive',
                        'A music and arts festival which takes place in the Algés riverside in Oerias.\n\n Guests include Kendrick Lamar, Taylor Swift, Billie Eilish. Khalid, Alt-J and the Lumineers.\n\nCome have the time of your life!',
                        'assets/nos_alive.png',
                        'Concert',
                        context),
                  if(_favorites.contains(3))
                    _buildCardForMatch(
                        3,
                        'Pi 100 Pé',
                        'M06\n\nComedy show by Fernando Rocha.\nSit back, relax and have a laugh!\n\nSuper Bock Arena\n Campo Pequeno\nTickets available everywhere',
                        'assets/pi100pe.png',
                        'Comedy',
                        context),
                  if(_favorites.contains(4))
                    _buildCardForMatch(
                        4,
                        'Primeiro Modernismo às Novas Vanguardas do Século XX',
                        'The Berardo Collection brings together a remarkable of works that marked the history of art of the twentieth century',
                        'assets/berardo.png',
                        'Museum',
                        context),
                  if(_favorites.contains(5))
                    _buildCardForMatch(
                        5,
                        'Uma Mulher Não Chora',
                        'M06\nMusical\nFor 80 minutes, the singers join the musical universe of Renato Júnior. Paying homage to the reality of being a woman in the twenty first century, lending their voice to eradicate violence against women.',
                        'assets/teatro.png',
                        'Theater',
                        context),
                ]
            ),*/
            ),

            floatingActionButton: FloatingActionButton(onPressed: pushChat,
              backgroundColor: Colors.white,
              child: Icon(Icons.forum, size: 35, color: Colors.deepOrange),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

            //bottomNavigationBar: _bottomAppBar(),

          );
        }, // ...to here.
      ),
    );
  }

  void pushProfile(){
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        // Add lines from here...
        builder: (BuildContext context) {
          return Scaffold(
            backgroundColor: Colors.orange,
            appBar: AppBar(
              elevation: 9.0,
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text('Profile',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 20.0,
                      color: Colors.white)),
            ),
            body: ListView(
                //padding: EdgeInsets.all(10.0),
                children: [
                  Expanded(
                      child: Container(
                        //fit: BoxFit.contain,
                        alignment: Alignment.centerLeft,
                        child: Image.asset('assets/profile.PNG'),
                      )),
                ]
            ),
            floatingActionButton: FloatingActionButton(onPressed: pushChat,
              backgroundColor: Colors.deepOrange,
              child: Icon(Icons.edit, size: 35, color: Colors.white),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          );
        }, // ...to here.
      ),
    );
  }

  void pushMatchMadeScreen() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        // Add lines from here...
        builder: (BuildContext context) {
          return Scaffold(
            backgroundColor: Colors.orange,
            appBar: AppBar(
              elevation: 9.0,
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text('Match Made',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 20.0,
                      color: Colors.white)),
            ),
            body: ListView(
                padding: EdgeInsets.all(10.0),
                children: [
                  /*People Matched*/
                  Image.asset('assets/joaquim.png', height: 60, width: 60),
                  Image.asset('assets/beatriz.png', height: 60, width: 60),
                  Image.asset('assets/rodrigo.png', height: 60, width: 60),
                  IconButton(
                      icon: Icon(
                        /*------------------- Favorite icon, with color and fill check -------------------*/
                        Icons.chat,
                        color: Colors.white,
                      ),
                      onPressed: pushChat
                  )
                ]
            ),
          );
        }, // ...to here.
      ),
    );
  }

  void pushChat() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        // Add lines from here...
        builder: (BuildContext context) {

          return Scaffold(
            backgroundColor: Colors.orange,
            appBar: AppBar(
              backgroundColor: Colors.orange,
              elevation: 9.0,
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text('Chat',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 20.0,
                      color: Colors.white)),
            ),
            body: ListView(
                //padding: EdgeInsets.all(10.0),
                children: [
                  Expanded(
                      child: Container(
                        //fit: BoxFit.contain,
                        alignment: Alignment.centerLeft,
                        child: Image.asset('assets/chat.PNG'),
                      )
                  ),
                  /*
                  /*Messages*/
                  _buildMessage(
                        1,
                        'Beatriz',
                        'Mal posso esperar por este dia!',
                        Colors.green,
                        context),
                  _buildMessage(
                      2,
                      'Rodrigo',
                      'A que horas combinamos encontrar-nos?',
                      Colors.blue,
                      context),
                  Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadiusDirectional.all(
                              Radius.circular(40.0)),
                          color: Colors.white
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(6.0),
                        /* ------------------- Type orange tag -------------------*/
                        child: Text('Write message', style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 10.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                      )
                  ),
                  IconButton(
                      icon: Icon(
                        /*------------------- Favorite icon, with color and fill check -------------------*/
                        Icons.group_add,
                        color: Colors.white,
                      ),
                      onPressed: pushAddFriendScreen
                  ),
                  Text('Add Friend', style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 10.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),

                   */
                ]

            ),

            floatingActionButton: FloatingActionButton(onPressed: pushMatchScreenInterests,
              backgroundColor: Colors.deepOrange,
              child: Image.asset('assets/groups.png', height: 35, width: 35,),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

            bottomNavigationBar: _bottomAppBar(),

          );
        }, // ...to here.
      ),
    );
  }

  void pushAddFriendScreen() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        // Add lines from here...
        builder: (BuildContext context) {

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.orange,
              elevation: 9.0,
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text('Match',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 20.0,
                      color: Colors.white)),
            ),
            body: ListView(
                padding: EdgeInsets.all(10.0),
                children: [
                 _buildCardForFriend(
                        1,
                        'Beatriz Carvalho, 21',
                        true,
                        context),
                  _buildCardForFriend(
                      2,
                      'Rodrigo Costa, 24',
                      false,
                      context),
                ]
            ),
            floatingActionButton: FloatingActionButton(onPressed: pushMatchScreenInterests,
              backgroundColor: Colors.deepOrange,
              child: Image.asset('assets/groups.png', height: 35, width: 35,),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

            bottomNavigationBar: _bottomAppBar(),

          );
        }, // ...to here.
      ),
    );
  }


}
