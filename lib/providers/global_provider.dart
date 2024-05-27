import 'package:hooks_riverpod/hooks_riverpod.dart';


// Data 담는 Provider ㅡㅡㅡㅡㅡㅡ
final playerNameProvider =
    StateNotifierProvider<PlayerNameProvider, List<String>>(
        (ref) => PlayerNameProvider());

final scoreProvider =
    StateNotifierProvider<ScoreProvider, Map<String, List<List<int>>>>(
        (ref) => ScoreProvider());
final penaltyTitleProvider =
    StateNotifierProvider<PenaltyTitleProvider, String>(
        (ref) => PenaltyTitleProvider());

final penaltContentProvider =
    StateNotifierProvider<PenaltContentProvider, Map<String, String>>(
        (ref) => PenaltContentProvider());

final gameResultProvider =
    StateNotifierProvider<GameResultProvider, List<String>>(
        (ref) => GameResultProvider());
// ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ

//벌칙 내용 표출 제한 Provider
final penaltyContentViewProvider =
    StateNotifierProvider<PenaltyContentViewProvider, bool>(
        (ref) => PenaltyContentViewProvider());

final spIndexProvider =
    StateNotifierProvider<SPIndexProvider, int>((ref) => SPIndexProvider());

class PlayerNameProvider extends StateNotifier<List<String>> {
  // test
  PlayerNameProvider() : super(['은아', '종빈', '기훈']);

  void initState() => state = [];

  void setPlayer(List<String> playerList) => state = playerList;
}

class ScoreProvider extends StateNotifier<Map<String, List<List<int>>>> {
  ScoreProvider() : super({});

  void initState() => state = {};
  void setScore(Map<String, List<List<int>>> scoreMap) => state = scoreMap;
}

class PenaltyTitleProvider extends StateNotifier<String> {
  PenaltyTitleProvider() : super("");

  void initState() => state = "";
  void setTitle(String title) => state = title;
}

class PenaltContentProvider extends StateNotifier<Map<String, String>> {
  PenaltContentProvider() : super({});

  void initState() => state = {};
  void setContent(Map<String, String> content) => state = content;
}

class GameResultProvider extends StateNotifier<List<String>> {
  GameResultProvider() : super([]);

  void initState() => state = [];
  void setGameResult(List<String> result) => state = result;
}

//벌칙 내용 표출 제한 Provider
class PenaltyContentViewProvider extends StateNotifier<bool> {
  PenaltyContentViewProvider() : super(false);

  void initState() => state = false;
  void noView() => state = true;
}

//SharedPreference Index Provider
class SPIndexProvider extends StateNotifier<int> {
  SPIndexProvider() : super(-1);

  void initState() => state = -1;
  void setIdx(int idx) => state = idx;
}
