import 'package:flutter/material.dart';
import 'package:multi_vendor/views/categories/men_category_screen.dart';

class CategoryScreen extends StatefulWidget {
  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final PageController _pageController = PageController();
  List<ItemData> _item = [
    ItemData(categoryName: 'Men'),
    ItemData(categoryName: 'Women'),
    ItemData(categoryName: 'Shoes'),
    ItemData(categoryName: 'Kids'),
    ItemData(categoryName: 'Bag'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width * 0.2,
              // color: Colors.grey.shade300,
              child: ListView.builder(
                  itemCount: _item.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        // for (var element in _item) {
                        //   element.isSelected = false;
                        // }
                        // setState(() {
                        //   _item[index].isSelected = true;
                        // });
                        _pageController.jumpToPage(index);
                      },
                      child: Container(
                        color: _item[index].isSelected == true
                            ? Colors.white
                            : Colors.grey.shade300,
                        height: 100,
                        child: Center(
                          child: Text(_item[index].categoryName),
                        ),
                      ),
                    );
                  }),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width * 0.8,
              color: Colors.white,
              child: PageView(
                controller: _pageController,
                onPageChanged: (value) {
                  for (var element in _item) {
                    element.isSelected = false;
                  }
                  setState(() {
                    _item[value].isSelected = true;
                  });
                },
                scrollDirection: Axis.vertical,
                children: [
                  MenCategoryScreen(),
                  Center(
                    child: Text('Women'),
                  ),
                  Center(
                    child: Text('Shoes'),
                  ),
                  Center(
                    child: Text('Kids'),
                  ),
                  Center(
                    child: Text('Bag'),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ItemData {
  String categoryName;
  bool isSelected;

  ItemData({required this.categoryName, this.isSelected = false});
}
