import 'package:flutter/material.dart';
import '../screene/home_page.dart';
import '../screene/screene/AddCaffe.dart';
import '../screene/screene/addProduit.dart';

class NavBar extends StatefulWidget {
  NavBar({Key? key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddCaffe()),
              );
            },
            child: Icon(
              Icons.account_circle_outlined,
              color: Color(0xFF04764E),
              size: 35,
            ),
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddProduit()),
              );
            },
            child: Icon(
              Icons.add_box,
              color: Color(0xFF04764E),
              size: 35,
            ),
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
            child: Icon(
              Icons.home_outlined,
              color: Color(0xFF04764E),
              size: 35,
            ),
          ),
          label: '',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Color(0xFF04764E),
      onTap: _onItemTapped,
      showSelectedLabels: false,
      showUnselectedLabels: false,
    );
  }
}
