import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ppeongnote/custom_widgets/custom_widget.dart';
import 'package:ppeongnote/providers/global_provider.dart';
import 'package:ppeongnote/utill/custom_style.dart';
import 'package:ppeongnote/utill/dialog/dlg_function.dart';

class ScoreScreen extends HookConsumerWidget {
  const ScoreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final penaltyTitleWatch = ref.watch(penaltyTitleProvider);
    final playerNameProviderWatch = ref.watch(playerNameProvider);
    final penaltyContentWatch = ref.watch(penaltContentProvider);
    final scoreProviderWatch = ref.watch(scoreProvider);
    final gameResultRead = ref.read(gameResultProvider.notifier);

    Size size = MediaQuery.of(context).size;

    ValueNotifier<bool> isGameEnd = useState(false);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: const Icon(Icons.menu),
        elevation: 1,
        shadowColor: Colors.black38,
        title: penaltyTitleWatch.isEmpty? Container() :
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            penaltyTitleWatch.isEmpty?
                Container():
                Text('($penaltyTitleWatch)', style: CustomStyle.defaultStyle),
            Wrap(
              children: List.generate(playerNameProviderWatch.length, (index) {

                if(penaltyContentWatch["${index+1}"]!.isEmpty){
                    return const Text("");
                }else{
                  return Text(
                      "${index+1}등 : ${penaltyContentWatch["${index+1}"]}  "
                      , style: TextStyle(
                      fontSize: 12.spMin
                  ));
                }
              } ),
            )
          ],
        )

        ,
        actions: [
          TextButton(onPressed: (){

            List<int> sumScoreList = [];
            List<int> generalScoreList = [];
            //게임 결과 리스트
            List<String> gameResultList = [];
            for(int i = 0; i< playerNameProviderWatch.length; i++){
              sumScoreList.add(scoreProviderWatch[playerNameProviderWatch[i]]![1].last);
              generalScoreList.add(scoreProviderWatch[playerNameProviderWatch[i]]![1].last);
            }

            // 정렬을 함. 기존 값에다가 해당 정렬한 값을 비교해야함.
            sumScoreList.sort();

            for(int score in generalScoreList){
              int rank = 0;
              for(int sumScore in sumScoreList){
                rank++;
                if(score == sumScore){
                  print("score $score , rank : $rank, 벌칙내용 : ${penaltyContentWatch['$rank']}");
                  gameResultList.add(penaltyContentWatch['$rank']!);
                  break;
                }
              }
            }

            gameResultRead.setGameResult(gameResultList);

            isGameEnd.value = true;
          }, child: const Text('종료')),
          TextButton(
              onPressed: () {},
              child: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.save, color: Colors.blue.shade900)))
        ],
      ),
      body: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          showBackNoticeDlgFn(context);
        },
        child: MainUI(isGameEnd: isGameEnd),
      ),
    );
  }
}

class MainUI extends HookConsumerWidget {
  ValueNotifier<bool> isGameEnd;
  MainUI({super.key, required this.isGameEnd});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    final scoreProviderWatch = ref.watch(scoreProvider);
    final playerNameProviderWatch = ref.watch(playerNameProvider);


    return
          Container(
            // height: size.height,
            decoration: CustomWidget.bgColorWidget(),
            child: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Expanded(
          flex: scoreProviderWatch[playerNameProviderWatch[0]] == null
              ? 0
              : 1,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                    playerNameProviderWatch.length,
                        (playerIdx) => Column(
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(playerNameProviderWatch[playerIdx]),
                        scoreProviderWatch[
                        playerNameProviderWatch[0]] ==
                            null
                            ? Container()
                            : TestScoreListView(playerIdx: playerIdx)
                      ],
                    )
                ),
              ),
              scoreProviderWatch[playerNameProviderWatch[0]] == null
                  ? Container()
                  : IconButton(
                  onPressed: () {
                    showScoreCreateDlgFn(context);
                  },
                  icon: const Icon(Icons.add))
            ],
          )),
      scoreProviderWatch[playerNameProviderWatch[0]] == null
          ? Expanded(child: CustomWidget.socoreWriteStart(context))
          : Container(),
      // Expanded(
      //     child: Container(
      //         child: scoreProviderWatch[playerNameProviderWatch[0]] == null
      //             ? CustomWidget.socoreWriteStart(context)
      //             : const ScoreListView())),
      // ,
      CustomWidget.bottomSumScore(ref, size, isGameEnd: isGameEnd)
    ],
  ),
          );
  }
}

class ScoreListView extends HookConsumerWidget {
  const ScoreListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scoreProviderWatch = ref.watch(scoreProvider);
    final playerNameProviderWatch = ref.watch(playerNameProvider);

    int scoreLength = scoreProviderWatch[playerNameProviderWatch[0]] != null
        ? scoreProviderWatch[playerNameProviderWatch[0]]![0].length
        : 0;
    return ListView.builder(
      itemCount: scoreLength,
      itemBuilder: (BuildContext context, int scoreIdx) {
        return Column(
          children: [
            CustomWidget.scoreListTile(context, ref, scoreIdx: scoreIdx),
            scoreIdx == scoreLength - 1
                ? IconButton(
                    onPressed: () {
                      showScoreCreateDlgFn(context);
                    },
                    icon: Icon(Icons.add))
                : Container()
          ],
        );
      },
    );
  }
}

class TestScoreListView extends HookConsumerWidget {
  int playerIdx;

  TestScoreListView({super.key, required this.playerIdx});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scoreProviderWatch = ref.watch(scoreProvider);
    final playerNameProviderWatch = ref.watch(playerNameProvider);

    int scoreLength = scoreProviderWatch[playerNameProviderWatch[0]] != null
        ? scoreProviderWatch[playerNameProviderWatch[0]]![0].length
        : 0;
    print("scoreLength=> $scoreLength");

    return Container(
        width: 70.w,
        // height: 20,
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: scoreLength,
            itemBuilder: (BuildContext context, int scoreIdx) {
              String playerScore =
                  scoreProviderWatch[playerNameProviderWatch[playerIdx]]![0]
                          [scoreIdx]
                      .toString();
              String playerSumScore =
                  scoreProviderWatch[playerNameProviderWatch[playerIdx]]![1]
                          [scoreIdx]
                      .toString();
              return InkWell(
                onTap: () {
                  showScoreModifyDlgFn(context, scoreIdx: scoreIdx);
                },
                child: Container(
                  height: 80.h,//50.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        playerScore,
                        // style: TextStyle(fontSize: 25.spMin),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(playerSumScore, style: TextStyle(
                        color: scoreIdx == 0 ? Colors.transparent : null
                      ),)
                    ],
                  ),
                ),
              );
            }));
    // Column(
    //   children: [
    //     Text('점수'),
    // CustomWidget.scoreListTile(context, ref, scoreIdx: scoreIdx),
    //     // scoreIdx == scoreLength - 1
    //     //     ? IconButton(
    //     //         onPressed: () {
    //     //           showScoreCreateDlgFn(context);
    //     //         },
    //     //         icon: Icon(Icons.add))
    //     //     : Container()
    //   ],
    // );
  }
}
