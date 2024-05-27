import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SharedPreferencesService {
  void setScoreData(ScoreDataInfo scoreDataInfo);
  void updateScoreData(ScoreDataInfo scoreDataInfo, int index);
  List<ScoreDataInfo> getScoreData();

  void dataClear();
}

class SharedPreferencesServiceImp implements SharedPreferencesService {
  late SharedPreferences prefs;

  SharedPreferencesServiceImp() {
    init();
  }

  void init() async {
    prefs = await SharedPreferences.getInstance();
    await prefs.reload();
  }

  @override
  void setScoreData(ScoreDataInfo scoreDataInfo) async {
    String encode = jsonEncode(scoreDataInfo.toJson());
    List<String>? scoreList = prefs.getStringList('scoreList') ?? [];
    scoreList.add(encode);

    print("setScoreData = >$scoreList");

    await prefs.setStringList('scoreList', scoreList);
  }

  @override
  void updateScoreData(ScoreDataInfo scoreDataInfo, int index) async {
    List<String> scoreList = prefs.getStringList('scoreList') ?? [];
    List<ScoreDataInfo> decodeScoreList = [];
    for (String scoreData in scoreList) {
      decodeScoreList.add(ScoreDataInfo.fromJson(jsonDecode(scoreData)));
    }

    decodeScoreList.removeAt(index);
    decodeScoreList.insert(index, scoreDataInfo);

    // encode
    List<String> encodeScoreList = [];
    for (ScoreDataInfo scoreDataInfo in decodeScoreList) {
      String encode = jsonEncode(scoreDataInfo.toJson());
      encodeScoreList.add(encode);
    }
    await prefs.setStringList('scoreList', encodeScoreList);
  }

  @override
  List<ScoreDataInfo> getScoreData() {
    print(prefs.getStringList('scoreList'));
    List<String> scoreList = prefs.getStringList('scoreList') ?? [];
    List<ScoreDataInfo> decodeScoreList = [];
    for (String scoreData in scoreList) {
      decodeScoreList.add(ScoreDataInfo.fromJson(jsonDecode(scoreData)));
    }

    print("getScoreData => $decodeScoreList");

    return decodeScoreList;
  }

  @override
  void dataClear() {
    prefs.clear();
  }
}

class ScoreDataInfo {
  final List<String> nameList;
  final Map<String, List<List<int>>> scoreData;
  final List<String> resultScore;
  final String penaltyTitle;
  final Map<String, String> penaltyContent;
  final String date;

  ScoreDataInfo(
      {required this.nameList,
      required this.scoreData,
      required this.resultScore,
      required this.penaltyTitle,
      required this.penaltyContent,
      required this.date});

  factory ScoreDataInfo.fromJson(Map<String, dynamic> json) {
    return ScoreDataInfo(
      nameList: (json['nameList'] as List<dynamic>)
          .map((item) => item as String)
          .toList(),
      scoreData: (json['scoreData'] as Map<String, dynamic>).map(
        (key, value) => MapEntry(
          key,
          (value as List<dynamic>)
              .map((list) =>
                  (list as List<dynamic>).map((item) => item as int).toList())
              .toList(),
        ),
      ),
      resultScore: (json['resultScore'] as List<dynamic>)
          .map((item) => item as String)
          .toList(),
      penaltyTitle: json['penaltyTitle'] as String,
      penaltyContent: (json['penaltyContent'] as Map<String, dynamic>)
          .map((key, value) => MapEntry(key, value as String)),
      date: json['date'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'nameList': nameList,
        'scoreData': scoreData,
        'resultScore': resultScore,
        'penaltyTitle': penaltyTitle,
        'penaltyContent': penaltyContent,
        'date': date
      };

  toMap() {}
}
