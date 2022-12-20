import 'package:flutter/material.dart';


class ProductosModel{
  final String name;
  final String image;
  final Color color;
  final String cantidad;
  final int price;
  int quantity;

  ProductosModel({required this.name, required this.image, required this.color, required this.cantidad, required this.price, this.quantity = 1});
}