import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:newecommarce/const/AppColors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetails extends StatefulWidget {
  var _product;
  ProductDetails(this._product);
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
var qty = 1;
  Future addToCart() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("users-cart-items");
    var id = DateTime.now().microsecondsSinceEpoch;
    return _collectionRef
        .doc(currentUser!.email)
        .collection("items")
        .doc(id.toString())
        .set({
      "name": widget._product["product-name"],
      "price": widget._product["product-price"],
      "images": widget._product["product-img"],
      "qty": qty,
      "doc":id.toString()
    }).then((value) => print("Added to cart"));
  }

  Future addToFavourite() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection("users-favourite-items");
    return _collectionRef
        .doc(currentUser!.email)
        .collection("items")
        .doc()
        .set({
      "name": widget._product["product-name"],
      "price": widget._product["product-price"],
      "images": widget._product["product-img"],
    }).then((value) => print("Added to favourite"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: AppColors.deep_orange,
            child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )),
          ),
        ),
        actions: [
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection("users-favourite-items").doc(FirebaseAuth.instance.currentUser!.email)
                .collection("items").where("name",isEqualTo: widget._product['product-name']).snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot){
              if(snapshot.data==null){
                return Text("");
              }
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: CircleAvatar(
                  backgroundColor: Colors.red,
                  child: IconButton(
                    onPressed: () => snapshot.data.docs.length==0?addToFavourite():print("Already Added"),
                    icon: snapshot.data.docs.length==0? Icon(
                      Icons.favorite_outline,
                      color: Colors.white,
                    ):Icon(
                      Icons.favorite,
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            },

          ),
        ],
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarouselSlider(
                    items: widget._product['product-img']
                        .map<Widget>((item) => Padding(
                      padding: const EdgeInsets.only(left: 3, right: 3),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),

                            image: DecorationImage(
                                image: NetworkImage(item),
                                fit: BoxFit.fitWidth)),
                      ),
                    ))
                        .toList(),
                    options: CarouselOptions(
                        autoPlay: false,
                        enlargeCenterPage: true,
                        viewportFraction: 0.8,
                        enlargeStrategy: CenterPageEnlargeStrategy.height,
                        onPageChanged: (val, carouselPageChangedReason) {
                          setState(() {});
                        })),
                const Text(
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Row(
                  children: [
                    Text(
                      "BTD ${widget._product['product-price'].toString()}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize:24, color: Colors.red),
                    ),
                    Row(
                      children: [

                        IconButton(
                            style: IconButton.styleFrom(
                                backgroundColor: Colors.black
                            ),
                            onPressed: (){
                        if(qty != 1){
                          qty--;
                          setState(() {
                          });
                        }
                        }, icon: const Icon(Icons.remove, color:Colors.white ,)),

                        Text(qty.toString()),
                        IconButton(
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.black
                            ),
                            onPressed: (){
                          qty++;
                          setState(() {

                          });
                        }, icon: const Icon(Icons.add, color: Colors.white,))
                      ],
                    )
                  ],
                ),
                const Text('Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in'),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),

            SizedBox(
              width: 1.sw,
              height: 56.h,
              child: ElevatedButton(
                onPressed: () {
                  addToCart();
                  Fluttertoast.showToast(
                      msg: "Add to Cart Successfull",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0
                  );
                },
                child: Text(
                  "Add to cart",
                  style: TextStyle(color: Colors.white, fontSize: 18.sp),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.deep_orange,
                  elevation: 3,
                ),
              ),
            ),
            SizedBox(height: 20,)
          ],
        ),
      )),
    );
  }
}
