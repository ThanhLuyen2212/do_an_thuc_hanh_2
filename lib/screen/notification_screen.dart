import 'package:do_an_thuc_hanh_2/Controller/nofication_controller.dart';
import 'package:do_an_thuc_hanh_2/model/order.dart' as order;
import 'package:do_an_thuc_hanh_2/screen/order_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});

  NotificationController controller = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    controller.getOrderList();
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 500,
        child: Column(
          children: [
            const Text(
              'Danh sách đơn đặt hàng hàng',
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),
            Expanded(
              child: Obx(
                () => ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(10),
                    itemCount: controller.orderList.length,
                    itemBuilder: (context, index) {
                      List<order.Order> orderlist = controller.orderList;
                      var bgcolor = Colors.white;
                      if (index % 2 == 0)
                        bgcolor = Colors.white;
                      else
                        bgcolor = Colors.black12;
                      return InkWell(
                        onTap: () {
                          Get.to(OrderDetailScreen(
                            order: orderlist[index],
                            idOrder: orderlist[index].idOrder,
                          ));
                        },
                        child: Container(
                          color: bgcolor,
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.all(5),
                          height: 185,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Text(
                                  'Đơn hàng thứ $index',
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 18),
                                  textAlign: TextAlign.center,
                                ),
                                const Text(
                                  'Ngay đặt hàng',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  orderlist[index].createOnDate.toString(),
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 15),
                                  textAlign: TextAlign.center,
                                ),
                                const Text(
                                  'Trang thái',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  orderlist[index].status,
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 15),
                                  textAlign: TextAlign.center,
                                ),
                                const Text(
                                  'Số lượng hàng',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  orderlist[index].total.toString(),
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 15),
                                  textAlign: TextAlign.center,
                                ),
                                const Text(
                                  'Tổng tiền',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  orderlist[index].money.toString(),
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 15),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
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
