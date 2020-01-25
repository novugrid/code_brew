import 'package:code_brew_example/ui/DashboardScreen.dart';
import 'package:code_brew_example/ui/list/UserListScreen.dart';
import 'package:flutter/material.dart';

///
/// project: code_brew
/// @package:
/// @author dammyololade <dammyololade2010@gmail.com>
/// created on 2020-01-23
class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  List<Widget> widgets = [];

  @override
  void initState() {
    widgets = [
      DashboardScreen(),
      UserListScreen(),
      randomWidget("Notifications"),
      randomWidget("Profile"),
    ];
    super.initState();
  }

  Widget randomWidget(String text) {
    return Center(
      child: Text(text),
    );
  }

  @override
  Widget build(BuildContext context) {
//    SystemChrome.setSystemUIOverlayStyle(
//        SystemUiOverlayStyle.light.copyWith(statusBarColor: Theme.of(context).primaryColorDark));
    return SafeArea(

      child: Scaffold(
//        appBar: AppBar(
//          title: Text(widgets[currentIndex].,
//            style: TextStyle(color: Colors.black),
//          ),
//          elevation: 0,
//          centerTitle: true,
//          backgroundColor: Colors.white,
//        ),
        bottomNavigationBar: Stack(
          children: <Widget>[
            Card(
              elevation: 20,
              margin: EdgeInsets.symmetric(),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
              ),
              child: Container(
                height: 65,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
                ),
                child: SizedBox(),
              ),
            ),

            Positioned(
              top: 2,
              right: 15,
              left: 15,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width - 20,
                ),
                child: BottomNavigationBar(
                    elevation: 0,
                    showUnselectedLabels: false,
                    showSelectedLabels: false,
                    backgroundColor: Theme.of(context).accentColor,
                    currentIndex: currentIndex,
                    onTap: (index) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    type: BottomNavigationBarType.fixed,
                    items: [
                      bottomNavWidget(Icons.home),
                      bottomNavWidget(Icons.shopping_cart),
                      bottomNavWidget(Icons.notifications),
                      bottomNavWidget(Icons.person),
                    ]),
              ),
            ),
          ],
        ),
        body: IndexedStack(
          index: currentIndex,
          children: widgets,
        ),
      ),
    );
  }

  BottomNavigationBarItem bottomNavWidget(IconData icon) {
    return BottomNavigationBarItem(
        title: Text(""),
        icon: Icon(icon, color: Colors.white.withOpacity(0.5), size: 20,),
        activeIcon: Icon(icon, color: Colors.white, size: 20,)
    );
  }
}
