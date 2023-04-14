import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_an_thuc_hanh_2/Controller/order_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:do_an_thuc_hanh_2/model/order.dart' as od;
import 'package:get/get.dart';

class OrderDetailScreen extends StatelessWidget {
  od.Order order;
  String idOrder;
  OrderDetailScreen({required this.idOrder, required this.order, super.key});

  final OrderDetailController controller = Get.put(OrderDetailController());

  @override
  Widget build(BuildContext context) {
    controller.getListProduct(idOrder);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Danh sách sản phẩm có trong hóa đơn này',
                  style: TextStyle(color: Colors.black),
                ),
                Obx(
                  () => ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.listProduct.length,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              controller.listProduct[index].image,
                              fit: BoxFit.fitHeight,
                              width: 100,
                              height: 100,
                            ),
                            Text(
                              controller.listProduct[index].title,
                              style: TextStyle(color: Colors.black),
                            ),
                            const Divider(),
                          ],
                        );
                      }),
                ),
                Text(
                  'số lượng',
                  style: TextStyle(color: Colors.black),
                ),
                Text(
                  order.total.toString(),
                  style: TextStyle(color: Colors.black),
                ),
                Text(
                  'Tổng tiền',
                  style: TextStyle(color: Colors.black),
                ),
                Text(
                  order.money.toString(),
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
