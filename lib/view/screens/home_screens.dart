import 'package:flutter/material.dart';
import 'package:assignment1/view/screens/top_tab_screen.dart';
import 'package:assignment1/view/screens/popular_tab_screen.dart';
import 'package:assignment1/view/screens/feature_tab_screen.dart';
import 'package:assignment1/utils/drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Deals', style: TextStyle(color: Colors.white)),
        actions: _buildAppBarActions(),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white,
          tabs: const [
            Tab(text: 'Top'),
            Tab(text: 'Popular'),
            Tab(text: 'Feature'),
          ],
        ),
      ),
      drawer: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.blue,
        ),
        child: const AppDrawer(),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          TopScreen(),
          PopularScreen(),
          FeatureScreen(),
        ],
      ),
      floatingActionButton: ClipOval(
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.red.shade300,
          child: const Icon(
            Icons.currency_rupee,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  List<Widget> _buildAppBarActions() {
    return [
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: () {
          setState(() {
            _isSearching = !_isSearching;
          });
        },
      ),
    ];
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
