import 'package:domain_driven_design/domain/model/product.dart';
import 'package:flutter/material.dart';

class GridListProducts extends StatelessWidget {
  final Product product;
  const GridListProducts({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        itemCount: product.products.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              children: [
                ClipRRect(
                  child: Image.network(
                    "https://cdn.dummyjson.com/product-images/1/1.jpg",
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
                      Text('iPhone 9'),
                      Text(
                        "An apple mobile which is nothing like apple ashajkshajkshajkshkuajhsjkh asdkiajskjashbdjkbasjkdbjk asjkdbjkasbdjkabsjkd",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      Text("Price: 549"),
                      Text("Category: smartphones"),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
