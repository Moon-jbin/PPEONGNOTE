import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ppeongnote/custom_widgets/custom_widget.dart';
import 'package:ppeongnote/providers/global_provider.dart';
import 'package:ppeongnote/utill/custom_style.dart';

class CreateScore extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scoreProviderRead = ref.read(scoreProvider.notifier);
    final scoreProviderWatch = ref.watch(scoreProvider);
    final playerNameProviderWatch = ref.watch(playerNameProvider);
    ValueNotifier<List<TextEditingController>> tfControllerList = useState([]);
    Size size = MediaQuery.of(context).size;

    // 3인 기준 (차후 4인 5인 컴포넌트 따로 생성 할 것)

    TextEditingController tfController_1 = useTextEditingController();
    TextEditingController tfController_2 = useTextEditingController();
    TextEditingController tfController_3 = useTextEditingController();
    TextEditingController tfController_4 = useTextEditingController();
    TextEditingController tfController_5 = useTextEditingController();

    useEffect(() {
      if (playerNameProviderWatch.length == 3) {
        tfControllerList.value.add(tfController_1);
        tfControllerList.value.add(tfController_2);
        tfControllerList.value.add(tfController_3);
      } else if (playerNameProviderWatch.length == 4) {
        tfControllerList.value.add(tfController_1);
        tfControllerList.value.add(tfController_2);
        tfControllerList.value.add(tfController_3);
        tfControllerList.value.add(tfController_4);
      } else {
        tfControllerList.value.add(tfController_1);
        tfControllerList.value.add(tfController_2);
        tfControllerList.value.add(tfController_3);
        tfControllerList.value.add(tfController_4);
        tfControllerList.value.add(tfController_5);
      }
    }, []);

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(10.w),
        width: size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.h),
              child: Text('점수를 입력하세요.', style: CustomStyle.defaultStyle),
            ),
            Column(
              children: List.generate(
                playerNameProviderWatch.length,
                (index) => CustomWidget.playerScoreTF(
                    playerName: playerNameProviderWatch[index],
                    controller: tfControllerList.value[index]),
              ),
            ),
            TextButton(
                onPressed: () {
                  int playerScore_1;
                  int playerScore_2;
                  int playerScore_3;
                  int playerScore_4;
                  int playerScore_5;
                  List<int> tfControllerList;
                  if (playerNameProviderWatch.length == 3) {
                    if (tfController_1.text.isEmpty ||
                        tfController_2.text.isEmpty ||
                        tfController_3.text.isEmpty) return;

                    // 3인 기준 (차후 4인 기준 5인 기준 나눌 것)
                    playerScore_1 = int.parse(tfController_1.text);
                    playerScore_2 = int.parse(tfController_2.text);
                    playerScore_3 = int.parse(tfController_3.text);
                    tfControllerList = [
                      playerScore_1,
                      playerScore_2,
                      playerScore_3
                    ];
                  } else if (playerNameProviderWatch.length == 4) {
                    if (tfController_1.text.isEmpty ||
                        tfController_2.text.isEmpty ||
                        tfController_3.text.isEmpty ||
                        tfController_4.text.isEmpty) return;

                    // 3인 기준 (차후 4인 기준 5인 기준 나눌 것)
                    playerScore_1 = int.parse(tfController_1.text);
                    playerScore_2 = int.parse(tfController_2.text);
                    playerScore_3 = int.parse(tfController_3.text);
                    playerScore_4 = int.parse(tfController_4.text);
                    tfControllerList = [
                      playerScore_1,
                      playerScore_2,
                      playerScore_3,
                      playerScore_4,
                    ];
                  } else {
                    if (tfController_1.text.isEmpty ||
                        tfController_2.text.isEmpty ||
                        tfController_3.text.isEmpty ||
                        tfController_4.text.isEmpty ||
                        tfController_5.text.isEmpty) return;

                    playerScore_1 = int.parse(tfController_1.text);
                    playerScore_2 = int.parse(tfController_2.text);
                    playerScore_3 = int.parse(tfController_3.text);
                    playerScore_4 = int.parse(tfController_4.text);
                    playerScore_5 = int.parse(tfController_5.text);
                    tfControllerList = [
                      playerScore_1,
                      playerScore_2,
                      playerScore_3,
                      playerScore_4,
                      playerScore_5,
                    ];
                  }

                  int playerIdx = 0;
                  Map<String, List<List<int>>> scoreMap = {};
                  for (String playerName in playerNameProviderWatch) {
                    List<int> normalScoreList = scoreProviderWatch.isEmpty
                        ? []
                        : scoreProviderWatch[playerName]![0];
                    List<int> sumScoreList = scoreProviderWatch.isEmpty
                        ? []
                        : scoreProviderWatch[playerName]![1];
                    List<List<int>> playerScoreList = scoreProviderWatch.isEmpty
                        ? []
                        : scoreProviderWatch[playerName]!;

                    normalScoreList.add(tfControllerList[playerIdx]);

                    if (sumScoreList.isEmpty) {
                      sumScoreList.add(normalScoreList[0]);
                    } else {
                      int lastSumScore = sumScoreList[sumScoreList.length - 1];
                      int lastNormalScore =
                          normalScoreList[normalScoreList.length - 1];

                      sumScoreList.add(lastSumScore + lastNormalScore);
                    }
                    // for (int score in normalScoreList) {
                    //   if (sumScoreList.isEmpty) {
                    //     sumScoreList.add(score);
                    //     break;
                    //   } else {
                    //     for(int sumScore in sumScoreList){
                    //       normalScoreList[]
                    //     }
                    //     sumScoreList.add()
                    //   }
                    // }

                    playerScoreList.add(normalScoreList);
                    playerScoreList.add(sumScoreList);
                    if (normalScoreList.length != 1 &&
                        sumScoreList.length != 1) {
                      playerScoreList.removeRange(2, 4);
                    }

                    playerIdx++;

                    scoreMap[playerName] = playerScoreList;
                  }

                  print(scoreMap);
                  scoreProviderRead.setScore(scoreMap);
                  Navigator.pop(context);
                },
                child: Text('확인'))
          ],
        ),
      ),
    );

    ;
  }
}
