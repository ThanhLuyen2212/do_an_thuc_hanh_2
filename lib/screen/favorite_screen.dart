import 'package:do_an_thuc_hanh_2/Controller/auth_controller.dart';
import 'package:do_an_thuc_hanh_2/Controller/favorite_controller.dart';
import 'package:do_an_thuc_hanh_2/screen/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoriteScreen extends StatelessWidget {
  FavoriteScreen({super.key});

  final FavoriteController listLikeProduct = Get.put(FavoriteController());

  @override
  Widget build(BuildContext context) {
    listLikeProduct.init(AuthController.instance.user.uid);
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: context.height - 146,
        child: Column(
          children: [
            const Text(
              'Danh sách sản phẩm yêu thích',
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),
            Expanded(
              child: Obx(
                () => ListView.builder(
                    shrinkWrap: true,
                    itemCount: listLikeProduct.listLikeProducts.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.all(5),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Get.to(() => ProductDetailScreen(
                                    product: listLikeProduct
                                        .listLikeProducts[index]));
                              },
                              child: Row(
                                children: [
                                  Image.network(
                                    listLikeProduct
                                        .listLikeProducts[index].image,
                                    height: 75,
                                    alignment: Alignment.center,
                                  ),
                                  Text(
                                    listLikeProduct
                                        .listLikeProducts[index].title,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              color: Colors.black, //color of divider
                              height: 1, //height spacing of divider
                              thickness: 1, //thickness of divier line
                              indent: 10, //spacing at the start of divider
                              endIndent: 10, //spacing at the end of divider
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
