import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ppeongnote/custom_widgets/custom_widget.dart';

class OkCancelDlg extends HookConsumerWidget {
  String title;
  VoidCallback onTap;

  OkCancelDlg({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomWidget.customDlgTitle(context, title: title),
            CustomWidget.dlgButtons(context, isExit: true, onPressed: onTap)
          ],
        ));
  }
}
