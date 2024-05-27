import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ppeongnote/custom_widgets/custom_widget.dart';
import 'package:ppeongnote/locator.dart';
import 'package:ppeongnote/providers/global_provider.dart';
import 'package:ppeongnote/service/shared_preferences_service.dart';
import 'package:ppeongnote/utill/custom_style.dart';
import 'package:ppeongnote/utill/routing/navigation_service.dart';
import 'package:ppeongnote/utill/routing/router_name.dart';

class RecordListScreen extends HookConsumerWidget {
  const RecordListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SharedPreferencesService sharedPreferncesService =
        locator<SharedPreferencesService>();
    List<ScoreDataInfo> getScoreData = sharedPreferncesService.getScoreData();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {}, icon: const Icon(Icons.arrow_back_ios_new)),
        title: Column(
          children: [
            const Text('게임 기록'),
            Text('총 ${getScoreData.length}건의 기록이 있습니다.',
                style: TextStyle(fontSize: 12.spMin))
          ],
        ),
      ),
      body: MainUI(),
    );
  }
}

class MainUI extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SharedPreferencesService sharedPreferncesService =
        locator<SharedPreferencesService>();
    List<ScoreDataInfo> getScoreData = sharedPreferncesService.getScoreData();
    final playerNameRead = ref.read(playerNameProvider.notifier);
    final scoreRead = ref.read(scoreProvider.notifier);
    final penaltyTitleRead = ref.read(penaltyTitleProvider.notifier);
    final penaltContentRead = ref.read(penaltContentProvider.notifier);
    final gameResultRead = ref.read(gameResultProvider.notifier);
    final penaltyContentViewRead =
        ref.read(penaltyContentViewProvider.notifier);
    final spIndexRead = ref.read(spIndexProvider.notifier);

    if (getScoreData.isEmpty) {
      return const Center(
        child: Text('기록이 없습니다.'),
      );
    } else {
      Size size = MediaQuery.of(context).size;

      return SingleChildScrollView(
        child: Container(
          width: size.width,
          height: size.height,
          decoration: CustomWidget.bgColorWidget(),
          child: ListView.builder(
              itemCount: getScoreData.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  decoration: BoxDecoration(border: CustomStyle.listDivider),
                  child: ListTile(
                    title: Text(getScoreData[index].penaltyTitle),
                    subtitle: Text(getScoreData[index].date),
                    onTap: () {
                      List<String> nameList = getScoreData[index].nameList;
                      Map<String, List<List<int>>> scoreData =
                          getScoreData[index].scoreData;
                      String penaltyTitle = getScoreData[index].penaltyTitle;
                      Map<String, String> penaltyContent =
                          getScoreData[index].penaltyContent;

                      scoreRead.setScore(scoreData);
                      playerNameRead.setPlayer(nameList);
                      penaltyTitleRead.setTitle(penaltyTitle);
                      penaltContentRead.setContent(penaltyContent);
                      gameResultRead
                          .setGameResult(getScoreData[index].resultScore);

                      penaltyContentViewRead.noView();

                      // List Index set
                      spIndexRead.setIdx(index);
                      NavigationService().routerReplace(context, ScoreRoute);
                    },
                  ),
                );
              }),
        ),
      );
    }
  }
}
