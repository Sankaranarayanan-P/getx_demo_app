import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_demo_app/controller/products/product_controller.dart';
import 'package:getx_demo_app/services/app_exception.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final ProductController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
        title: const Text(
          'Test Data',
          style: TextStyle(
              color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Products',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.deepOrange),
                ),
                Text(
                  'See all',
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey),
                )
              ],
            ),
            Obx(() => controller.productsData.when(initial: () {
                  return const Center(child: Text("No Products Found"));
                }, loading: () {
                  return const Center(child: CircularProgressIndicator());
                }, completed: (productsList) {
                  return Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.75,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                      ),
                      itemCount: productsList.length,
                      itemBuilder: (context, index) {
                        final product = productsList[index];

                        return Card(
                          color: Colors.white,
                          elevation: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.network(product.image ?? "",
                                    height: 100, fit: BoxFit.cover),
                              )),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  product.title ?? "",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  product.description ?? "",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 11),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }, error: (error, exception) {
                  if (exception is ConnectionLostException) {
                    return Column(
                      children: <Widget>[
                        const SizedBox(height: 40.0),
                        Icon(
                          Icons.network_wifi_outlined,
                          color: Colors.red.shade300,
                          size: 40,
                        ),
                        const SizedBox(height: 10.0),
                        Text(exception.message),
                      ],
                    );
                  }
                  return Text(error ?? "Something went wrong");
                })),
          ],
        ),
      ),
    );
  }
}
