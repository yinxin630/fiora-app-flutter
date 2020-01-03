import 'package:fiora_app_flutter/widgets/linkman.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../widgets/avatar_widget.dart';
import '../models/friends.dart';
import '../providers/auth.dart';

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
              height: ScreenUtil().setHeight(1950),
              child: Consumer<Auth>(
                builder: (ctx, authData, child) => ListView.builder(
                  itemCount: authData.friends.length,
                  itemBuilder: (ctx, i) => Linkman(
                    id: (authData.friends[i] as FriendItem).sId,
                    avatar: (authData.friends[i] as FriendItem).to.avatar,
                    name: (authData.friends[i] as FriendItem).to.username,
                    massage: (authData.friends[i] as FriendItem).to.username,
                    time: (authData.friends[i] as FriendItem).to.username,
                  ),
                ),
              ),
              // Container(
              //   child: ListView.builder(
              //     // scrollDirection: Axis.horizontal,
              //     // physics: BouncingScrollPhysics(),
              //     itemCount: [1, 2, 3].length,
              //     itemBuilder: (context, index) {
              //       return Container(
              //         width: double.infinity,
              //         color: Color.fromRGBO(5, 5, 5, 1),
              //         padding: EdgeInsets.only(
              //           left: ScreenUtil().setWidth(30),
              //         ),
              //         child: Text(
              //           [1, 2, 3][index].toString(),
              //           style: TextStyle(backgroundColor: Colors.red),
              //         ),
              //       );
              //     },
              //   ),
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
