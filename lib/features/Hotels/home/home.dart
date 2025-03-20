import 'package:flights/features/Flights/search_flight/presentation/search_flight_taps.dart';
import 'package:flights/features/Hotels/home/domain/bottom_bar_controller.dart';
import 'package:flights/features/Hotels/home/settings_page.dart';
import 'package:flights/features/Hotels/searchHotel/presentation/search_hotels_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/home_header.dart';
import 'widgets/horizental_list.dart';
import 'widgets/section_title.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 1500),
    vsync: this,
  )..forward();

  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(0.0, 1.0),
    end: Offset.zero,
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.easeOut,
  ));
  final bottomBarController = Get.find<BottomBarController>();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<String> categories = ['hotels'.tr, 'flights'.tr, 'More'.tr];
    final List<IconData> icons = [Icons.hotel, Icons.flight, Icons.flood];
    List<Widget> pagesButton = [
      const SearchHotelsPage(),
      const SearchFlightsPage(),
    ];

    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: 'Home'.tr,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.hotel),
              label: 'hotels'.tr,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.flight),
              label: 'flights'.tr,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.settings),
              label: 'settings'.tr,
            ),
          ],
          currentIndex: bottomBarController.currentIndex.value,
          onTap: (index) {
            if (index != bottomBarController.currentIndex.value) {
              bottomBarController.updateCurrentIndex(index);
            }
          },
        ),
        body: Obx(
          () => IndexedStack(
            index: bottomBarController.currentIndex.value,
            children: [
              HomePage(
                  pagesButton: pagesButton,
                  icons: icons,
                  categories: categories,
                  offsetAnimation: _offsetAnimation),
              const SearchHotelsPage(),
              const SearchFlightsPage(),
              SettingsPage(),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
    required this.pagesButton,
    required this.icons,
    required this.categories,
    required Animation<Offset> offsetAnimation,
  }) : _offsetAnimation = offsetAnimation;

  final List<Widget> pagesButton;
  final List<IconData> icons;
  final List<String> categories;
  final Animation<Offset> _offsetAnimation;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HomeHeader(
              pagesButton: pagesButton, icons: icons, categories: categories),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                SlideTransition(
                  position: _offsetAnimation,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SectionTitle(title: 'Popular Offers '.tr),
                      const SizedBox(height: 10),
                      HorizontalList(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
