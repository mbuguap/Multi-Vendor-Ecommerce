import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<String> title = [
    'My Store',
    'Orders',
    'Edit Profile',
    'Manage Products',
    'Balance',
    'Statistics'
  ];

  List<IconData> icon = [
    Icons.store,
    Icons.shop_2_outlined,
    Icons.edit,
    Icons.settings,
    Icons.attach_money,
    Icons.show_chart,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Dashboard',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.logout,
                color: Colors.cyan,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          children: List.generate(6, (index) {
            return Card(
              elevation: 15,
              color: Colors.blueGrey.withOpacity(0.8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(
                    icon[index],
                    size: 40,
                    color: Colors.cyan,
                  ),
                  Text(
                    title[index],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
