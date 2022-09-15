class Product {
  String name;
  double price;
  int quantity;
  int instock;
  List imagesUrl;
  String documentId;
  String sellerUid;

  Product(
      {required this.name,
      required this.price,
      required this.quantity,
      required this.instock,
      required this.imagesUrl,
      required this.documentId,
      required this.sellerUid});
}
