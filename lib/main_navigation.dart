import 'package:flutter/material.dart';
import 'package:book_share/delete_products.dart';
import 'package:book_share/profile.dart';
import 'uiside.dart';
import 'add_items.dart';

class MainNavigation extends StatefulWidget {
  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    ProductInventory(),
    AddItemPage(entry: null),
    DeleteProductsPage(),
    ManageProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box),
            label: 'Add Item',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit),
            label: 'Edit/Delete',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),

        ],
      ),
    );
  }
}

