import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flexible_grid_view/flexible_grid_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    return Scaffold(
      body: SingleChildScrollView(
              child: Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w),
          child: TextFormField(
            readOnly: true,
            decoration: InputDecoration(
              fillColor: Colors.white,
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(0)),
                  borderSide: BorderSide(color: Colors.blue)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(0)),
                  borderSide: BorderSide(color: Colors.grey)),
              hintText: "Search products here",
              hintStyle: TextStyle(fontSize: 15.sp),
            ),
            onTap: () => Navigator.push(context,
                CupertinoPageRoute(builder: (_) => SearchScreen())),
          ),
        ),
        SizedBox(
          height: 10.h,
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
        DotsIndicator(
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
        SizedBox(
          height: 15.h,
        ),
        FlexibleGridView(
          axisCount: GridLayoutEnum.twoElementsInRow,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          shrinkWrap: true,
          children: [
            for (var product in _products)
              GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => ProductDetails(product))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 3,


                    child: Column(
                      children: [
                        Container(
                            color: Colors.yellow,
                            child: Image.network(
                              product["product-img"][0],
                              fit: BoxFit.fill,
                              height: 135.h,
                              width: 200.w,
                            )),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "${product["product-name"]}",
                            style: TextStyle(
                                fontSize: 12.sp, fontWeight: FontWeight.w700),
                          ),
                        ),
                        Text("${product["product-price"].toString()}"),
                      ],
                    ),
                  ),
                ),
              )
          ],
        ),
      ],
              ),
            ),
    );
  }
}
