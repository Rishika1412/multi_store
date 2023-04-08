import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:multi_store/main_screens/cart.dart';
import 'package:multi_store/main_screens/category.dart';
import 'package:multi_store/main_screens/home.dart';
import 'package:multi_store/main_screens/profile.dart';
import 'package:multi_store/main_screens/stores.dart';
import 'package:multi_store/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomerHomeScreen> createState() => CustomerHomeScreenState();
}

class CustomerHomeScreenState extends State<CustomerHomeScreen> {
  int _selectedIndex = 0;
  final List<Widget> tabs = [
    const HomeScreen(),
    const CategoryScreen(),
    const StoresScreen(),
    const CartScreen(),
    const ProfileScreen(
        /* documentId: FirebaseAuth.instance.currentUser!.uid, */
        ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedIconTheme: const IconThemeData(color: Colors.cyan),
        unselectedIconTheme: const IconThemeData(color: Colors.black),
        selectedLabelStyle:
            const TextStyle(fontWeight: FontWeight.w600, color: Colors.cyan),
        unselectedLabelStyle: const TextStyle(color: Colors.black),
        elevation: 10,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Category',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.shop),
            label: 'Stores',
          ),
          BottomNavigationBarItem(
            icon: Badge(
                showBadge: context.read<Cart>().getItems.isEmpty ? false : true,
                badgeStyle: BadgeStyle(
                  padding: const EdgeInsets.all(2),
                  badgeColor: Colors.cyan,
                ),
                badgeContent: Text(
                  context.watch<Cart>().getItems.length.toString(),
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
                child: const Icon(Icons.shopping_cart)),
            label: 'Cart',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
