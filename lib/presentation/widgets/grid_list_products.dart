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
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          final data = product.products[index];
          if (index + 1 < product.products.length) {
            return Card(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Column(
                children: [
                  ClipRRect(
                    child: Image.network(
                      "${data.images[0]}",
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  SizedBox(
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
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
