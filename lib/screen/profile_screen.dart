import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_an_thuc_hanh_2/Controller/profile_controller.dart';
import 'package:do_an_thuc_hanh_2/model/myUser.dart';
import 'package:do_an_thuc_hanh_2/screen/login_screen.dart';
import 'package:do_an_thuc_hanh_2/screen/product_detail_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/product.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    profileController.getInfo();
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: context.height - 146,
        color: Colors.white,
        child: Expanded(
          child: SingleChildScrollView(
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipOval(
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl:
                          'https://i.pinimg.com/originals/46/cd/d8/46cdd82cb16aa9a964717f4099a7bbf2.jpg',
                      height: 100,
                      width: 100,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 140,
                    height: 47,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                    ),
                    child: Center(
                        child: InkWell(
                      onTap: () {
                        Get.offAll(() => LoginScreen());
                      },
                      child: const Text(
                        'Sign out',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    )),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const ThongTinCaNhan(),
              const NhungSanPhamDaMua(),
            ]),
          ),
        ),
      ),
    );
  }
}

class ThongTinCaNhan extends StatefulWidget {
  const ThongTinCaNhan({super.key});

  @override
  State<ThongTinCaNhan> createState() => _ThongTinCaNhanState();
}

class _ThongTinCaNhanState extends State<ThongTinCaNhan> {
  bool thongtincanhan = false;
  int a = 1;
  final nameEditController = TextEditingController();
  final emailEditController = TextEditingController();
  final oldPasswordEditController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPassowrdController = TextEditingController();

  ProfileController controller = Get.put(ProfileController());

  void init() async {
    var user = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    myUser myinfo = myUser.fromSnap(user);

    nameEditController.text = myinfo.name;
    emailEditController.text = myinfo.email;
  }

  @override
  Widget build(BuildContext context) {
    init();
    return Container(
      margin: const EdgeInsets.all(10),
      child: Expanded(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      thongtincanhan = !thongtincanhan;
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Thông tin khách hàng',
                          style: TextStyle(color: Colors.black, fontSize: 18)),
                      Icon(
                        thongtincanhan
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                Visibility(
                    visible: thongtincanhan,
                    child: Column(
                      children: [
                        Form(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text('Họ tên',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16)),
                                const SizedBox(
                                  height: 5,
                                ),
                                nameTextFormField(),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text('Eamil',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16)),
                                const SizedBox(
                                  height: 5,
                                ),
                                emailTextFormField(),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text('Nhập lại mật khẩu cũ',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16)),
                                const SizedBox(
                                  height: 5,
                                ),
                                oldPasswordTextFormField(),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text('Nhập mật khẩu mới',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16)),
                                const SizedBox(
                                  height: 5,
                                ),
                                newPasswordTextFormField(),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text('Nhập lại mật khẩu mới',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16)),
                                const SizedBox(
                                  height: 5,
                                ),
                                confirmPassordTextFormField(),
                                const SizedBox(
                                  height: 30,
                                ),
                                SizedBox(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    child: const Text(
                                      "Update",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextFormField nameTextFormField() {
    return TextFormField(
      controller: nameEditController,
      //keyboardType: TextInputType.emailAddress,
      style: TextStyle(color: Colors.black),
      decoration: const InputDecoration(
          enabledBorder: OutlineInputBorder(),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.person_outline)),
    );
  }

  TextFormField emailTextFormField() {
    return TextFormField(
      controller: emailEditController,
      style: TextStyle(color: Colors.black),
      decoration: const InputDecoration(
          enabledBorder: OutlineInputBorder(),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.email_outlined)),
    );
  }

  TextFormField oldPasswordTextFormField() {
    return TextFormField(
      controller: oldPasswordEditController,
      //keyboardType: TextInputType.emailAddress,
      style: TextStyle(color: Colors.black),

      decoration: const InputDecoration(
          enabledBorder: OutlineInputBorder(),
          hintText: "Old password",
          hintStyle: TextStyle(color: Colors.black38),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.password_outlined)),
    );
  }

  TextFormField newPasswordTextFormField() {
    return TextFormField(
      controller: newPasswordController,
      //keyboardType: TextInputType.emailAddress,
      style: TextStyle(color: Colors.black),
      decoration: const InputDecoration(
          enabledBorder: OutlineInputBorder(),
          hintText: "New password",
          hintStyle: TextStyle(color: Colors.black38),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.password_outlined)),
    );
  }

  TextFormField confirmPassordTextFormField() {
    return TextFormField(
      controller: confirmPassowrdController,
      //keyboardType: TextInputType.emailAddress,
      style: TextStyle(color: Colors.black),
      decoration: const InputDecoration(
          enabledBorder: OutlineInputBorder(),
          hintText: "Confirm your password",
          hintStyle: TextStyle(color: Colors.black38),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.password_outlined)),
    );
  }
}

class NhungSanPhamDaMua extends StatefulWidget {
  const NhungSanPhamDaMua({super.key});

  @override
  State<NhungSanPhamDaMua> createState() => _NhungSanPhamDaMuaState();
}

class _NhungSanPhamDaMuaState extends State<NhungSanPhamDaMua> {
  ProfileController profileController = Get.put(ProfileController());

  bool show = false;
  @override
  Widget build(BuildContext context) {
    profileController.getPurchaseProducts();
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                show = !show;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Nhứng sản phẩm đã mua',
                    style: TextStyle(color: Colors.black, fontSize: 18)),
                Icon(
                  show ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  color: Colors.black,
                ),
              ],
            ),
          ),
          Visibility(
            visible: show,
            child: GridView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                primary: false,
                itemCount: profileController.purchaseProducts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.7),
                itemBuilder: (context, index) {
                  if (index != null) {
                    return ProductItem(
                      product: profileController.purchaseProducts[index],
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
          ),
        ],
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  Product product;

  ProductItem({super.key, required this.product});

  ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () {
      //   Get.to(ProductDetailScreen(product: product));
      // },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              Get.to(() => ProductDetailScreen(product: product));
            },
            child: Image.network(
              product.image,
              fit: BoxFit.fitHeight,
              width: 100,
              height: 100,
            ),
          ),
          Text(
            product.title,
            style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.normal,
                fontSize: 16),
          ),
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
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
