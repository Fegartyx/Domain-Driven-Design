import 'package:domain_driven_design/infrastructure/datasource/remote/category_remote.dart';
import 'package:domain_driven_design/infrastructure/datasource/remote/product_remote.dart';
import 'package:domain_driven_design/presentation/widgets/grid_list_products.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final listChoices = ['All', 'Mobile', 'Laptop', 'Tablet', 'TV'];
  String? choice;
  int? idSelected;
  final ScrollController controller = ScrollController();
  int? limit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // controller.addListener(() {
    //   if (controller.position.maxScrollExtent == controller.offset) {
    //     debugPrint(controller.position.maxScrollExtent.toString());
    //     debugPrint(controller.offset.toString());
    //     setState(() {
    //       limit = limit! + 10;
    //     });
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Domain Driven Design'),
        actions: [
          InkWell(
            child: Icon(Icons.search),
            onTap: () {
              Navigator.of(context).pushNamed('/search');
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder(
              future: CategoryRemote().getCategory(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (snapshot.hasData) {
                    final listData = snapshot.data?.categories ?? listChoices;
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Wrap(
                        children: [
                          ...listData.map(
                            (e) => Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: ChoiceChip(
                                label: Text(e),
                                selected: idSelected == listData.indexOf(e),
                                onSelected: (value) {
                                  setState(() {
                                    if (idSelected == listData.indexOf(e)) {
                                      idSelected = null;
                                      choice = null;
                                    } else {
                                      idSelected = listData.indexOf(e);
                                      choice = e;
                                    }
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return SizedBox();
                  }
                }
              },
            ),
            SizedBox(height: 10),
            if (choice == null) ...[
              FutureBuilder(
                future: ProductRemote().getProducts(limit),
                builder: (context, snapshot) {
                  debugPrint("Data: ${snapshot.data?.products.length}");
                  debugPrint("Limit: $limit");
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (snapshot.hasData) {
                      return GridListProducts(
                        onDataReceived: (p0) {
                          setState(() {
                            limit = p0;
                          });
                        },
                        product: snapshot.data!,
                      );
                    } else {
                      return SizedBox();
                    }
                  }
                },
              ),
            ] else ...[
              FutureBuilder(
                future: ProductRemote().getProductByCategory(choice!),
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
              )
            ]
          ],
        ),
      ),
    );
  }
}
