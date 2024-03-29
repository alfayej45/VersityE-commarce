import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newecommarce/widgets/fetchProducts.dart';

class Favourite extends StatefulWidget {
  @override
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Wishlist"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            FetchData(collectionName: "users-favourite-items", carts: false)
            // fetchData("users-favourite-items", false),
          ],
        )
      ),
    );
  }
}
