import 'package:do_an_thuc_hanh_2/Controller/profile_controller.dart';
import 'package:do_an_thuc_hanh_2/Controller/search_controller.dart';
import 'package:do_an_thuc_hanh_2/model/product.dart';
import 'package:do_an_thuc_hanh_2/screen/cart_screen.dart';
import 'package:do_an_thuc_hanh_2/screen/favorite_screen.dart';
import 'package:do_an_thuc_hanh_2/screen/home_screen.dart';
import 'package:do_an_thuc_hanh_2/screen/notification_screen.dart';
import 'package:do_an_thuc_hanh_2/screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var selectindex = 0;
  var flag = true;
  List<Widget> screen = [
    //screen
    HomeScreen(),
    FavoriteScreen(),
    NotificationScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: !flag ? const MenuHeader() : const HomeHeader(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: selectindex,
        onTap: (index) {
          setState(() {
            selectindex = index;
            if (selectindex != 3) {
              flag = true;
            } else {
              flag = false;
            }
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notification',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: context.height + 100,
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              screen[selectindex]
            ],
          ),
        ),
      ),
    );
  }
}

class MenuHeader extends StatelessWidget {
  const MenuHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      alignment: Alignment.centerLeft,
      decoration: const BoxDecoration(
        color: Colors.green,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: const [
            Expanded(
              child: Text(
                'Account info',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class HomeHeader extends StatefulWidget {
  const HomeHeader({super.key});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            readOnly: true,
            onTap: () {
              showSearch(
                  context: context,
                  // delegate to customize the search bar
                  delegate: SearchController());
            },
            decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: 'Search product',
              hintStyle: TextStyle(color: Colors.black54),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.black54,
              ),
            ),
            style: const TextStyle(color: Colors.black),
          ),
        ),
        GestureDetector(
          onTap: () {
            Get.to(() => CartScreen());
          },
          child: Container(
            height: 40,
            width: 40,
            padding: const EdgeInsets.all(10),
            child: const Icon(Icons.shopping_cart_outlined),
          ),
        )
      ],
    );
  }
}
