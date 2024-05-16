import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ppeongnote/providers/score_provider.dart';
import 'package:ppeongnote/utill/dialog/dlg_function.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // double statusBarheight = MediaQuery.of(context).viewPadding.top;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.pink,
        leading: Icon(Icons.menu),
      ),

      body:
          //    Padding(
          // padding: EdgeInsets.only(top: statusBarheight),
          // child:
          MainUI(),
      // )
    );
  }
}

class MainUI extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    final scoreProviderWatch = ref.watch(scoreProvider);
    final playerNameProviderWatch = ref.watch(playerNameProvider);
    ValueNotifier<int> testIdx = useState(0);
    int scoreLength = scoreProviderWatch[playerNameProviderWatch[0]] != null
        ? scoreProviderWatch[playerNameProviderWatch[0]]![0].length
        : 0;

    useEffect(() {
      testIdx.value++;
    }, [scoreProviderWatch]);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(playerNameProviderWatch.length,
              (playerIdx) => Text(playerNameProviderWatch[playerIdx])),
        ),
        Expanded(
            child: Container(
          child: scoreProviderWatch[playerNameProviderWatch[0]] == null
              ? InkWell(
                  onTap: () {
                    showScoreCreateDlgFn(context);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: Text('시작'),
                  ))
              : ListView.builder(
                  itemCount: scoreLength,
                  itemBuilder: (BuildContext context, int scoreIdx) {
                    return Column(
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          onTap: () {
                            showScoreModifyDlgFn(context, scoreIdx: scoreIdx);
                          },
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children:
                                List.generate(playerNameProviderWatch.length,
                                    (int playerIdx) {
                              String playerScore = scoreProviderWatch[
                                          playerNameProviderWatch[playerIdx]]![
                                      0][scoreIdx]
                                  .toString();
                              String playerSumScore = scoreProviderWatch[
                                          playerNameProviderWatch[playerIdx]]![
                                      1][scoreIdx]
                                  .toString();
                              return Row(
                                children: [
                                  Text(playerScore),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Text(playerSumScore)
                                ],
                              );
                            }),
                          ),
                        ),
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
                ),
        )),
        Container(
          color: Colors.blue,
          width: size.width,
          height: 30.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children:
                List.generate(playerNameProviderWatch.length, (int playerIdx) {
              String playerSumScore = scoreProviderWatch.isEmpty
                  ? "0"
                  : scoreProviderWatch[playerNameProviderWatch[playerIdx]]![1]
                      .last
                      .toString();

              return Text(playerSumScore);
            }),
          ),
        )
      ],
    );
  }
}
