import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartItem extends StatefulWidget {
  final String title;

  final String image;

  final String price;

  final int quantity;
  final bool cart;

  final Function() add;
  final Function() remove;
  final Function() delete;

  const CartItem(
      {super.key,
      required this.image,
      required this.price,
      required this.quantity,
      required this.add,
      required this.remove,
      required this.delete,
      required this.title,
      required this.cart});

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                  10.0), // You can adjust the radius as needed
              child: FadeInImage(
                placeholder: AssetImage("asset/placeholder.jpg"),
                fit: BoxFit.cover,
                image: NetworkImage(widget.image),
              ),
            ),
          ),
          SizedBox(
            width: 15.w,
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {},
                  child: Text(
                    widget.title,
                    maxLines: 2,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        overflow: TextOverflow.ellipsis),
                  ),
                ),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    Text(
                      widget.price,
                      style: TextStyle(
                        // color: Color(0xff9F9F9F),

                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),

                  Row(
                    // mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: widget.remove,
                        padding: EdgeInsets.zero,
                        style: const ButtonStyle(
                          tapTargetSize: MaterialTapTargetSize
                              .shrinkWrap, // the '2023' part
                        ),
                        icon: Container(
                            height: 18,
                            width: 18,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.black)),
                            child: const Center(
                              child: Icon(
                                Icons.remove,
                                size: 15,
                              ),
                            )),
                      ),
                      Text(widget.quantity.toString()),
                      IconButton(
                        onPressed: widget.add,
                        padding: EdgeInsets.zero,
                        style: const ButtonStyle(
                          tapTargetSize: MaterialTapTargetSize
                              .shrinkWrap, // the '2023' part
                        ),
                        icon: Container(
                            height: 18,
                            width: 18,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.black)),
                            child: const Center(
                              child: Icon(
                                Icons.add,
                                size: 15,
                              ),
                            )),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: IconButton(
                            onPressed: widget.delete,
                            padding: EdgeInsets.zero,
                            style: const ButtonStyle(
                              tapTargetSize: MaterialTapTargetSize
                                  .shrinkWrap, // the '2023' part
                            ),
                            icon: Icon(Icons.delete,color: Colors.red,)),
                      )
                    ],
                  )
              ],
            ),
          ),
          // Expanded(
          //   child: Align(
          //   alignment: Alignment.bottomRight,
          //   child: Icon(Icons.delete),
          // ),
          // ),
        ],
      ),
    );
  }
}
