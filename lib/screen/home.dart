import 'package:do_an_thuc_hanh_2/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

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
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: flag ? const HomeHeader() : const MenuHeader(),
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
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            screen[selectindex]
          ],
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

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: 'Search product',
              hintStyle: TextStyle(color: Colors.black54),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.black54,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {},
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
