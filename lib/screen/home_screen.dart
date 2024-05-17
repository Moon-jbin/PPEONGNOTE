import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ppeongnote/custom_widgets/custom_widget.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double statusBarheight = MediaQuery.of(context).viewPadding.top;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: statusBarheight),
        child: MainUI(),
      ),
    );
  }
}

class MainUI extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
          alignment: Alignment.center,
          width: size.width,
          height: size.height,
          decoration: CustomWidget.bgColorWidget(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 40.h),
                child: Text(
                  '플레이 할 인원 수를 선택해주세요.',
                  style: TextStyle(
                    fontSize: 25.spMin,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade900,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                    3,
                    (index) =>
                        CustomWidget.playerSelectBox(context, type: index + 3)),
              )
            ],
          )),
    );
  }
}
