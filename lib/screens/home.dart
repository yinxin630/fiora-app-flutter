import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/avatar_widget.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home';

  final num customTop = 90;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(
      width: 1125,
      height: 2436,
      allowFontScaling: true,
    )..init(context);
    return Scaffold(
      // drawer: ,
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
                  AvatarWidget(),
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
