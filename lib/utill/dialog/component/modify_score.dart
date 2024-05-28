import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ppeongnote/custom_widgets/custom_widget.dart';
import 'package:ppeongnote/providers/global_provider.dart';
import 'package:ppeongnote/utill/custom_style.dart';

class ModifyScore extends HookConsumerWidget {
  int scoreIdx;
  ModifyScore({super.key, required this.scoreIdx});

  void initScore(
    WidgetRef ref, {
    required TextEditingController tfContoller_1,
    required TextEditingController tfContoller_2,
    required TextEditingController tfContoller_3,
    required ValueNotifier<List<TextEditingController>> tfControllerList,
    TextEditingController? tfContoller_4,
    TextEditingController? tfContoller_5,
  }) {
    final scoreProviderRead = ref.read(scoreProvider.notifier);
    final scoreProviderWatch = ref.watch(scoreProvider);
    final playerNameProviderWatch = ref.watch(playerNameProvider);

    if (playerNameProviderWatch.length == 3) {
      tfControllerList.value.add(tfContoller_1);
      tfControllerList.value.add(tfContoller_2);
      tfControllerList.value.add(tfContoller_3);
    } else if (playerNameProviderWatch.length == 4) {
      tfControllerList.value.add(tfContoller_1);
      tfControllerList.value.add(tfContoller_2);
      tfControllerList.value.add(tfContoller_3);
      tfControllerList.value.add(tfContoller_4!);
    } else if (playerNameProviderWatch.length == 5) {
      tfControllerList.value.add(tfContoller_1);
      tfControllerList.value.add(tfContoller_2);
      tfControllerList.value.add(tfContoller_3);
      tfControllerList.value.add(tfContoller_4!);
      tfControllerList.value.add(tfContoller_5!);
    }
    int tfIdx = 0;
    for (String player in playerNameProviderWatch) {
      tfControllerList.value[tfIdx].text =
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
    TextEditingController tfController_4 = useTextEditingController();
    TextEditingController tfController_5 = useTextEditingController();

    ValueNotifier<List<TextEditingController>> tfControllerList = useState([]);

    useEffect(() {
      if (playerNameProviderWatch.length == 3) {
        initScore(ref,
            tfContoller_1: tfController_1,
            tfContoller_2: tfController_2,
            tfContoller_3: tfController_3,
            tfControllerList: tfControllerList);
      } else if (playerNameProviderWatch.length == 4) {
        initScore(ref,
            tfContoller_1: tfController_1,
            tfContoller_2: tfController_2,
            tfContoller_3: tfController_3,
            tfContoller_4: tfController_4,
            tfControllerList: tfControllerList);
      } else if (playerNameProviderWatch.length == 5) {
        initScore(ref,
            tfContoller_1: tfController_1,
            tfContoller_2: tfController_2,
            tfContoller_3: tfController_3,
            tfContoller_4: tfController_4,
            tfContoller_5: tfController_5,
            tfControllerList: tfControllerList);
      }
    }, []);
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomWidget.customDlgTitle(context, title: "점수를 수정하세요."),
          Column(
            children: List.generate(
                playerNameProviderWatch.length,
                (index) => CustomWidget.playerScoreTF(
                    playerName: playerNameProviderWatch[index],
                    controller: tfControllerList.value[index])),
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

                  // 3인 기준 (차후 4인 기준 5인 기준 나눌 것)
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
      ),
    );
  }
}
