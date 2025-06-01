import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'user model.dart';
import 'product_detail.dart';

class ProductInventory extends StatefulWidget {
  @override

  State<ProductInventory> createState() => _ProductInventoryState();
}
class _ProductInventoryState extends State<ProductInventory> {
  final _dbRef = FirebaseDatabase.instance.ref().child('products');
  List<Userss> products = [];

  String selectedCategory = "All Items";

  List<Userss> get filteredProducts {
    if (selectedCategory == "All Items") return products;
    return products.where((product) => product.category == selectedCategory).toList();
  }

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  void fetchProducts() async {
    final snapshot = await _dbRef.get();
    final List<Userss> loaded = [];
    if (snapshot.exists) {
      final data = Map<String, dynamic>.from(snapshot.value as Map);

      data.forEach((key, value) {
        loaded.add(Userss.fromMap(Map<String, dynamic>.from(value)));
      });
    }

    setState(() {
      products = loaded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(title: Text("Book Share",style: TextStyle(color: Colors.white),), centerTitle: true,backgroundColor: Colors.teal,),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children:["All Items",'English', 'Poetry', 'Novel'].map((category) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ChoiceChip(
                      label: Text(category),
                      selected: selectedCategory == category,
                      onSelected: (_) {
                        setState(() {
                          selectedCategory = category;
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Expanded(
            child: products.isEmpty
                ? Center(child: CircularProgressIndicator())
                : GridView.builder(
              padding: EdgeInsets.all(10),
              itemCount: filteredProducts.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                final product = filteredProducts[index];
                //final imageBytes = base64Decode(product.image);

                return
                  InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ProductDetailPage(product: product),
                            ));
                      },
                      child:
                      Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        elevation: 3,
                        child: Column(
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                                child: Image.memory(
                                  base64Decode(product.image),
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(6),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(product.itemname,
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis),
                                  SizedBox(height: 6),
                                  Row(
                                      children: [
                                        Icon(Icons.location_on, size: 16, color: Colors.teal),
                                        Text( "${product.city}"),
                                        SizedBox(width: 4),]),
                                  SizedBox(height: 6),
                                  Row(
                                    children: [
                                      Icon(Icons.add_task, size: 16, color: Colors.teal),
                                      SizedBox(width: 4),
                                      Text("Condition: ${product.condition}", style: TextStyle(fontSize: 12)),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                  );

              },
            ),
          ),

        ],
      ),
    );
  }
}
