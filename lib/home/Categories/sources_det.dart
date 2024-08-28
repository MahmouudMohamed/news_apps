import 'package:flutter/material.dart';

import '../../api/api_manager.dart';
import '../../model/SourcesResponse.dart';
import '../../model/category.dart';
import '../tabs/tab_widget.dart';

class CategoryDet extends StatefulWidget {
  Categorys categoryId;
   CategoryDet({required this.categoryId,super.key});

  @override
  State<CategoryDet> createState() => _CategoryDetState();
}

class _CategoryDetState extends State<CategoryDet> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SourcesResponse?>(
      future: ApiManager.getSources(widget.categoryId.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: CircularProgressIndicator(
                color: Colors.green,
              ));
        }
        if (snapshot.hasError) {
          print("object");
          return Center(
            child: Column(
              children: [
                Text("something went wrong"),
                ElevatedButton(onPressed: () {
                  ApiManager.getSources(widget.categoryId.id);
                  setState(() {

                  });
                }, child: Text("Try Again"))
              ],
            ),
          );
        }
        if (snapshot.data!.status == "error") {
          return Center(
            child: Column(
              children: [
                Text("${snapshot.data!.message!}"),
                ElevatedButton(onPressed: () {
                  ApiManager.getSources(widget.categoryId.id);
                  setState(() {

                  });
                }, child: Text("Try Again"))
              ],
            ),
          );
        }
        var sources = snapshot.data!.sources ?? [];
        return TabWidget(sourcesList: sources);
      },
    );
  }
}
