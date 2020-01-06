import 'package:fiora_app_flutter/widgets/linkman.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../widgets/avatar_widget.dart';
import '../models/friends.dart';
import '../models/linkman.dart';
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
                  itemCount: authData.linkmans.length,
                  // 需要根据消息时间 sort， 需要将
                  itemBuilder: (ctx, i) => Linkman(
                    id: (authData.linkmans[i] as LinkmanItem).sId,
                    avatar: (authData.linkmans[i] as LinkmanItem).avatar,
                    name: (authData.linkmans[i] as LinkmanItem).name,
                    message: (authData.linkmans[i] as LinkmanItem).message.content,
                    lastName: (authData.linkmans[i] as LinkmanItem).message.from.username,
                    time: DateTime.parse((authData.linkmans[i] as LinkmanItem).message.createTime),
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
