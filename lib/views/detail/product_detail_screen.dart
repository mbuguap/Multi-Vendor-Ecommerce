import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

class ProductDetailScreen extends StatelessWidget {
  final dynamic productList;

  const ProductDetailScreen({super.key, required this.productList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.45,
            child: Swiper(
              itemCount: 1,
              pagination: SwiperPagination(builder: SwiperPagination.dots),
              itemBuilder: (context, index) {
                return Image.network(
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/1200px-Image_created_with_a_mobile_phone.png');
              },
            ),
          ),
        ],
      ),
    );
  }
}
