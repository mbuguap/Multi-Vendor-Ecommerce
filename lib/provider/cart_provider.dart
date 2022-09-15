import 'package:flutter/cupertino.dart';
import 'package:multi_vendor/model/product_model.dart';

class CartProvider extends ChangeNotifier {
  final List<Product> _list = [];

  List<Product> get getItems {
    return _list;
  }

  int? get count {
    return _list.length;
  }

  void addItem(String name, double price, int quantity, List imagesUrl,
      int instock, String documentId, String sellerUid) {
    final product = Product(
        name: name,
        price: price,
        quantity: quantity,
        instock: instock,
        imagesUrl: imagesUrl,
        documentId: documentId,
        sellerUid: sellerUid);

    _list.add(product);
    notifyListeners();
  }
}
