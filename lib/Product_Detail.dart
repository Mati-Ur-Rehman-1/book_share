import 'dart:convert';
import 'package:flutter/material.dart';
import 'user model.dart';

class ProductDetailPage extends StatelessWidget {
  final Userss product;

  ProductDetailPage({required this.product});

  @override
  Widget build(BuildContext context) {
    final image = base64Decode(product.image);

    return Scaffold(
      appBar: AppBar(
        title: Text("Product Details", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border, color: Colors.white),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Added to Favourites")),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Chat feature coming soon!")),
          );
        },
        icon: Icon(Icons.chat, color: Colors.white,),
        label: Text("Chat", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          Image.memory(
            image,
            fit: BoxFit.cover,
            width: double.infinity,
            height: 250,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Title & Price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          product.itemname,
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),

                  /// Location & Condition
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 20, color: Colors.grey),
                      SizedBox(width: 4),
                      Text(
                        product.city,
                        style: TextStyle(fontSize: 16),
                      ),
                      Spacer(),
                      Text(
                        "Condition: ${product.condition}/10",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Divider(height: 30, thickness: 1),

                  /// Description
                  Text(
                    "Description",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    product.descripton,
                    style: TextStyle(fontSize: 16, height: 1.5),
                  ),
                  SizedBox(height: 30),

                  /// Buy or Borrow Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.shopping_cart, color: Colors.white,),
                        label: Text("Buy Now" , style: TextStyle(color: Colors.white),),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                          textStyle: TextStyle(fontSize: 16),
                        ),
                      ),
                      SizedBox(width: 16),
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.book_outlined, color: Colors.white,),
                        label: Text("Borrow", style: TextStyle(color: Colors.white),),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                          textStyle: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
