import 'package:flutter/material.dart';
import 'package:news_app/home/news/news_widget.dart';
import 'package:news_app/home/tabs/tab_item.dart';
import '../../model/SourcesResponse.dart';
class TabWidget extends StatefulWidget {
  TabWidget({required this.sourcesList, super.key});

  List<Source> sourcesList;

  @override
  State<TabWidget> createState() => _TabWidgetState();
}

class _TabWidgetState extends State<TabWidget> {
  int selectedindex=0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: widget.sourcesList.length,
        child: Column(
          children: [
            TabBar(
              onTap: (value) {
                selectedindex=value;
                setState(() {

                });
              },
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                indicatorColor: Colors.transparent,
                dividerColor: Colors.transparent,
                tabs: widget.sourcesList
                    .map((e) => TabItem(
                          source: e,
                          isSelected: selectedindex==widget.sourcesList.indexOf(e),
                        ))
                    .toList()),
            Expanded(child: NewsWidget(source: widget.sourcesList[selectedindex]))

          ],

        ));
  }
}
