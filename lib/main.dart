// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

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
      home: HomePage(),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* App bar, at the top of the screen*/
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
              onPressed: () {}
          ),
        ],
      ),
      /* Main screen body, has event cards */
      body: ListView(
        padding: EdgeInsets.all(10.0),
        children: <Widget>[
/* ------------------- Date picker box -------------------*/
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

          /* ------------------- Event cards list -------------------*/
          if(selectedDate.day.isOdd)
          _buildCard(
              1,
              'Listen (2020)',
              'M14\nGenre: Drama \nDirector: Ana Rocha\n In the suburbs of London, Bela and Jota face serious challenges when Social Services raise doubts regarding the safety of their children. ',
              'assets/listen.png',
              'Cinema',
              context),
          if(selectedDate.day.isEven)
          _buildCard(
              2,
              'NOS Alive',
              'A music and arts festival which takes place in the Algés riverside in Oerias.\n\n Guests include Kendrick Lamar, Taylor Swift, Billie Eilish. Khalid, Alt-J and the Lumineers.\n\nCome have the time of your life!',
              'assets/nos_alive.png',
              'Concert',
              context),
          if(selectedDate.day.isOdd)
          _buildCard(
              3,
              'Pi 100 Pé',
              'M06\n\nComedy show by Fernando Rocha.\nSit back, relax and have a laugh!\n\nSuper Bock Arena\n Campo Pequeno\nTickets available everywhere',
              'assets/pi100pe.png',
              'Comedy',
              context),
          if(selectedDate.day.isEven)
          _buildCard(
              4,
              'Primeiro Modernismo às Novas Vanguardas do Século XX',
              'The Berardo Collection brings together a remarkable of works that marked the history of art of the twentieth century',
              'assets/berardo.png',
              'Museum',
              context),
          if(selectedDate.day.isOdd)
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
      floatingActionButton: FloatingActionButton(onPressed: () {},
        backgroundColor: Colors.deepOrange,
        child: Image.asset('assets/groups.png', height: 35, width: 35,),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      /* ------------------- Bottom Navigation Bar with the 4 icons -------------------*/
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
                            onPressed: pushHomepage),
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
                            onPressed: null),
                        IconButton(
                            icon: Icon(Icons.account_box, color: Colors.white),
                            onPressed: null),
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
            floatingActionButton: FloatingActionButton(onPressed: () {},
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



}
