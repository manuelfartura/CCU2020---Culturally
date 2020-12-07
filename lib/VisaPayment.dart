import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:culturally/main.dart';
import './loginPage.dart';
import './signUpPage.dart';
import './paymentConfirmed.dart';

class VisaPayment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            title: Text('Payment',
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 20.0,
                    color: Colors.white))),
        floatingActionButton: FloatingActionButton(onPressed: () {},
          backgroundColor: Colors.deepOrange,
          child: Image.asset('images/groups.png', height: 35, width: 35,),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
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
                                  onPressed: null),
                              IconButton(
                                icon: Icon(Icons.favorite, color: Colors.white),
                                //onPressed: pushFavorites
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
            )),
        body: Stack(
            children: <Widget>[
              new Positioned.fill(
                  top: -500,
                  right: 260,
                  child: Container(
                    width: 250,
                    height:250,
                    decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage('images/visaSelected.png'), scale: 1.1)
                    ),
                  )),
              new Positioned.fill(
                  top: -500,
                  right: 90,
                  child: Container(
                    width: 250,
                    height:250,
                    decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage('images/mbway.png'), scale: 2)
                    ),
                  )),
              new Positioned.fill(
                  top: -500,
                  right: -80,
                  child: Container(
                    width: 250,
                    height:250,
                    decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage('images/paypal.png'), scale: 2)
                    ),
                  )),
              new Positioned.fill(
                  top: -500,
                  right: -250,
                  child: Container(
                    width: 250,
                    height:250,
                    decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage('images/multibanco.png'), scale: 2)
                    ),
                  )),
              new Container(
                  child: Column(
                      children: <Widget>[
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  width: 340,
                                  padding: EdgeInsets.only(top:120),
                                  child: TextField(
                                      textAlign: TextAlign.left,
                                      textAlignVertical: TextAlignVertical.center,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.grey[300],
                                        border: OutlineInputBorder(),
                                        labelText: 'Card number',
                                      )))]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  width: 340,
                                  padding: EdgeInsets.only(top:15),
                                  child: TextField(
                                      textAlign: TextAlign.left,
                                      textAlignVertical: TextAlignVertical.center,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.grey[300],
                                        border: OutlineInputBorder(),
                                        labelText: 'Expiration date (MM/YY)',
                                      )))]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  width: 340,
                                  padding: EdgeInsets.only(top:15),
                                  child: TextField(
                                      textAlign: TextAlign.left,
                                      textAlignVertical: TextAlignVertical.center,
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.grey[300],
                                        border: OutlineInputBorder(),
                                        labelText: 'CVV',
                                      )))]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  width: 340,
                                  padding: EdgeInsets.only(top:15),
                                  child: TextField(
                                      textAlign: TextAlign.left,
                                      textAlignVertical: TextAlignVertical.center,
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.grey[300],
                                        border: OutlineInputBorder(),
                                        labelText: 'Card holder name',
                                      )))])
                       ])),
              new Positioned.fill(
                  top: 450,
                  child: Align(
                      alignment: Alignment.center,
                      child: FlatButton(
                        color: Colors.orange[700],
                        textColor: Colors.white,
                        padding: EdgeInsets.all(8.0),
                        minWidth: 100,
                        shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => paymentConfirmed()),
                          );
                        },
                        child: Text(
                          "Pay",
                          style: TextStyle(fontSize: 20.0),
                        ),
                      )))]));
  }
}