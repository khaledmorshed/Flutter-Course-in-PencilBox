class CartModel {
  String productId;
  String productName;
  num price;
  int quantity;

  CartModel({
    required this.productId,
    required this.productName,
    required this.price,
    this.quantity = 1});

  Map<String,dynamic> toMap() {
    var map = <String,dynamic>{
      'productId' : productId,
      'productName' : productName,
      'price' : price,
      'quantity' : quantity,
    };
    return map;
  }

  factory CartModel.fromMap(Map<String,dynamic> map) => CartModel(
    productId: map['productId'],
    productName: map['productName'],
    price: map['price'],
    quantity: map['quantity'],
  );
}