import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newecommarce/const/AppColors.dart';

class Profilewidget extends StatefulWidget {
  final String name;
  const Profilewidget({super.key,required this.name});
  @override
  State<Profilewidget> createState() => _ProfilewidgetState();
}

class _ProfilewidgetState extends State<Profilewidget> {
  var value=true;
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          height: size.height*0.25,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
           // borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15)),
            color: AppColors.deep_orange.withOpacity(0.3),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 45,
                backgroundImage: AssetImage('asset/placeholder.jpg'),
              ),
              SizedBox(height: 10,),
              Text(
                widget.name,
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
        // Expanded(
        //   child: SingleChildScrollView(
        //     child: Column(
        //       children: [
        //         Padding(
        //           padding: const EdgeInsets.only(left: 5,right: 5,bottom: 5),
        //           child: InkWell(
        //             onTap:(){
        //               setState(() {
        //                 //themeChanger.botomIndex=0;
        //               });
        //               // nextpage(context, BottomNavBar());
        //               nextpage(context, HomePage());
        //             },
        //             child: Container(
        //               decoration: BoxDecoration(
        //                 borderRadius: BorderRadius.circular(12),
        //
        //               ),
        //               child: Padding(
        //                 padding: const EdgeInsets.only(top: 5,bottom: 5,left: 10,right: 10),
        //                 child: Row(
        //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                   children: [
        //                     Row(
        //                       children: [
        //                         CircleAvatar(
        //                             radius: 15,
        //                             backgroundColor: Colors.grey.withOpacity(0.2),
        //
        //                             child: Center(child: Icon(Icons.home,color: Colors.white,size: 20,))),
        //                         SizedBox(
        //                           width: 10,
        //                         ),
        //                         Text('Home',style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold)),
        //
        //
        //                       ],
        //                     ),
        //                     Icon(Icons.arrow_forward_ios,size: 18,color: Colors.white,),
        //
        //                   ],
        //                 ),
        //               ),
        //             ),
        //           ),
        //         ),
        //         Divider(
        //           height: 2,
        //           color: Colors.white.withOpacity(0.3),
        //         ),
        //         Padding(
        //           padding: const EdgeInsets.only(left: 5,right: 5,bottom: 5),
        //           child: InkWell(
        //             onTap:(){
        //               // setState(() {
        //               //   themeChanger.botomIndex=1;
        //               // });
        //               nextpage(context, RadioPlaypage());
        //             },
        //             child: Container(
        //               decoration: BoxDecoration(
        //                 borderRadius: BorderRadius.circular(12),
        //
        //               ),
        //               child: Padding(
        //                 padding: const EdgeInsets.only(top: 5,bottom: 5,left: 10,right: 10),
        //                 child: Row(
        //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                   children: [
        //                     Row(
        //                       children: [
        //                         CircleAvatar(
        //                             radius: 15,
        //                             backgroundColor: Colors.grey.withOpacity(0.2),
        //                             child: Center(child: Icon(Icons.radio,color: Colors.white,size: 20,))),
        //                         SizedBox(
        //                           width: 10,
        //                         ),
        //                         Text('Radio',style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold)),
        //
        //                       ],
        //                     ),
        //                     Icon(Icons.arrow_forward_ios,size: 18,color: Colors.white,),
        //
        //                   ],
        //                 ),
        //               ),
        //             ),
        //           ),
        //         ),
        //         Divider(
        //           height: 2,
        //           color: Colors.white.withOpacity(0.3),
        //         ),
        //         Padding(
        //           padding: const EdgeInsets.only(left: 5,right: 5,bottom: 5),
        //           child: InkWell(
        //             onTap:(){
        //               // setState(() {
        //               //   themeChanger.botomIndex=2;
        //               // });
        //               nextpage(context, LiveTv());
        //
        //
        //             },
        //             child: Container(
        //               decoration: BoxDecoration(
        //                 borderRadius: BorderRadius.circular(12),
        //
        //               ),
        //               child: Padding(
        //                 padding: const EdgeInsets.only(top: 5,bottom: 5,left: 10,right: 10),
        //                 child: Row(
        //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                   children: [
        //                     Row(
        //                       children: [
        //                         CircleAvatar(
        //                             radius: 15,
        //                             backgroundColor: Colors.grey.withOpacity(0.2),
        //                             child: Center(child: Icon(Icons.live_tv,color: Colors.white,size: 20,))),
        //                         SizedBox(
        //                           width: 10,
        //                         ),
        //                         Text('LiveTv',style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold)),
        //
        //
        //                       ],
        //                     ),
        //                     Icon(Icons.arrow_forward_ios,size: 18,color: Colors.white,),
        //
        //                   ],
        //                 ),
        //               ),
        //             ),
        //           ),
        //         ),
        //         Divider(
        //           height: 2,
        //           color: Colors.white.withOpacity(0.3),
        //         ),
        //         Padding(
        //           padding: const EdgeInsets.only(left: 5,right: 5,bottom: 5),
        //           child: InkWell(
        //             onTap:(){
        //               setState(() {
        //                 themeChanger.botomIndex=3;
        //               });
        //               nextpage(context, VideosPage());
        //
        //
        //             },
        //             child: Container(
        //               decoration: BoxDecoration(
        //                 borderRadius: BorderRadius.circular(12),
        //
        //               ),
        //               child: Padding(
        //                 padding: const EdgeInsets.only(top: 5,bottom: 5,left: 10,right: 10),
        //                 child: Row(
        //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                   children: [
        //                     Row(
        //                       children: [
        //                         CircleAvatar(
        //                             radius: 15,
        //                             backgroundColor: Colors.grey.withOpacity(0.2),
        //                             child: Center(child: Icon(Icons.play_circle_outline,color: Colors.white,size: 20,))),
        //                         SizedBox(
        //                           width: 10,
        //                         ),
        //                         Text('Video',style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold)),
        //
        //
        //                       ],
        //                     ),
        //                     Icon(Icons.arrow_forward_ios,size: 18,color: Colors.white,),
        //
        //                   ],
        //                 ),
        //               ),
        //             ),
        //           ),
        //         ),
        //         Divider(
        //           height: 2,
        //           color: Colors.white.withOpacity(0.3),
        //         ),
        //         Padding(
        //           padding: const EdgeInsets.only(left: 5,right: 5,bottom: 5),
        //           child: InkWell(
        //             onTap:(){
        //               setState(() {
        //                 themeChanger.botomIndex=4;
        //               });
        //               nextpage(context, PodcastsPage());
        //
        //             },
        //             child: Container(
        //               decoration: BoxDecoration(
        //                 borderRadius: BorderRadius.circular(12),
        //
        //               ),
        //               child: Padding(
        //                 padding: const EdgeInsets.only(top: 5,bottom: 5,left: 10,right: 10),
        //                 child: Row(
        //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                   children: [
        //                     Row(
        //                       children: [
        //                         CircleAvatar(
        //                             radius: 15,
        //                             backgroundColor: Colors.grey.withOpacity(0.2),
        //                             child: Center(child: Icon(Icons.podcasts,color: Colors.white,size: 20,))),
        //                         SizedBox(
        //                           width: 10,
        //                         ),
        //                         Text('Podcast',style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold)),
        //
        //
        //                       ],
        //                     ),
        //                     Icon(Icons.arrow_forward_ios,size: 18,color: Colors.white,),
        //
        //                   ],
        //                 ),
        //               ),
        //             ),
        //           ),
        //         ),
        //         Divider(
        //           height: 2,
        //           color: Colors.white.withOpacity(0.3),
        //         ),
        //
        //
        //       ],
        //     ),
        //   ),
        // ),
      ],
    );
  }
}