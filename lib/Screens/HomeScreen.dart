import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:share_plus/share_plus.dart';

import 'Home.dart';

void main() {
  runApp(HomeScreen());
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HomeScreenPage(title: '',);
  }
}

class HomeScreenPage extends StatefulWidget {
  HomeScreenPage ({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreenPage > {



  Widget _widgetBody = HomeSectionScreen();
  int _currrentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _onItemTapped(int index) async{
    setState(() {
      if(index == 0){
        _currrentIndex = index;
        _widgetBody = HomeSectionScreen();
      }
      else if(index == 1){
        _currrentIndex = index;
        _widgetBody = Center(child: Text('Hell'),);
      }
      else if(index == 2){
        _currrentIndex = index;
        _widgetBody = Center(child: Text('Hell'),);
      }
      else if(index == 3){
        _currrentIndex = index;
        _widgetBody = Center(child: Text('Hell'),);
      }
      else if(index == 4){
        _currrentIndex = index;
        _widgetBody = Center(child: Text('Hell'),);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Color(0xFFFFFFFF),
        centerTitle: true,
        title: Column(
          children: [
            Image.asset('assets/logo.png', width: 100,)
          ],
        ),
        leading: PopupMenuButton<String>(
          icon: Icon(Icons.more_vert, color: Colors.grey[800]),
          onSelected: (String value) {
            // Handle menu item selection
            switch (value) {
              case 'item1':
              // Handle item 1 selection
                break;
              case 'item2':
              // Handle item 2 selection
                break;
            // Add more cases for additional menu items
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: 'item1',
              child: Text('About Us'),
            ),
            const PopupMenuItem<String>(
              value: 'item2',
              child: Text('Services'),
            ),
            const PopupMenuItem<String>(
              value: 'item2',
              child: Text('Contact Information'),
            ),
            // Add more PopupMenuItems for additional menu items
          ],
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Share.share("Harshit's assignment");
            },
            icon: Icon(
              FeatherIcons.send,
              color: Colors.grey[800],
            ),
          ),
        ], systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body:  SafeArea(
        child: Container(
          child: _widgetBody,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currrentIndex,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
              icon: _currrentIndex==0?Icon(MdiIcons.home,size: 25,):Icon(MdiIcons.homeOutline,size: 25),
              label: "Feed"
          ),
           BottomNavigationBarItem(
              icon: _currrentIndex==1?Icon(FeatherIcons.search, size: 25):Icon(FeatherIcons.search, size: 25,color: Colors.grey,),
              label: "Search"
          ),
           BottomNavigationBarItem(
              icon: _currrentIndex==2?Icon(FeatherIcons.plusSquare, size: 25):Icon(FeatherIcons.plusSquare, size: 25,color: Colors.grey,),
              label: "Upload"
          ),
          BottomNavigationBarItem(
              icon: _currrentIndex==3?Icon(MdiIcons.heart, size: 25):Icon(MdiIcons.heartOutline, size: 25),
              label: "Likes"
          ),
          BottomNavigationBarItem(
              icon: _currrentIndex==4?Icon(MdiIcons.accountCircle, size: 25):Icon(MdiIcons.account, size: 25),
              label: "Account"
          ),
        ],
      ),
    );
  }
}
