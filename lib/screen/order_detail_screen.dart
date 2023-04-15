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
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Get.back();
              //Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios),
          ),
          title: Text("Danh sách sản phẩm đã đặt"),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.listProduct.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(10),
                                ),
                                Image.network(
                                  controller.listProduct[index].image,
                                  fit: BoxFit.fitHeight,
                                  width: 100,
                                  height: 100,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  controller.listProduct[index].title,
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                            const Divider(
                              color: Colors.black, //color of divider
                              height: 1, //height spacing of divider
                              thickness: 1, //thickness of divier line
                              indent: 25, //spacing at the start of divider
                              endIndent: 25, //spacing at the end of divider
                            ),
                          ],
                        );
                      }),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10),
                          ),
                          Text(
                            'Số lượng \t\t\t\t',
                            style: TextStyle(color: Colors.black, fontSize: 22),
                          ),
                          Text(
                            order.total.toString(),
                            style: TextStyle(color: Colors.black, fontSize: 22),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10),
                          ),
                          Text(
                            'Tổng tiền \t\t\t',
                            style: TextStyle(color: Colors.black, fontSize: 22),
                          ),
                          Text(
                            order.money.toString(),
                            style: TextStyle(color: Colors.black, fontSize: 22),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
