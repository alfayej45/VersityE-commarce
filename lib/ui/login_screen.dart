import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newecommarce/const/AppColors.dart';
import 'package:newecommarce/ui/bottom_nav_controller.dart';
import 'package:newecommarce/ui/registration_screen.dart';
import 'package:newecommarce/widgets/customButton.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool _obscureText = true;

  signIn()async{
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text
      );

      var authCredential = userCredential.user;
      print(authCredential!.uid);
      if(authCredential.uid.isNotEmpty){
        Navigator.push(context, CupertinoPageRoute(builder: (_)=>BottomNavController()));
      }
      else{
        Fluttertoast.showToast(msg: "Something is wrong");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: "No user found for that email.");
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: "Wrong password provided for that user.");
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.deep_orange,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 150.h,
                width: ScreenUtil().screenWidth,
                child: Padding(
                  padding: EdgeInsets.only(left: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: null,
                        icon: Icon(
                          Icons.light,
                          color: Colors.transparent,
                        ),
                      ),
                      Text(
                        "Sign In",
                        style: TextStyle(fontSize: 22.sp, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: ScreenUtil().screenWidth,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(28.r),
                    topRight: Radius.circular(28.r),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        "Welcome Back",
                        style: TextStyle(
                            fontSize: 22.sp, color: AppColors.deep_orange),
                      ),
                      Text(
                        "Glad to see you back my buddy.",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Color(0xFFBBBBBB),
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 48.h,
                            width: 41.w,
                            decoration: BoxDecoration(
                                color: AppColors.deep_orange,
                                borderRadius: BorderRadius.circular(12.r)),
                            child: Center(
                              child: Icon(
                                Icons.email_outlined,
                                color: Colors.white,
                                size: 20.w,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Expanded(
                            child: Container(
                              height: 50,
                              child: TextFormField(
                                //  readOnly: true,
                                controller: _emailController,
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(15)),
                                      borderSide: BorderSide(color: Colors.blue)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(15)),
                                      borderSide: BorderSide(color: Colors.grey)),
                                  hintText: "Enter Email",
                                  hintStyle: TextStyle(fontSize: 15.sp),
                                ),
                                // onTap: () => Navigator.push(context,
                                //     CupertinoPageRoute(builder: (_) => SearchScreen())),
                              ),
                            ),
                            // child: TextField(
                            //   controller: _emailController,
                            //   decoration: InputDecoration(
                            //     hintText: "thed9954@gmail.com",
                            //     hintStyle: TextStyle(
                            //       fontSize: 14.sp,
                            //       color: Color(0xFF414041),
                            //     ),
                            //     labelText: 'EMAIL',
                            //     labelStyle: TextStyle(
                            //       fontSize: 15.sp,
                            //       color: AppColors.deep_orange,
                            //     ),
                            //   ),
                            // ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 48.h,
                            width: 41.w,
                            decoration: BoxDecoration(
                                color: AppColors.deep_orange,
                                borderRadius: BorderRadius.circular(12.r)),
                            child: Center(
                              child: Icon(
                                Icons.lock_outline,
                                color: Colors.white,
                                size: 20.w,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Expanded(
                            child: Container(
                              height: 50,
                              child: TextFormField(
                                //  readOnly: true,
                                controller: _passwordController,
                                obscureText: _obscureText,
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(15)),
                                      borderSide: BorderSide(color: Colors.blue)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(15)),
                                      borderSide: BorderSide(color: Colors.grey)),
                                  hintText: "Enter Password",
                                  hintStyle: TextStyle(fontSize: 15.sp),
                                ),
                                // onTap: () => Navigator.push(context,
                                //     CupertinoPageRoute(builder: (_) => SearchScreen())),
                              ),
                            ),

                            // TextField(
                            //   controller: _passwordController,
                            //   obscureText: _obscureText,
                            //   decoration: InputDecoration(
                            //     hintText: "password must be 6 character",
                            //     hintStyle: TextStyle(
                            //       fontSize: 14.sp,
                            //       color: Color(0xFF414041),
                            //     ),
                            //     labelText: 'PASSWORD',
                            //     labelStyle: TextStyle(
                            //       fontSize: 15.sp,
                            //       color: AppColors.deep_orange,
                            //     ),
                            //     suffixIcon: _obscureText == true
                            //         ? IconButton(
                            //             onPressed: () {
                            //               setState(() {
                            //                 _obscureText = false;
                            //               });
                            //             },
                            //             icon: Icon(
                            //               Icons.remove_red_eye,
                            //               size: 20.w,
                            //             ))
                            //         : IconButton(
                            //             onPressed: () {
                            //               setState(() {
                            //                 _obscureText = true;
                            //               });
                            //             },
                            //             icon: Icon(
                            //               Icons.visibility_off,
                            //               size: 20.w,
                            //             )),
                            //   ),
                            // ),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 50.h,
                      ),
                      // elevated button
                      customButton("Sign In", (){
                        signIn();
                      },),
                      SizedBox(
                        height: 20.h,
                      ),
                      Wrap(
                        children: [
                          Text(
                            "Don't have an account?",
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFBBBBBB),
                            ),
                          ),
                          GestureDetector(
                            child: Text(
                              " Sign Up",
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.deep_orange,
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) =>
                                          RegistrationScreen()));
                            },
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
          
              // SizedBox(height: 10,),
          
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Divider(
                        indent: 7,
                        thickness: 1,
                        color: Color(0XFF7972e6).withOpacity(0.9)),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Login using Social Media',
                    style: TextStyle(color:Colors.white, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Divider(
                      endIndent: 7,
                      thickness: 1,
                      color: Color(0XFF7972e6).withOpacity(0.9),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.only(left: 15,right: 15),
                child: Container(
                  // height: 10,
                  width: size.width,
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0XFF7972e6).withOpacity(0.5)),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 55,
                          width: 55,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color:
                              Color(0xFf5478b2).withOpacity(0.8)),
                          child: Center(
                            child: Text(
                              "f",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 30),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 55,
                          width: 55,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color:
                              Color(0xFf50cafa).withOpacity(0.8)),
                          child: Center(
                            child: Text(
                              "t",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 30),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: (){
                           // googlelogin();
                          },
                          child: Container(
                            height: 55,
                            width: 55,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color:
                                Color(0xFffc6254).withOpacity(0.8)),
                            child: Center(
                              child: Text(
                                "g",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 30),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 55,
                          width: 55,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color:
                              Color(0xFf5478b2).withOpacity(0.8)),
                          child: Center(
                              child: Icon(
                                Icons.phone_android_outlined,
                                size: 25,
                                color: Colors.white60,
                              )
          
                            // Text("f",style: TextStyle(fontWeight: FontWeight.bold
                            //     ,color: Colors.white,fontSize: 30),),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15,),
          
            ],
          ),
        ),
      ),
    );
  }
}
