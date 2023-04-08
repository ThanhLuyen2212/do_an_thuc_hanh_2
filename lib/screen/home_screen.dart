import 'package:do_an_thuc_hanh_2/Controller/home_controller.dart';
import 'package:do_an_thuc_hanh_2/screen/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

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
          ProductPopular(),
        ],
      ),
    ));
  }
}

class CategoriesStore extends StatelessWidget {
  CategoriesStore({super.key});

  HomeController categoriesController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    categoriesController.getCategories();
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
                  return Container(
                    // color: Colors.black,
                    width: 150,
                    height: 150,
                    padding: const EdgeInsets.all(5),
                    child: Image.network(
                        categoriesController.categories[index].image),
                  );
                }),
          )
        ]),
      ),
    );
  }
}

class ProductPopular extends StatelessWidget {
  ProductPopular({super.key});

  HomeController productController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    productController.getProducts();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(mainAxisSize: MainAxisSize.max, children: [
        Row(
          children: const [
            Expanded(
                child: Text(
              'Popular Products',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
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

        //show product

        Container(
          child: GridView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              primary: false,
              itemCount: productController.products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.7),
              itemBuilder: (context, index) {
                if (index != null) {
                  return ProductItem(
                    product: productController.products[index],
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
        )

        // end show product
      ]),
    );
  }
}

class ProductItem extends StatelessWidget {
  Product product;

  ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(ProductDetailScreen(product: product));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            product.image,
            fit: BoxFit.fitHeight,
          ),
          Row(
            children: [
              Expanded(
                  child: Text(
                product.title,
                style: TextStyle(color: Colors.black),
              )),
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(2),
                  color: Colors.green,
                ),
                child: Text(
                  product.price.toString(),
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class FavoriteDetail extends StatelessWidget {
  List<Product> products;
  FavoriteDetail({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      child: ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            return ProductItemList(
              product: products[index],
            );
          }),
    ));
  }
}

class ProductItemList extends StatelessWidget {
  Product product;
  ProductItemList({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Row(
          children: [
            SizedBox(
              width: 100,
              height: 100,
              child: Image.asset(
                product.image,
                fit: BoxFit.fitHeight,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
                child: SizedBox(
              height: 100,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.title),
                    Expanded(
                        child: Text(
                      product.description,
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                    ))
                  ]),
            ))
          ],
        ),
      ),
    );
  }
}
