import 'package:flutter/material.dart';
import 'package:my_social_app/chat/layout/chat_page.dart';
import 'package:my_social_app/common/layout/custom_app_bar.dart';
import 'package:my_social_app/post/layout/post_provider_page.dart';
import 'package:my_social_app/profile/layout/profile_page.dart';
import 'package:my_social_app/user/data/models/user.dart';

class HomeScreen extends StatefulWidget {
  final User user;

  const HomeScreen({
    Key key,
    @required this.user,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _pageIndex = 0;
  final _pages = [
    PostProviderPage(),
    ChatPage(),
    ProfilePage(),
  ];

  final titles = ['Post', 'Chat', 'Profile'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: titles[_pageIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageIndex,
        onTap: (selectedIndex) {
          setState(() {
            _pageIndex = selectedIndex;
          });
        },
        showSelectedLabels: true,
        showUnselectedLabels: false,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Theme.of(context).primaryColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.add_to_photos),
            title: Text('Post'),
            activeIcon: Icon(Icons.photo),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble),
            title: Text('Chat'),
            activeIcon: Icon(Icons.chat),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            title: Text('Profile'),
            activeIcon: Icon(Icons.person),
          ),
        ],
      ),
      body: _pages[_pageIndex],
    );
  }
}
