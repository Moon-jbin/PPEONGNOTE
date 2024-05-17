import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ppeongnote/custom_widgets/custom_widget.dart';
import 'package:ppeongnote/providers/score_provider.dart';
import 'package:ppeongnote/utill/custom_style.dart';
import 'package:ppeongnote/utill/dialog/dlg_function.dart';

class ScoreScreen extends HookConsumerWidget {
  const ScoreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: const Icon(Icons.menu),
        elevation: 1,
        shadowColor: Colors.black38,
        title: Text(
          '뻥공책',
          style: CustomStyle.defaultStyle,
        ),
        actions: [
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
        child: MainUI(),
      ),
    );
  }
}

class MainUI extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    final scoreProviderWatch = ref.watch(scoreProvider);
    final playerNameProviderWatch = ref.watch(playerNameProvider);
    // 플레이어가 반드시 정해진 후 해당 페이지 호출 할것

    return Container(
      decoration: CustomWidget.bgColorWidget(),
      child: Column(
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
                        // Text(playerNameProviderWatch[playerIdx]),

                        ),
                  ),
                  scoreProviderWatch[playerNameProviderWatch[0]] == null
                      ? Container()
                      : IconButton(
                          onPressed: () {
                            showScoreCreateDlgFn(context);
                          },
                          icon: Icon(Icons.add))
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
          CustomWidget.bottomSumScore(ref, size),
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
                  height: 50.h,
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
                      Text(playerSumScore)
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
