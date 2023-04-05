import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      color: Colors.white,
      child: ListView(
        children: [
          CategoriesStore(),
        ],
      ),
    ));
  }
}

class CategoriesStore extends StatelessWidget {
  const CategoriesStore({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(children: [
          Row(
            children: const [
              Expanded(
                  child: Text(
                'Categories',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              )),
              Text(
                'See more',
                style: TextStyle(fontSize: 16, color: Colors.lightGreen),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 150,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categoriesController.categories.length,
                itemBuilder: (context, index) {
                  return CategoriesItem(
                      category: categoriesController.categories[index]);
                }),
          )
        ]),
      ),
    );
  }
}
