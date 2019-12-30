import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/profileClipper.dart';


class HomePage extends StatelessWidget {
  num customTop = 90;

  void _login(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      backgroundColor: Colors.white,
      builder: (_) {
        return Container(
          height: 547,
          child: Center(
            child: Text('123123123'),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(
      width: 1125,
      height: 2436,
      allowFontScaling: true,
    )..init(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(5, 159, 149, 0.8),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                top: ScreenUtil().setHeight(customTop),
                left: ScreenUtil().setWidth(40),
                right: ScreenUtil().setWidth(40),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: () {},
                  ),
                  GestureDetector(
                    onTap: () => _login(context),
                    child: ClipOval(
                      clipper: ProfileClipper(),
                      child: Image.asset(
                        "assets/images/headericon.jpg",
                        width: ScreenUtil().setWidth(160),
                        height: ScreenUtil().setHeight(160),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(50),
            ),
            // SizedBox(
            //   height: ScreenUtil().setHeight(1050),
            //   child: ListView.builder(
            //     scrollDirection: Axis.horizontal,
            //     physics: BouncingScrollPhysics(),
            //     itemCount: products.length,
            //     itemBuilder: (context, index) {
            //       Shoes shoes = products[index];
            //       return Padding(
            //         padding: EdgeInsets.only(
            //           left: ScreenUtil().setWidth(30),
            //         ),
            //         child: ProductCard(shoes: shoes, cardNum: index),
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );;
  }
}
