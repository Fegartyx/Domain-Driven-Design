import 'package:domain_driven_design/domain/model/product.dart';
import 'package:flutter/material.dart';

class ProductDetail extends StatefulWidget {
  final ProductElement product;
  const ProductDetail({super.key, required this.product});

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Product"),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              "${widget.product.images[0]}",
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: 15,
            ),
            Text("${widget.product.title}"),
            Text("Price: ${widget.product.price}"),
            Text("${widget.product.description}"),
            Text("Category : ${widget.product.category}"),
            Text("Rate : ${widget.product.rating}"),
          ],
        ),
      ),
    );
  }
}
