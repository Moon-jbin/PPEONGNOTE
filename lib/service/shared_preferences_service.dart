import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

abstract class SharedPreferencesService {
  void setScoreData(ScoreDataInfo scoreDataInfo);

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
  final List<dynamic> nameList;
  final Map<String, dynamic> scoreData;
  final List<dynamic> resultScore;
  final String penaltyTitle;
  final String date;

  ScoreDataInfo(this.nameList, this.scoreData, this.resultScore,
      this.penaltyTitle, this.date);

  ScoreDataInfo.fromJson(Map<String, dynamic> json)
      : nameList = json['nameList'] ?? '',
        scoreData = json['scoreData'] ?? {},
        resultScore = json['resultScore'] ?? [],
        penaltyTitle = json['penaltyTitle'] ?? '',
        date = json['date'] ?? '';

  Map<String, dynamic> toJson() => {
        'nameList': nameList,
        'scoreData': scoreData,
        'resultScore': resultScore,
        'penaltyTitle': penaltyTitle,
        'date': date
      };

  toMap() {}
}
