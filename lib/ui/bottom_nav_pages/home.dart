import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flexible_grid_view/flexible_grid_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:newecommarce/const/AppColors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../product_details_screen.dart';
import '../search_screen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> _carouselImages = [];
  var _dotPosition = 0;
  List _products = [];
  var _firestoreInstance = FirebaseFirestore.instance;
  List<String> categories = [
    'asset/images/1.png',
    'asset/images/2.png',
    'asset/images/3.png',
    'asset/images/4.png',
    'asset/images/5.png',
  ];
  fetchCarouselImages() async {
    QuerySnapshot qn =
        await _firestoreInstance.collection("carousel-slider").get();
    print(qn.docs.length);
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _carouselImages.add(
          qn.docs[i]["img-path"],
        );
      }
    });

    return qn.docs;
  }

  fetchProducts() async {
    QuerySnapshot qn = await _firestoreInstance.collection("products").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _products.add({
          "product-name": qn.docs[i]["product-name"],
          "product-description": qn.docs[i]["product-description"],
          "product-price": qn.docs[i]["product-price"],
          "product-img": qn.docs[i]["product-img"],
        });
      }
    });

    return qn.docs;
  }

  @override
  void initState() {
    fetchCarouselImages();
    fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h,),
          Padding(
            padding: const EdgeInsets.only(left: 10,right: 10),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10,right: 10),
                    child: Container(
                      height: 50,
                      child: TextFormField(
                         readOnly: true,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                              borderSide: BorderSide(color: Colors.blue)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                              borderSide: BorderSide(color: Colors.grey)),
                          hintText: "Search products here",
                          hintStyle: TextStyle(fontSize: 15.sp),
                        ),
                        onTap: () => Navigator.push(context,
                            CupertinoPageRoute(builder: (_) => SearchScreen())),
                      ),
                    ),
                  ),

                ),
                CircleAvatar(
                  child: Center(
                    child: Icon(Icons.filter_alt),

                  ),
                ),
              ],
            ),
          ),
              SizedBox(
                height: 20.h,
              ),
              AspectRatio(
                aspectRatio: 3.2,
                child: CarouselSlider(
                    items: _carouselImages
                        .map((item) => Padding(
                              padding: const EdgeInsets.only(left: 3, right: 3),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        image: NetworkImage(item),
                                        fit: BoxFit.fill)),
                              ),
                            ))
                        .toList(),
                    options: CarouselOptions(
                        autoPlay: false,
                        enlargeCenterPage: true,
                        viewportFraction: 0.8,
                        enlargeStrategy: CenterPageEnlargeStrategy.height,
                        onPageChanged: (val, carouselPageChangedReason) {
                          setState(() {
                            _dotPosition = val;
                          });
                        })),
              ),
              SizedBox(
                height: 10.h,
              ),
              Align(
                alignment:Alignment.center,
                child: DotsIndicator(
                  dotsCount:
                      _carouselImages.length == 0 ? 1 : _carouselImages.length,
                  position: _dotPosition,
                  decorator: DotsDecorator(
                    activeColor: AppColors.deep_orange,
                    color: AppColors.deep_orange.withOpacity(0.5),
                    spacing: EdgeInsets.all(2),
                    activeSize: Size(8, 8),
                    size: Size(6, 6),
                  ),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text('Categories',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
              ),
              SizedBox(
                height: 13.h,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: SizedBox(
                  height: 80,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    shrinkWrap: true,
                    primary: false,
                    itemBuilder: (_, index) {
                      return Container(
                        margin: const EdgeInsets.only(right: 10),
                        width: 80,
                        decoration: BoxDecoration(
                          color: Color(0xFFF2F2F2),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: Colors.black.withOpacity(.1),
                            width: 2,
                          ),
                        ),
                        child: Image.asset(categories[index]),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: _products.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 15,
                      childAspectRatio: .85
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return
                      GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ProductDetails(_products[index]))),
                        child: Container(

                          decoration: BoxDecoration(
                            color: Color(0xFFF2F2F2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Stack(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(child: ClipRRect(
                                        borderRadius: BorderRadius.horizontal(
                                          left: Radius.circular(8),
                                          right: Radius.circular(8),
                                        ),
                                          child: Image.network(_products[index]["product-img"][0], height: 140.h,fit: BoxFit.fill,))),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                    child: Text(
                                      '${_products[index]["product-name"]}',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style:  TextStyle(

                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 5,),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '\$${_products[index]["product-price"]}',
                                          style:  TextStyle(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          '\$550',
                                          style: TextStyle(
                                            fontSize: 17.sp,
                                            color: Colors.black.withOpacity(.5),
                                            fontWeight: FontWeight.w600,
                                            decoration:
                                            TextDecoration.lineThrough,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 20,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(60),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '50% Discount',
                                        style: TextStyle(fontSize: 10),
                                      ),
                                    ),
                                  ),
                                  StreamBuilder(
                                    stream: FirebaseFirestore.instance.collection("users-favourite-items").doc(FirebaseAuth.instance.currentUser!.email)
                                        .collection("items").where("name",isEqualTo: _products[index]["product-name"]).snapshots(),
                                    builder: (BuildContext context, AsyncSnapshot snapshots){
                                      if(snapshots.data==null){
                                        return Text("");
                                      }
                                      print( snapshots.data.docs.length);
                                      return Padding(
                                        padding: const EdgeInsets.only(right: 8),
                                        child: CircleAvatar(
                                          backgroundColor: Colors.red,
                                          child: IconButton(
                                            onPressed: () => snapshots.data.docs.length==0?addToFavourite(
                                                _products[index]["product-name"],
                                                _products[index]["product-price"].toString(),
                                                _products[index]["product-img"][0]
                                            ):deleteFavourite(snapshots.data.docs[0]["doc"]),
                                            icon: snapshots.data.docs.length==0? Icon(
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
                                  // InkWell(
                                  //   onTap: (){
                                  //     snapshot.data.docs.length==0?addToFavourite():print("Already Added")
                                  //   },
                                  //   child: Container(
                                  //     height: 30,
                                  //     width: 30,
                                  //     decoration: BoxDecoration(
                                  //       border: Border.all(
                                  //         color: Colors.black.withOpacity(.5),
                                  //       ),
                                  //       shape: BoxShape.circle,
                                  //     ),
                                  //     child: Center(
                                  //       child: Icon(
                                  //         Icons.favorite_border,
                                  //         size: 20,
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                  },
                  // children: [
                  //   for (var product in _products)
                  //
                  // ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future addToFavourite(String productname,String price,String image) async {

    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection("users-favourite-items");
    var id = DateTime.now().millisecondsSinceEpoch;
    return _collectionRef
        .doc(currentUser!.email)
        .collection("items")
        .doc(id.toString())
        .set({
      "name": productname,
      "price":price,
      "images": image,
      "doc":id.toString(),
    }).then((value) => print("Added to favourite"));
  }
  Future deleteFavourite(String doc) async {

    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection("users-favourite-items");
    return _collectionRef
        .doc(currentUser!.email)
        .collection("items")
        .doc(doc).delete() .then((value) => print("Added to favourite"));
  }
}
