import 'package:flutter/material.dart';
import '../screen/home_screen.dart';
import '../screen/save_recipes_screen.dart';
import '../screen/profile_screen.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  const CustomBottomNavBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.deepOrange,
      unselectedItemColor: Colors.grey,
      currentIndex: currentIndex,
      onTap: (index) {
        if (index == currentIndex) return;

        Widget nextScreen;
        switch (index) {
          case 0:
            nextScreen = const HomeScreen();
            break;
          case 3:
            nextScreen = const SavedRecipesScreen();
            break;
          case 4:
            nextScreen = const ProfileScreen();
            break;
          default:
            return;
        }

        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => nextScreen,
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
      },
      items: [
        const BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: ''),
        const BottomNavigationBarItem(icon: Icon(Icons.calendar_today_outlined), label: ''),
        const BottomNavigationBarItem(
          icon: CircleAvatar(
            backgroundColor: Colors.deepOrange,
            child: Icon(Icons.qr_code_scanner, color: Colors.white),
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Image.network(
            'https://img.lightshot.app/sgYyX5kwTsqM623JXgAAaQ.png',
            width: 24,
            height: 24,
            color: currentIndex == 3 ? Colors.deepOrange : Colors.grey,
          ),
          label: '',
        ),
        const BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ''),
      ],
    );
  }
}
