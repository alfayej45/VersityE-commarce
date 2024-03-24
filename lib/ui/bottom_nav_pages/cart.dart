
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newecommarce/widgets/fetchProducts.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Carts"),
      ),
      body: SafeArea(
          child: Column(
            children: [
              FetchData(collectionName:"users-cart-items", carts:true)
              //fetchData("users-cart-items",true),
            ],
          )
      ),
    );
  }
}
