import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'CartWidget.dart';

Widget fetchData (String collectionName, bool carts){
  return StreamBuilder(
    stream: FirebaseFirestore.instance
        .collection(collectionName)
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
          itemCount:
          snapshot.data == null ? 0 : snapshot.data!.docs.length,
          itemBuilder: (_, index) {
            DocumentSnapshot _documentSnapshot =
            snapshot.data!.docs[index];

            return
              CartItem(
                image:  snapshot.data!.docs[index]["images"][0], price: _documentSnapshot['price'].toString(),
                quantity: carts?snapshot.data!.docs[index]["qty"]:0,
                add: (){},
                remove: (){},
                delete: (){
                  FirebaseFirestore.instance
                      .collection(collectionName)
                      .doc(FirebaseAuth.instance.currentUser!.email)
                      .collection("items")
                      .doc(_documentSnapshot.id)
                      .delete();
                },
                title: _documentSnapshot['name'], cart: carts,

              ) ;
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