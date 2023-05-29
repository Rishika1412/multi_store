import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:multi_store/galleries/accessories_gallery.dart';
import 'package:multi_store/galleries/bags_gallery.dart';
import 'package:multi_store/galleries/beauty_gallery.dart';
import 'package:multi_store/galleries/electronics_gallery.dart';
import 'package:multi_store/galleries/homegarden_gallery.dart';
import 'package:multi_store/galleries/kids_gallery.dart';
import 'package:multi_store/galleries/men_gallery.dart';
import 'package:multi_store/galleries/shoes_gallery.dart';
import 'package:multi_store/galleries/women_gallery.dart';
import 'package:multi_store/widgets/fake_search.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAnalytics.instance.setCurrentScreen(screenName: 'Home Screen');
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 9,
      child: Scaffold(
        backgroundColor: Colors.blueGrey.shade100.withOpacity(0.5),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 6,
          backgroundColor: Colors.white,
          title: const FakeSearch(),
          bottom: const TabBar(
            indicatorWeight: 2,
            isScrollable: true,
            tabs: [
              RepeatedTab(label: 'Men'),
              RepeatedTab(label: 'Women'),
              RepeatedTab(label: 'Shoes'),
              RepeatedTab(label: 'Bags'),
              RepeatedTab(label: 'Electronics'),
              RepeatedTab(label: 'Accessories'),
              RepeatedTab(label: 'Home & Garden'),
              RepeatedTab(label: 'Kids'),
              RepeatedTab(label: 'Beauty'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            MenGalleryScreen(),
            WomenGalleryScreen(),
            ShoesGalleryScreen(),
            BagsGalleryScreen(),
            ElectronicsGalleryScreen(),
            AccessoriesGalleryScreen(),
            HomeGardenGalleryScreen(),
            KidsGalleryScreen(),
            BeautyGalleryScreen()
          ],
        ),
      ),
    );
  }
}

class RepeatedTab extends StatelessWidget {
  final String label;
  const RepeatedTab({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Text(
        label,
        style: TextStyle(color: Colors.grey.shade600),
      ),
    );
  }
}
