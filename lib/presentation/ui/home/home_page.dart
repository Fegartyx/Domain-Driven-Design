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
  final listChoices = [
    'Smartphone',
    'Wifi',
  ];
  var idSelected = 0;

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
            Wrap(
              children: [
                ...listChoices.map(
                  (e) => ChoiceChip(
                    label: Text(e),
                    selected: idSelected == listChoices.indexOf(e),
                    onSelected: (value) {
                      setState(() {
                        idSelected = listChoices.indexOf(e);
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            GridListProducts(),
          ],
        ),
      ),
    );
  }
}
