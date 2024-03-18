import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newecommarce/const/AppColors.dart';
import '../../widgets/profile_widget.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}
class _ProfileState extends State<Profile> {
  TextEditingController ?_nameController;
  TextEditingController ?_phoneController;
  TextEditingController ?_ageController;

  setDataToTextField(data){
    return  Column(
      children: [
        TextFormField(
          controller: _nameController = TextEditingController(text: data['name']),
        ),
        TextFormField(
          controller: _phoneController = TextEditingController(text: data['phone']),
        ),
        TextFormField(
          controller: _ageController = TextEditingController(text: data['age']),
        ),
        ElevatedButton(onPressed: ()=>updateData(), child: Text("Update"))
      ],
    );
  }

  updateData(){
    CollectionReference _collectionRef = FirebaseFirestore.instance.collection("users-form-data");
    return _collectionRef.doc(FirebaseAuth.instance.currentUser!.email).update(
        {
          "name":_nameController!.text,
          "phone":_phoneController!.text,
          "age":_ageController!.text,
        }
        ).then((value) => print("Updated Successfully"));
  }

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.deep_orange.withOpacity(0.2),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Profile",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.only(left: 10,right: 10),
        child: SingleChildScrollView(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection("users-form-data").doc(FirebaseAuth.instance.currentUser!.email).snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot){
              var data = snapshot.data;
              if(data==null){
                return Center(child: CircularProgressIndicator(),);
              }
              return  Column(
                children: [
                  Profilewidget(
                    name:data['name'] ,
                  ),
                  SizedBox(height: 15,),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      // borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15)),
                      color: AppColors.deep_orange.withOpacity(0.3),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 8,right: 8),
                          minLeadingWidth: 5,
                          minVerticalPadding: 0,
                          title:Text(
                            'My Orders',
                            style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w700),
                          ),
                          leading: Icon(Icons.shop,size: 25,color: Colors.deepPurpleAccent,),
                          trailing: Icon(Icons.arrow_forward_ios_outlined,size: 22,),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 8,right: 8),
                          minLeadingWidth: 5,
                          minVerticalPadding: 0,
                          title:Text(
                            'Change Password',
                            style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w700),
                          ),
                          leading: Icon(Icons.lock,size: 25,color: Colors.deepPurpleAccent,),
                          trailing: Icon(Icons.arrow_forward_ios_outlined,size: 22,),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 8,right: 8),
                          minLeadingWidth: 5,
                          minVerticalPadding: 0,
                          title:Text(
                            'Terms & Conditions',
                            style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w700),
                          ),
                          leading: Icon(Icons.file_copy,size: 25,color: Colors.deepPurpleAccent,),
                          trailing: Icon(Icons.arrow_forward_ios_outlined,size: 22,),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 8,right: 8),
                          minLeadingWidth: 5,
                          minVerticalPadding: 0,
                          title:Text(
                            'Privecy Policy',
                            style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w700),
                          ),
                          leading: Icon(Icons.file_open,size: 25,color: Colors.deepPurpleAccent,),
                          trailing: Icon(Icons.arrow_forward_ios_outlined,size: 22,),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 8,right: 8),
                          minLeadingWidth: 5,
                          minVerticalPadding: 0,
                          title:Text(
                            'Setting',
                            style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w700),
                          ),
                          leading: Icon(Icons.settings,size: 25,color: Colors.deepPurpleAccent,),
                          trailing: Icon(Icons.arrow_forward_ios_outlined,size: 22,),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 8,right: 8),
                          minLeadingWidth: 5,
                          minVerticalPadding: 0,
                          title:Text(
                            'Log Out',
                            style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w700),
                          ),
                          leading: Icon(Icons.power_settings_new,size: 25,color: Colors.deepPurpleAccent,),
                          trailing: Icon(Icons.arrow_forward_ios_outlined,size: 22,),
                        )
                        

                      ],
                    ),
                  ),
                ],
              );
              // return setDataToTextField(data);
            },
          ),
        ),
      )),
    );
  }
}
