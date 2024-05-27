import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ppeongnote/custom_widgets/custom_drawer.dart';
import 'package:ppeongnote/custom_widgets/custom_widget.dart';
import 'package:ppeongnote/locator.dart';
import 'package:ppeongnote/providers/global_provider.dart';
import 'package:ppeongnote/providers/score_provider.dart';
import 'package:ppeongnote/service/shared_preferences_service.dart';
import 'package:ppeongnote/utill/custom_style.dart';
import 'package:ppeongnote/utill/dialog/dlg_function.dart';

class ScoreScreen extends HookConsumerWidget {
  const ScoreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final penaltyTitleWatch = ref.watch(penaltyTitleProvider);
    final playerNameProviderWatch = ref.watch(playerNameProvider);
    final penaltyContentWatch = ref.watch(penaltContentProvider);
    final scoreFunctionRead = ref.read(scoreFunctionProvider.notifier);
    final spIndexRead = ref.read(spIndexProvider.notifier);
    final spIndexWatch = ref.watch(spIndexProvider);

    bool ismodifyPage = spIndexWatch >= 0;

    double statusBarheight = MediaQuery.of(context).viewPadding.top;

    ValueNotifier<bool> isGameEnd = useState(false);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (ismodifyPage) {
          isGameEnd.value = true;
        }
      });
      return () {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (ismodifyPage) {
            spIndexRead.initState();
          }
        });
      };
    }, []);

    return Scaffold(
      drawer: ismodifyPage
          ? null
          : Drawer(
              child: Padding(
              padding: EdgeInsets.fromLTRB(0, statusBarheight * 2, 0, 30.h),
              child: CustomDrawer(),
            )),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        shadowColor: Colors.black38,
        title: penaltyTitleWatch.isEmpty
            ? Container()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  penaltyTitleWatch.isEmpty
                      ? Container()
                      : Text(penaltyTitleWatch,
                          style: CustomStyle.defaultStyle),
                  Wrap(
                      children: List.generate(playerNameProviderWatch.length,
                          (index) {
                    if (penaltyContentWatch["${index + 1}"]!.isEmpty) {
                      return const Text("");
                    } else {
                      return Text(
                          "${index + 1}등 : ${penaltyContentWatch["${index + 1}"]}  ",
                          style: TextStyle(fontSize: 12.spMin));
                    }
                  }))
                ],
              ),
        actions: [
          TextButton(
              onPressed: () {},
              child: IconButton(
                  onPressed: () {
                    scoreFunctionRead.gameDataSave(ref, isGameEnd: isGameEnd);
                  },
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

    return Container(
      // height: size.height,
      decoration: CustomWidget.bgColorWidget(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                playerNameProviderWatch.length,
                (playerIdx) => Text(playerNameProviderWatch[playerIdx]),
              )),
          Expanded(
              flex: scoreProviderWatch[playerNameProviderWatch[0]] == null
                  ? 0
                  : 1,
              child: SingleChildScrollView(
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
                                  // Text(playerNameProviderWatch[playerIdx]),
                                  scoreProviderWatch[
                                              playerNameProviderWatch[0]] ==
                                          null
                                      ? Container()
                                      : ScoreListView(playerIdx: playerIdx)
                                ],
                              )),
                    ),
                    scoreProviderWatch[playerNameProviderWatch[0]] == null
                        ? Container()
                        : IconButton(
                            onPressed: () {
                              showScoreCreateDlgFn(context);
                            },
                            icon: const Icon(Icons.add))
                  ],
                ),
              )),
          scoreProviderWatch[playerNameProviderWatch[0]] == null
              ? Expanded(child: CustomWidget.socoreWriteStart(context))
              : Container(),
          CustomWidget.bottomSumScore(ref, size, isGameEnd: isGameEnd)
        ],
      ),
    );
  }
}

// class ScoreListView extends HookConsumerWidget {
//   const ScoreListView({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final scoreProviderWatch = ref.watch(scoreProvider);
//     final playerNameProviderWatch = ref.watch(playerNameProvider);

//     int scoreLength = scoreProviderWatch[playerNameProviderWatch[0]] != null
//         ? scoreProviderWatch[playerNameProviderWatch[0]]![0].length
//         : 0;
//     return ListView.builder(
//       itemCount: scoreLength,
//       itemBuilder: (BuildContext context, int scoreIdx) {
//         return Column(
//           children: [
//             CustomWidget.scoreListTile(context, ref, scoreIdx: scoreIdx),
//             scoreIdx == scoreLength - 1
//                 ? IconButton(
//                     onPressed: () {
//                       showScoreCreateDlgFn(context);
//                     },
//                     icon: Icon(Icons.add))
//                 : Container()
//           ],
//         );
//       },
//     );
//   }
// }

class ScoreListView extends HookConsumerWidget {
  int playerIdx;

  ScoreListView({super.key, required this.playerIdx});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scoreProviderWatch = ref.watch(scoreProvider);
    final playerNameProviderWatch = ref.watch(playerNameProvider);

    int scoreLength = scoreProviderWatch[playerNameProviderWatch[0]] != null
        ? scoreProviderWatch[playerNameProviderWatch[0]]![0].length
        : 0;

    return Container(
        width: 70.w,
        // height: 20,
        child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
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
                  height: 80.h, //50.h,
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
                      Text(
                        playerSumScore,
                        style: TextStyle(
                            color: scoreIdx == 0 ? Colors.transparent : null),
                      )
                    ],
                  ),
                ),
              );
            }));
  }
}
