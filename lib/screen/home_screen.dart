import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // double statusBarheight = MediaQuery.of(context).viewPadding.top;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        leading: Icon(Icons.menu),
      ),

      body:
          //    Padding(
          // padding: EdgeInsets.only(top: statusBarheight),
          // child:
          MainUI(),
      // )
    );
  }
}

class MainUI extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('종빈'),
            Text('은아'),
            Text('광진'),
            Text('양갱'),
            Text('기훈'),
          ],
        ),
        Expanded(
            child: ListView.builder(
                itemExtent: 30.h,
                itemCount: 21,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    onTap: () {},
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('10'),
                        Text(
                          '10',
                          style: TextStyle(
                              color: index == 0 ? Colors.white : Colors.black),
                        ),
                        //
                        Text('10'),
                        Text('10'),
                        //
                        Text('10'),
                        Text('10'),
                        //
                        Text('10'),
                        Text('10'),
                        //
                        Text('10'),
                        Text('10'),
                      ],
                    ),
                  );
                })),
        Container(
          color: Colors.blue,
          width: size.width,
          height: 30.h,
        )
      ],
    );
  }
}
