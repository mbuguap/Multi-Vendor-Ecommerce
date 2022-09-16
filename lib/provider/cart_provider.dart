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

  double get totalPrice {
    var total = 0.00;
    for (var item in _list) {
      total += item.price * item.quantity;
    }
    return total;
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

  void increment(Product product) {
    product.increase();
    notifyListeners();
  }

  void decrement(Product product) {
    product.decrease();
    notifyListeners();
  }

  void removeItem(Product product) {
    _list.remove(product);
    notifyListeners();
  }

  void clearCart() {
    _list.clear();

    notifyListeners();
  }
}
