import 'package:flutter/material.dart';

import '../widgets/category_item.dart';
import '../data/categories_dummy_data.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // as TabScreen has own scafold and app bar so have to romeve for handling duplication
    // return Scaffold(
    //   appBar: AppBar(title: const Text('DeliMeal')),
    //   body:
    return Container(
      child: GridView(
        padding: const EdgeInsets.all(10),
        children: DUMMY_CATEGORIES
            .map((categoryData) => CategoryItem(
                  categoryData.id,
                  categoryData.title,
                  categoryData.color,
                ))
            .toList(),
        // auto scoll have(Sliver), Identify how many columns can be into screen in grid
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 5 / 3,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15),
      ),
    );
  }
}
