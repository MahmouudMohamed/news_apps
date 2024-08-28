import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:news_app/home/Categories/category_item.dart';
import '../../model/category.dart';

class CategoryFragment extends StatelessWidget {
  CategoryFragment({required this.onCategoryItemClick, super.key});

  var category = Categorys.getCategory();
  Function onCategoryItemClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Pick your category\nof interest",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15,
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () {
                      onCategoryItemClick(category[index]);
                    },
                    child:
                        CategoryItem(category: category[index], index: index));
              },
              itemCount: category.length,
            )
          ],
        ),
      ),
    );
  }
}
