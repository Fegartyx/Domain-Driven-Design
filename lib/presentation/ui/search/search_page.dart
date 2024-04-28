import 'package:domain_driven_design/helper/Debouncer.dart';
import 'package:domain_driven_design/infrastructure/datasource/remote/product_remote.dart';
import 'package:domain_driven_design/presentation/widgets/grid_list_products.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final Debouncer debouncer = Debouncer(milliseconds: 1000);
  TextEditingController searchBar = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    child: Icon(Icons.arrow_back),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search here',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                      onChanged: (value) {
                        debouncer.run(() {
                          setState(() {
                            searchBar.text = value;
                          });
                        });
                      },
                    ),
                  ),
                ],
              ),
              if (searchBar.text.isNotEmpty)
                FutureBuilder(
                  future: ProductRemote().getProductByName(searchBar.text),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      if (snapshot.hasData) {
                        return GridListProducts(
                          product: snapshot.data!,
                        );
                      } else {
                        return SizedBox();
                      }
                    }
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
