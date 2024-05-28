import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ppeongnote/custom_widgets/custom_widget.dart';
import 'package:ppeongnote/providers/global_provider.dart';
import 'package:ppeongnote/utill/custom_style.dart';
import 'package:ppeongnote/utill/routing/navigation_service.dart';
import 'package:ppeongnote/utill/routing/router_name.dart';

class PenaltyDlg extends HookConsumerWidget {
  int type;
  PenaltyDlg({super.key, required this.type});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final penaltyTitleRead = ref.read(penaltyTitleProvider.notifier);
    final penaltContentRead = ref.read(penaltContentProvider.notifier);
    Size size = MediaQuery.of(context).size;

    TextEditingController penaltyTfController = useTextEditingController();

    TextEditingController tfController_1 = useTextEditingController();
    TextEditingController tfController_2 = useTextEditingController();
    TextEditingController tfController_3 = useTextEditingController();
    TextEditingController tfController_4 = useTextEditingController();
    TextEditingController tfController_5 = useTextEditingController();

    return SingleChildScrollView(
      child: Container(
        // width: size.width,
        margin: EdgeInsets.all(10.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomWidget.customDlgTitle(context, title: "벌칙을 입력하세요."),
            Container(
                margin: EdgeInsets.symmetric(vertical: 10.h),
                child: Row(
                  children: [
                    Text('벌칙 내용 : ', style: CustomStyle.defaultStyle),
                    Expanded(
                        child: CustomWidget.customTextField(penaltyTfController,
                            hintText: "주제"))
                  ],
                )),
            PenaltyTextFeild(
                type: type,
                tfController_1: tfController_1,
                tfController_2: tfController_2,
                tfController_3: tfController_3,
                tfController_4: tfController_4,
                tfController_5: tfController_5),
            CustomWidget.dlgButtons(context, onPressed: () {
              //벌칙 내용
              List<String> penaltyList = [];
              Map<String, String> penaltyData = {};
              if (type == 3) {
                penaltyList.add(tfController_1.text);
                penaltyList.add(tfController_2.text);
                penaltyList.add(tfController_3.text);
              } else if (type == 4) {
                penaltyList.add(tfController_1.text);
                penaltyList.add(tfController_2.text);
                penaltyList.add(tfController_3.text);
                penaltyList.add(tfController_4.text);
              } else {
                penaltyList.add(tfController_1.text);
                penaltyList.add(tfController_2.text);
                penaltyList.add(tfController_3.text);
                penaltyList.add(tfController_4.text);
                penaltyList.add(tfController_5.text);
              }

              for (int i = 0; i < type; i++) {
                penaltyData["${i + 1}"] = penaltyList[i];
              }
              penaltContentRead.setContent(penaltyData);

              // 주제
              penaltyTitleRead.setTitle(penaltyTfController.text);
              Navigator.pop(context);
              NavigationService().routerReplace(context, ScoreRoute);
            })
          ],
        ),
      ),
    );
  }
}

class PenaltyTextFeild extends HookConsumerWidget {
  int type;
  TextEditingController tfController_1;
  TextEditingController tfController_2;
  TextEditingController tfController_3;
  TextEditingController tfController_4;
  TextEditingController tfController_5;
  PenaltyTextFeild(
      {super.key,
      required this.type,
      required this.tfController_1,
      required this.tfController_2,
      required this.tfController_3,
      required this.tfController_4,
      required this.tfController_5});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ValueNotifier<List<TextEditingController>> trControllerList = useState([]);
    Widget penaltyTfList() {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
            type,
            (index) => Container(
                  margin: EdgeInsets.all(10.w),
                  child: Row(
                    children: [
                      Text(
                        '${index + 1} 등 : ',
                        style: CustomStyle.defaultStyle,
                      ),
                      Expanded(
                          child: CustomWidget.customTextField(
                              trControllerList.value[index]))
                    ],
                  ),
                )),
      );
    }

    if (type == 3) {
      trControllerList.value = [tfController_1, tfController_2, tfController_3];
      return penaltyTfList();
    } else if (type == 4) {
      trControllerList.value = [
        tfController_1,
        tfController_2,
        tfController_3,
        tfController_4,
      ];
      return penaltyTfList();
    } else {
      trControllerList.value = [
        tfController_1,
        tfController_2,
        tfController_3,
        tfController_4,
        tfController_5,
      ];
      return penaltyTfList();
    }
  }
}
