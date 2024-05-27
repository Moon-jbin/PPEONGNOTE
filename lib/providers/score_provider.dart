import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ppeongnote/locator.dart';
import 'package:ppeongnote/providers/global_provider.dart';
import 'package:ppeongnote/service/shared_preferences_service.dart';

final scoreFunctionProvider =
    StateNotifierProvider<ScoreFunctionProvider, Function>(
        (ref) => ScoreFunctionProvider());

class ScoreFunctionProvider extends StateNotifier<Function> {
  ScoreFunctionProvider() : super(() {});

  void gameDataSave(WidgetRef ref, {required ValueNotifier<bool> isGameEnd}) {
    final penaltyTitleWatch = ref.watch(penaltyTitleProvider);
    final playerNameProviderWatch = ref.watch(playerNameProvider);
    final penaltyContentWatch = ref.watch(penaltContentProvider);
    final scoreProviderWatch = ref.watch(scoreProvider);
    final gameResultRead = ref.read(gameResultProvider.notifier);
    final spIndexWatch = ref.watch(spIndexProvider);
    // final penaltyContentViewWatch = ref.watch(penaltyContentViewProvider);
    // final spIndexWatch = ref.watch(spIndexProvider);

    final SharedPreferencesService sharedPreferncesService =
        locator<SharedPreferencesService>();
    //종료 구간
    List<int> sumScoreList = [];
    List<int> generalScoreList = [];
    //게임 결과 리스트
    List<String> gameResultList = [];
    for (int i = 0; i < playerNameProviderWatch.length; i++) {
      sumScoreList.add(scoreProviderWatch[playerNameProviderWatch[i]]![1].last);
      generalScoreList
          .add(scoreProviderWatch[playerNameProviderWatch[i]]![1].last);
    }

    // 정렬을 함. 기존 값에다가 해당 정렬한 값을 비교해야함.
    sumScoreList.sort();

    for (int score in generalScoreList) {
      int rank = 0;
      for (int sumScore in sumScoreList) {
        rank++;
        if (score == sumScore) {
          print(
              "score $score , rank : $rank, 벌칙내용 : ${penaltyContentWatch['$rank']}");
          gameResultList.add(penaltyContentWatch['$rank']!);
          break;
        }
      }
    }

    gameResultRead.setGameResult(gameResultList);

    isGameEnd.value = true;

    //ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
    //저장 구간

    // String customCurrentTime =
    //     '$year년 $month월 $day일 $hour시 $minute분 $second초';
    // String customCurrentTime_2 =
    //     '$year/$month/$day $hour:$minute:$second';

    //결과 저장
    //이름리스트,스코어 데이터, 벌칙 내용, 벌칙 주제,

    DateTime currentData = DateTime.now();
    int year = currentData.year;
    int month = currentData.month;
    int day = currentData.day;

    String customCurrentTime = '$year/$month/$day';
    // print(customCurrentTime);

    if (spIndexWatch >= 0) {
      sharedPreferncesService.updateScoreData(
          ScoreDataInfo(
              nameList: playerNameProviderWatch,
              scoreData: scoreProviderWatch,
              resultScore: gameResultList,
              penaltyTitle: penaltyTitleWatch,
              penaltyContent: penaltyContentWatch,
              date: customCurrentTime),
          spIndexWatch);
    } else {
      sharedPreferncesService.setScoreData(ScoreDataInfo(
          nameList: playerNameProviderWatch,
          scoreData: scoreProviderWatch,
          resultScore: gameResultList,
          penaltyTitle: penaltyTitleWatch,
          penaltyContent: penaltyContentWatch,
          date: customCurrentTime));
    }

    print(
        "mjb sharedPreference Data : ${sharedPreferncesService.getScoreData()}");
  }
}
