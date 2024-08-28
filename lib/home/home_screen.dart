import 'package:flutter/material.dart';
import 'package:news_app/home/Categories/sources_det.dart';
import 'package:news_app/home/Categories/category_fragment.dart';
import 'package:news_app/home/search_tab.dart';
import 'package:news_app/home/setting/settings.dart';
import 'package:news_app/model/category.dart';

import 'drawer/home_drawer.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "home";
  static Categorys? selectedCategory;

  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage("assets/images/pattern.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        drawer: Drawer(
          child: HomeDrawer(
            onDrawerClick: onDrawerClick,
          ),
        ),
        appBar: AppBar(
          title: Text(
            selectedDrawer == HomeDrawer.settingId
                ? "Settings"
                : HomeScreen.selectedCategory == null
                    ? "News App"
                    : HomeScreen.selectedCategory!.title,
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
          actions: [
            selectedDrawer == HomeDrawer.settingId
                ? SizedBox()
                : IconButton(
                    onPressed: () {
                      showSearch(context: context, delegate: SearchTab());
                    },
                    icon: Icon(
                      Icons.search_rounded,
                      size: 30,
                    ),
                  )
          ],
        ),
        body: selectedDrawer == HomeDrawer.settingId
            ? Settings()
            : HomeScreen.selectedCategory == null
                ? CategoryFragment(onCategoryItemClick: onCategoryItemClick)
                : CategoryDet(
                    categoryId: HomeScreen.selectedCategory!,
                  ),
      ),
    );
  }

  int selectedDrawer = HomeDrawer.cateId;

  void onCategoryItemClick(Categorys category) {
    HomeScreen.selectedCategory = category;
    setState(() {});
  }

  void onDrawerClick(int id) {
    selectedDrawer = id;
    HomeScreen.selectedCategory = null;
    Navigator.pop(context);
    setState(() {});
  }
}
