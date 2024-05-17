import 'package:hooks_riverpod/hooks_riverpod.dart';

final playerNameProvider =
    StateNotifierProvider<PlayerNameProvider, List<String>>(
        (ref) => PlayerNameProvider());

final scoreProvider =
    StateNotifierProvider<ScoreProvider, Map<String, List<List<int>>>>(
        (ref) => ScoreProvider());

class PlayerNameProvider extends StateNotifier<List<String>> {
  // test
  PlayerNameProvider() : super([]);

  void initState() => state = [];

  void setPlayer(List<String> playerList) => state = playerList;
}

class ScoreProvider extends StateNotifier<Map<String, List<List<int>>>> {
  ScoreProvider() : super({});

  void initState() => state = {};
  void setScore(Map<String, List<List<int>>> scoreMap) => state = scoreMap;
}
