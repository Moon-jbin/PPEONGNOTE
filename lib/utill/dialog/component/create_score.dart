import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ppeongnote/custom_widgets/custom_widget.dart';
import 'package:ppeongnote/providers/score_provider.dart';

class CreateScore extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scoreProviderRead = ref.read(scoreProvider.notifier);
    final scoreProviderWatch = ref.watch(scoreProvider);
    final playerNameProviderWatch = ref.watch(playerNameProvider);
    // 3인 기준 (차후 4인 5인 컴포넌트 따로 생성 할 것)

    TextEditingController tfController_1 = useTextEditingController();
    TextEditingController tfController_2 = useTextEditingController();
    TextEditingController tfController_3 = useTextEditingController();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('점수 생성'),
        CustomWidget.playerScoreTF(
            playerName: playerNameProviderWatch[0], controller: tfController_1),
        CustomWidget.playerScoreTF(
            playerName: playerNameProviderWatch[1], controller: tfController_2),
        CustomWidget.playerScoreTF(
            playerName: playerNameProviderWatch[2], controller: tfController_3),
        TextButton(
            onPressed: () {
              if (tfController_1.text.isEmpty &&
                  tfController_2.text.isEmpty &&
                  tfController_3.text.isEmpty) return;

              //Provider엔 Map으로 나타낼 것.

              //[[일반 점수], [합계 점수]]

              // 3인 기준 (차후 4인 기준 5인 기준 나눌 것)
              int playerScore_1 = int.parse(tfController_1.text);
              int playerScore_2 = int.parse(tfController_2.text);
              int playerScore_3 = int.parse(tfController_3.text);
              List<int> tfControllerList = [
                playerScore_1,
                playerScore_2,
                playerScore_3
              ];

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
                if (normalScoreList.length != 1 && sumScoreList.length != 1) {
                  playerScoreList.removeRange(2, 4);
                }

                playerIdx++;

                scoreMap[playerName] = playerScoreList;
              }

              print(scoreMap);
              scoreProviderRead.setScore(scoreMap);
              Navigator.pop(context);
            },
            child: Text('저장'))
      ],
    );
  }
}
