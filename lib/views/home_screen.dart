import 'package:flutter/material.dart';
import 'package:multi_vendor/views/inner_screens/search_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: InkWell(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              return SearchScreen();
            }));
          },
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(width: 1.6, color: Colors.cyan),
              borderRadius: BorderRadius.circular(
                25,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  Icons.search,
                  color: Colors.grey,
                  size: 30,
                ),
                Text(
                  'What are you looking for ...',
                  style: TextStyle(color: Colors.grey, fontSize: 18),
                ),
                Container(
                  height: 33,
                  width: 74,
                  decoration: BoxDecoration(
                    color: Colors.cyan,
                    borderRadius: BorderRadius.circular(
                      25,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Search',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        elevation: 0,
      ),
    );
  }
}
