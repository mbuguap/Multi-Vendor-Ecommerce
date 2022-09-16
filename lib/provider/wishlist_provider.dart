import 'package:flutter/cupertino.dart';
import 'package:multi_vendor/model/product_model.dart';

class WishListProvider extends ChangeNotifier {
  final List<Product> _list = [];

  List<Product> get getWishItems {
    return _list;
  }

  int? get count {
    return _list.length;
  }

  void addWishItem(String name, double price, int quantity, List imagesUrl,
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

  void removeWishItem(Product product) {
    _list.remove(product);
    notifyListeners();
  }

  void clearWish() {
    _list.clear();

    notifyListeners();
  }

  void removeWish(String id) {
    _list.removeWhere((element) => element.documentId == id);
    notifyListeners();
  }
}
