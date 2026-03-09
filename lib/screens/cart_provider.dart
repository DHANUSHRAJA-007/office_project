import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  List<Map<String, dynamic>> cartItems = [];

  void addToCart(Map<String, dynamic> product) {
    cartItems.add(product);
    notifyListeners();
  }

  void removeItem(int index) {
  cartItems.removeAt(index);
  notifyListeners();
}
}
