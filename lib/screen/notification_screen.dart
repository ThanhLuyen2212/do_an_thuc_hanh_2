import 'package:do_an_thuc_hanh_2/Controller/nofication_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
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
                    itemCount: controller.orderList.length,
                    itemBuilder: (context, index) {
                      var orderlist = controller.orderList;
                      if (index % 2 == 0) var bgcolor = Colors.black;
                      return Container(
                        color: Colors.red,
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.all(5),
                        height: 75,
                        child: Column(
                          children: [
                            Text(
                              'Đơn hàng thứ $index',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'Ngay đặt hàng',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                              textAlign: TextAlign.center,
                            ),
                            Text('Trang thai $orderlist[index].')
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
