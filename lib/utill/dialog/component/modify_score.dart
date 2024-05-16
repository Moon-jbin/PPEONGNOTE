import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ppeongnote/custom_widgets/custom_widget.dart';
import 'package:ppeongnote/providers/score_provider.dart';

class ModifyScore extends HookConsumerWidget {
  int scoreIdx;
  ModifyScore({super.key, required this.scoreIdx});

  void initScore(
    WidgetRef ref, {
    required TextEditingController tfContoller_1,
    required TextEditingController tfContoller_2,
    required TextEditingController tfContoller_3,
    TextEditingController? tfContoller_4,
    TextEditingController? tfContoller_5,
  }) {
    final scoreProviderRead = ref.read(scoreProvider.notifier);
    final scoreProviderWatch = ref.watch(scoreProvider);
    final playerNameProviderWatch = ref.watch(playerNameProvider);

    List<TextEditingController> tfControllerList = [];

    if (playerNameProviderWatch.length == 3) {
      tfControllerList.add(tfContoller_1);
      tfControllerList.add(tfContoller_2);
      tfControllerList.add(tfContoller_3);
    } else if (playerNameProviderWatch.length == 4) {
      tfControllerList.add(tfContoller_1);
      tfControllerList.add(tfContoller_2);
      tfControllerList.add(tfContoller_3);
      tfControllerList.add(tfContoller_4!);
    } else if (playerNameProviderWatch.length == 5) {
      tfControllerList.add(tfContoller_1);
      tfControllerList.add(tfContoller_2);
      tfControllerList.add(tfContoller_3);
      tfControllerList.add(tfContoller_4!);
      tfControllerList.add(tfContoller_5!);
    }
    int tfIdx = 0;
    for (String player in playerNameProviderWatch) {
      tfControllerList[tfIdx].text =
          scoreProviderWatch[player]![0][scoreIdx].toString();
      tfIdx++;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scoreProviderRead = ref.read(scoreProvider.notifier);
    final scoreProviderWatch = ref.watch(scoreProvider);
    final playerNameProviderWatch = ref.watch(playerNameProvider);
    // 3인 기준 (차후 4인 5인 컴포넌트 따로 생성 할 것)

    TextEditingController tfController_1 = useTextEditingController();
    TextEditingController tfController_2 = useTextEditingController();
    TextEditingController tfController_3 = useTextEditingController();

    useEffect(() {
      if (playerNameProviderWatch.length == 3) {
        initScore(ref,
            tfContoller_1: tfController_1,
            tfContoller_2: tfController_2,
            tfContoller_3: tfController_3);
      } else if (playerNameProviderWatch.length == 4) {
        initScore(
          ref,
          tfContoller_1: tfController_1,
          tfContoller_2: tfController_2,
          tfContoller_3: tfController_3,
          // tfContoller_4: tfController_4,
        );
      } else if (playerNameProviderWatch.length == 5) {
        initScore(
          ref,
          tfContoller_1: tfController_1,
          tfContoller_2: tfController_2,
          tfContoller_3: tfController_3,
          // tfContoller_4: tfController_4,
          // tfContoller_5: tfController_5,
        );
      }
    }, []);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('점수 수정'),
        CustomWidget.playerScoreTF(
            playerName: playerNameProviderWatch[0], controller: tfController_1),
        CustomWidget.playerScoreTF(
            playerName: playerNameProviderWatch[1], controller: tfController_2),
        CustomWidget.playerScoreTF(
            playerName: playerNameProviderWatch[2], controller: tfController_3),
        TextButton(
            onPressed: () {
              if (tfController_1.text.isEmpty ||
                  tfController_2.text.isEmpty ||
                  tfController_3.text.isEmpty) return;

              // 3인 기준 (차후 4인 기준 5인 기준 나눌 것)
              int playerScore_1 = int.parse(tfController_1.text);
              int playerScore_2 = int.parse(tfController_2.text);
              int playerScore_3 = int.parse(tfController_3.text);
              List<int> tfControllerList = [
                playerScore_1,
                playerScore_2,
                playerScore_3
              ];

              int tfIdx = 0;
              Map<String, List<List<int>>> scoreMap = {};
              for (String player in playerNameProviderWatch) {
                //일반 점수
                scoreProviderWatch[player]![0][scoreIdx] =
                    tfControllerList[tfIdx];

                //합계 점수
                List<int> sumScoreList = scoreProviderWatch[player]![1];

                //합계점수를 0으로 전부 초기화
                for (int i = 0; i < sumScoreList.length; i++) {
                  scoreProviderWatch[player]![1][i] = 0;
                }

                //일반 점수와 계산하여 다시 합계점수 출력
                List<int> normalScoreList = scoreProviderWatch[player]![0];

                int sumScore = 0;
                List<int> sumScoreListTest = [];

                for (int normalScore in normalScoreList) {
                  sumScore += normalScore;

                  sumScoreListTest.add(sumScore);
                }
               
                scoreMap[player] = [normalScoreList, sumScoreListTest];
                tfIdx++;
              }
              scoreProviderRead.setScore(scoreMap);
              Navigator.pop(context);

          
            },
            child: Text('저장'))
      ],
    );
  }
}
