import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repoblemapp/pages/fav_offers.dart';
import 'package:repoblemapp/pages/inicio.dart';
import 'package:repoblemapp/pages/profile.dart';
import 'package:repoblemapp/pages/searchPage.dart';
import 'package:repoblemapp/pages/socialdashboard.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 2;


  final screen = [Search(),Fav(),Inicio(),Social(),Profile()];

  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.lightGreen[200],
        color: Colors.teal[700],

        index: selectedIndex,
        items: [
          Icon(
            Icons.search,
            size: 30,
            color: Colors.white,),
          Icon(
              Icons.star,
              size: 30,
              color: Colors.white,),
          Icon(
            Icons.home,
            size: 30,
            color: Colors.white,),
          Icon(
            Icons.messenger,
            size: 30,
            color: Colors.white,),
          Icon(
            Icons.person,
            size: 30,
            color: Colors.white,)
        ],
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        animationDuration: const Duration(milliseconds: 600),
      ),
      body: screen[selectedIndex],
    );
  }
}
/*
  /*int pageIndex = 0;*/

  final Profile userProfile = Profile();

  Widget showPage = new Profile();

  Widget selector(int page) {
    switch (page) {
      case 0:
        return userProfile /*pagina busqueda*/;
        break;
      case 1:
        return userProfile; /*favoritos;*/
        break;
      case 2:
        return userProfile; /*añadir oferta*/
        break;
      case 3:
        return userProfile /*chats*/;
        break;
      case 4:
        return userProfile;
        break;
      default:
        return new Container(
          child: new Center(
            child: new Text(
              'No em trobat cap pagina'
              ),
          ),
        );
      
    }
  }/*

  @override
  Widget build(BuildContext context) {
    var curvedNavigationBar2 = CurvedNavigationBar(
          initialIndex: pageIndex,
          items: <Widget>[
            Icon(Icons.add, size: 30),
            Icon(Icons.list, size: 30),
            Icon(Icons.compare_arrows, size: 30),
            Icon(Icons.call_split, size: 30),
            Icon(Icons.perm_identity, size: 30),
          ],
          color: Colors.white,
          buttonBackgroundColor: Colors.white,
          backgroundColor: Colors.blueAccent,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (int tappedIndex) {
            setState(() {
              showPage = selector(tappedIndex);
            });
          },
          letIndexChange: (index) => true,
        );
    var curvedNavigationBar = curvedNavigationBar2;
    return Scaffold(
        bottomNavigationBar: curvedNavigationBar,
        body: Container(
          color: Colors.blueAccent,
          child: Center(
            child: showPage,
          ),
        ));
  }*/
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 0,
          height: 50.0,
          items: <Widget>[
            Icon(Icons.search, size: 30),
            Icon(Icons.star, size: 30),
            Icon(Icons.add, size: 30),
            Icon(Icons.people, size: 30),
            Icon(Icons.perm_identity, size: 30),
          ],
          color: Colors.white,
          buttonBackgroundColor: Colors.white,
          backgroundColor: Colors.blueAccent,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              _page = index;
            });
          },
          letIndexChange: (index) => true,
        ),
        body: Container(
          color: Colors.blueAccent,
          child: Center(
            child: Column(
              children: <Widget>[
                Text(_page.toString(), textScaleFactor: 10.0),
                RaisedButton(
                  child: Text('Go To Page of index 1'),
                  onPressed: () {
                    final CurvedNavigationBarState navBarState =
                        _bottomNavigationKey.currentState;
                    navBarState.setPage(1);
                  },
                )
              ],
            ),
          ),
        ));
  }
}*/
