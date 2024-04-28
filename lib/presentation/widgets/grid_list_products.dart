import 'package:domain_driven_design/domain/model/product.dart';
import 'package:flutter/material.dart';

class GridListProducts extends StatelessWidget {
  final Product product;
  final ScrollController controller = ScrollController();
  final Function(int)? onDataReceived;
  GridListProducts({super.key, required this.product, this.onDataReceived});

  @override
  Widget build(BuildContext context) {
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        debugPrint(controller.position.maxScrollExtent.toString());
        debugPrint(controller.offset.toString());
        onDataReceived!(product.limit + 10);
      }
    });
    return Expanded(
      child: GridView.builder(
        controller: controller,
        itemCount: product.products.length,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 400,
          childAspectRatio: 4 / 5,
        ),
        itemBuilder: (context, index) {
          final data = product.products[index];
          if (index < product.products.length + 1) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    child: Image.network(
                      scale: 2.5,
                      "${data.images[0]}",
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${data.title}'),
                        Text(
                          "${data.description}",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        Text("Price: ${data.price}"),
                        Text("Category: ${data.category}"),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            if (product.products.length < product.limit) {
              return Text("No More Data To Load");
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }
        },
      ),
    );
  }
}
