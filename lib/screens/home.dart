import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/auth_widget.dart';
import '../utils/profileClipper.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home';

  final num customTop = 90;

  void _login(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(30.0),
      // ),
      backgroundColor: Colors.white,
      builder: (_) {
        return Container(
          height: ScreenUtil().setHeight(760),
          child: Center(
            child: AuthWidget(),
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
      // backgroundColor: Color.fromRGBO(5, 159, 149, 0.8),
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
              child: Text('123'),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(1050),
              child: ListView.builder(
                // scrollDirection: Axis.horizontal,
                // physics: BouncingScrollPhysics(),
                itemCount: [1, 2, 3].length,
                itemBuilder: (context, index) {
                  return Container(
                    width: double.infinity,
                    color: Color.fromRGBO(5, 5, 5, 1),
                    padding: EdgeInsets.only(
                      left: ScreenUtil().setWidth(30),
                    ),
                    child: Text(
                      [1, 2, 3][index].toString(),
                      style: TextStyle(backgroundColor: Colors.red),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
