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
      bottomNavigationBar: NavigationBar(
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const [
          NavigationDestination(
            selectedIcon: Icon(Icons.home), 
            icon: Icon(Icons.home_outlined),
            label: "Home"
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.search), 
            icon: Icon(Icons.search_outlined),
            label: "Search"
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.favorite), 
            icon: Icon(Icons.favorite_border),
            label: "Favorites"
          ),                    
        ],          
      ),
        body: <Widget> [
          // home screen
          const BookListScreen(),
          // search screen
          const SearchScreen(),
          // favorites screen
          const FavoritesScreen()
        ][currentPageIndex]
    );
  }
}
