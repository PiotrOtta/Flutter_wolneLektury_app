import 'package:flutter/material.dart';
import 'package:wolne_lektury_client/screens/book_list.dart';
import 'package:wolne_lektury_client/screens/favorites.dart';
import 'package:wolne_lektury_client/screens/search.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<StatefulWidget> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, bottom: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: NavigationBar(
              labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
              onDestinationSelected: (int index) {
                setState(() {
                  currentPageIndex = index;
                });
              },
              height: 60,
              selectedIndex: currentPageIndex,
              destinations: const [
                NavigationDestination(
                    selectedIcon: Icon(Icons.home),
                    icon: Icon(Icons.home_outlined),
                    tooltip: "",
                    label: "Home"),
                NavigationDestination(
                    selectedIcon: Icon(Icons.search),
                    icon: Icon(Icons.search_outlined),
                    tooltip: "",
                    label: "Search"),
                NavigationDestination(
                    selectedIcon: Icon(Icons.favorite),
                    icon: Icon(Icons.favorite_border),
                    tooltip: "",
                    label: "Favorites"),
              ],
            ),
          ),
        ),
        body: <Widget>[
          // home screen
          const BookListScreen(),
          // search screen
          const SearchScreen(),
          // favorites screen
          const FavoritesScreen()
        ][currentPageIndex]);
  }
}
