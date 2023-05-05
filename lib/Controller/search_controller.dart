import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_an_thuc_hanh_2/model/product.dart';
import 'package:do_an_thuc_hanh_2/screen/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchController extends SearchDelegate {
  late List<Product> searchTerms = [];
  //

  void getdata() async {
    List<Product> listpro = [];
    await FirebaseFirestore.instance
        .collection('products')
        .get()
        .then((querySnapshot) {
      for (var docSnapShot in querySnapshot.docs) {
        listpro.add(Product.fromSnap(docSnapShot));
      }
    });
    searchTerms = listpro;
  }

  // first overwrite to
  // clear the search text
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  // second overwrite to pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  // third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    List<Product> matchQuery = [];
    for (int i = 0; i < searchTerms.length; i++) {
      if (searchTerms[i].title.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(searchTerms[i]);
      }
    }

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index].title;
        return ListTile(
          onTap: () {
            Get.to(ProductDetailScreen(product: matchQuery[index]));
          },
          title: Text(result),
        );
      },
    );
  }

  // last overwrite to show the
  // querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    getdata();
    List<Product> matchQuery = [];

    for (int i = 0; i < searchTerms.length; i++) {
      if (searchTerms[i].title.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(searchTerms[i]);
      }
    }

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index].title;
        return ListTile(
          onTap: () {
            Get.to(ProductDetailScreen(product: matchQuery[index]));
          },
          title: Text(result),
        );
      },
    );
  }
}
