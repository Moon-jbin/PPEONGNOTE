import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ppeongnote/custom_widgets/custom_widget.dart';
import 'package:ppeongnote/providers/global_provider.dart';
import 'package:ppeongnote/utill/custom_style.dart';
import 'package:ppeongnote/utill/dialog/dlg_function.dart';
import 'package:ppeongnote/utill/routing/navigation_service.dart';
import 'package:ppeongnote/utill/routing/router_name.dart';

class PlayerName extends HookConsumerWidget {
  int type;
  PlayerName({super.key, required this.type});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerNameProviderRead = ref.read(playerNameProvider.notifier);
    Size size = MediaQuery.of(context).size;

    TextEditingController tfController_1 = useTextEditingController();
    TextEditingController tfController_2 = useTextEditingController();
    TextEditingController tfController_3 = useTextEditingController();
    TextEditingController tfController_4 = useTextEditingController();
    TextEditingController tfController_5 = useTextEditingController();

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(10.w),
        // width: size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomWidget.customDlgTitle(context, title: "플레이어 이름을 적어주세요."),
            PlayerNameTextfeild(
                type: type,
                tfController_1: tfController_1,
                tfController_2: tfController_2,
                tfController_3: tfController_3,
                tfController_4: tfController_4,
                tfController_5: tfController_5),
            CustomWidget.dlgButtons(context, onPressed: () {
              List<String> playerNameList = [];
              if (type == 3) {
                if (tfController_1.text.isEmpty ||
                    tfController_2.text.isEmpty ||
                    tfController_3.text.isEmpty) return;

                playerNameList.add(tfController_1.text);
                playerNameList.add(tfController_2.text);
                playerNameList.add(tfController_3.text);
              } else if (type == 4) {
                if (tfController_1.text.isEmpty ||
                    tfController_2.text.isEmpty ||
                    tfController_3.text.isEmpty ||
                    tfController_4.text.isEmpty) return;

                playerNameList.add(tfController_1.text);
                playerNameList.add(tfController_2.text);
                playerNameList.add(tfController_3.text);
                playerNameList.add(tfController_4.text);
              } else {
                if (tfController_1.text.isEmpty ||
                    tfController_2.text.isEmpty ||
                    tfController_3.text.isEmpty ||
                    tfController_4.text.isEmpty ||
                    tfController_5.text.isEmpty) return;

                playerNameList.add(tfController_1.text);
                playerNameList.add(tfController_2.text);
                playerNameList.add(tfController_3.text);
                playerNameList.add(tfController_4.text);
                playerNameList.add(tfController_5.text);
              }

              playerNameProviderRead.setPlayer(playerNameList);

              Navigator.pop(context);
              showPenaltyDlgFn(context, type: type);
            })

          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class PlayerNameTextfeild extends HookConsumerWidget {
  int type;
  TextEditingController tfController_1;
  TextEditingController tfController_2;
  TextEditingController tfController_3;
  TextEditingController tfController_4;
  TextEditingController tfController_5;
  PlayerNameTextfeild(
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

    Widget playerTfList() {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
            type,
            (index) => Container(
                  margin: EdgeInsets.all(10.w),
                  child: Row(
                    children: [
                      Text(
                        '플레이어 ${index + 1} : ',
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

      return playerTfList();
    } else if (type == 4) {
      trControllerList.value = [
        tfController_1,
        tfController_2,
        tfController_3,
        tfController_4
      ];

      return playerTfList();
    } else {
      trControllerList.value = [
        tfController_1,
        tfController_2,
        tfController_3,
        tfController_4,
        tfController_5,
      ];

      return playerTfList();
    }
  }
}
