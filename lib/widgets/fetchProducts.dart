import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'CartWidget.dart';

class FetchData extends StatefulWidget {
 final String? collectionName;
 bool carts;
   FetchData({Key? key,required this.collectionName,required this.carts}) : super(key: key);

  @override
  State<FetchData> createState() => _State();
}

class _State extends State<FetchData> {
  var qty = 1;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection(widget.collectionName!)
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection("items")
          .snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("Something is wrong"),
          );
        }

        return ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount: snapshot.data == null ? 0 : snapshot.data!.docs.length,
            itemBuilder: (_, index) {
              DocumentSnapshot _documentSnapshot = snapshot.data!.docs[index];
// return  Padding(
//   padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
//   child: ListTile(
//     leading: Container(
//       height: 120,
//       width: 95,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(15),
//         image: DecorationImage(image: NetworkImage('${snapshot.data!.docs[index]["images"]}'),fit: BoxFit.fill)
//       ),
//     ),
//     title:Text('${_documentSnapshot['name']}'),
//   ),
// );
              return widget.carts? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: CartItem(
                  image: snapshot.data!.docs[index]["images"][0],
                  price: _documentSnapshot['price'].toString(),
                  quantity:snapshot.data!.docs[index]["qty"],
                  add: (){
                    setState(() {
                      // snapshot.data!.docs[index]["qty"] =snapshot.data!.docs[index]["qty"]+1;
                    });

                  },
                  remove: (){},
                  delete: (){
                    FirebaseFirestore.instance
                        .collection(widget.collectionName!)
                        .doc(FirebaseAuth.instance.currentUser!.email)
                        .collection("items")
                        .doc(_documentSnapshot.id)
                        .delete();
                  },
                  title: _documentSnapshot['name'], cart:widget.carts,
                ),
              ):Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                child: ListTile(
                  leading: Container(
                    height: 120,
                    width: 95,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(image: NetworkImage('${snapshot.data!.docs[index]["images"]}'),fit: BoxFit.fill)
                    ),
                  ),
                  title:Text('${_documentSnapshot['name']}'),
                ),
              );
//   Card(
//   elevation: 5,
//   child: ListTile(
//     leading: Text(_documentSnapshot['name']),
//     title: Text(
//       "\$ ${_documentSnapshot['price']}",
//       style: TextStyle(
//           fontWeight: FontWeight.bold, color: Colors.red),
//     ),
//     trailing: GestureDetector(
//       child: CircleAvatar(
//         child: Icon(Icons.remove_circle),
//       ),
//       onTap: () {
//         FirebaseFirestore.instance
//             .collection(collectionName)
//             .doc(FirebaseAuth.instance.currentUser!.email)
//             .collection("items")
//             .doc(_documentSnapshot.id)
//             .delete();
//       },
//     ),
//   ),
// );
            });
      },
    );
  }
}

// Widget fetchData (String collectionName, bool carts){
//
// var qty = 1;
//
// return StreamBuilder(
// stream: FirebaseFirestore.instance
//     .collection(collectionName)
//     .doc(FirebaseAuth.instance.currentUser!.email)
//     .collection("items")
//     .snapshots(),
// builder:
// (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
// if (snapshot.hasError) {
// return Center(
// child: Text("Something is wrong"),
// );
// }
//
// return ListView.builder(
// primary: false,
// shrinkWrap: true,
// itemCount: snapshot.data == null ? 0 : snapshot.data!.docs.length,
// itemBuilder: (_, index) {
// DocumentSnapshot _documentSnapshot = snapshot.data!.docs[index];
// // return  Padding(
// //   padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
// //   child: ListTile(
// //     leading: Container(
// //       height: 120,
// //       width: 95,
// //       decoration: BoxDecoration(
// //         borderRadius: BorderRadius.circular(15),
// //         image: DecorationImage(image: NetworkImage('${snapshot.data!.docs[index]["images"]}'),fit: BoxFit.fill)
// //       ),
// //     ),
// //     title:Text('${_documentSnapshot['name']}'),
// //   ),
// // );
// return carts? Padding(
// padding: const EdgeInsets.symmetric(horizontal: 10),
// child: CartItem(
// image: snapshot.data!.docs[index]["images"][0],
// price: _documentSnapshot['price'].toString(),
// quantity:snapshot.data!.docs[index]["qty"],
// add: (){
//
// },
// remove: (){},
// delete: (){
// FirebaseFirestore.instance
//     .collection(collectionName)
//     .doc(FirebaseAuth.instance.currentUser!.email)
//     .collection("items")
//     .doc(_documentSnapshot.id)
//     .delete();
// },
// title: _documentSnapshot['name'], cart: carts,
// ),
// ):Padding(
// padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
// child: ListTile(
// leading: Container(
// height: 120,
// width: 95,
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(15),
// image: DecorationImage(image: NetworkImage('${snapshot.data!.docs[index]["images"]}'),fit: BoxFit.fill)
// ),
// ),
// title:Text('${_documentSnapshot['name']}'),
// ),
// );
// //   Card(
// //   elevation: 5,
// //   child: ListTile(
// //     leading: Text(_documentSnapshot['name']),
// //     title: Text(
// //       "\$ ${_documentSnapshot['price']}",
// //       style: TextStyle(
// //           fontWeight: FontWeight.bold, color: Colors.red),
// //     ),
// //     trailing: GestureDetector(
// //       child: CircleAvatar(
// //         child: Icon(Icons.remove_circle),
// //       ),
// //       onTap: () {
// //         FirebaseFirestore.instance
// //             .collection(collectionName)
// //             .doc(FirebaseAuth.instance.currentUser!.email)
// //             .collection("items")
// //             .doc(_documentSnapshot.id)
// //             .delete();
// //       },
// //     ),
// //   ),
// // );
// });
// },
// );
// }