// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:movie_test/screens/homepage.screen.dart';
import 'package:movie_test/screens/search.screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 1;

  final List<Widget> _screens = [
    DashboardScreen(),
    MoviesHomePage(),
    MediaLibraryScreen(),
    MoreScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFF6F6FA),
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            "Watch",
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
          ),
          actions: [
            IconButton(
              onPressed: () async {
                // ignore: use_build_context_synchronously
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MovieSearch(),
                  ),
                );
              },
              icon: Icon(Icons.search, color: Colors.black),
            ),
          ],
        ),
        body: _screens[_currentIndex],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Color(0xFF2E2739),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            selectedIconTheme: IconThemeData(color: Colors.white),
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            //im using exported pngs, not Icon class, so i can not change color here, i need permission for editing to get the right png
            items: [
              BottomNavigationBarItem(
                icon: Image.asset("assets/images/dashboard.png"),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                icon: Image.asset("assets/images/watch.png"),
                label: 'Watch',
              ),
              BottomNavigationBarItem(
                icon: Image.asset("assets/images/media.png"),
                label: 'Media Library',
              ),
              BottomNavigationBarItem(
                icon: Image.asset("assets/images/more.png"),
                label: 'More',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Dashboard Screen'),
    );
  }
}

class MediaLibraryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Media Library Screen'),
    );
  }
}

class MoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('More Screen'),
    );
  }
}
