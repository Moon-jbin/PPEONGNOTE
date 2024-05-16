import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ppeongnote/providers/score_provider.dart';
import 'package:ppeongnote/utill/dialog/dlg_function.dart';

class CustomWidget {
  ///```
  /// 플레이어 선택창
  /// @param {int} type - 인원 명 수 (ex : type = 3 => 3명, type = 4 => 4명 )
  ///```
  static Widget playerSelectBox({required int type}) {
    return InkWell(
      onTap: () {
        
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.all(10.w),
        width: 200.w,
        height: 100.h,
        color: Colors.grey,
        child: Text(
          "$type명",
          style: TextStyle(fontSize: 25.spMin, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  static Widget playerScoreTF(
      {required String playerName, required TextEditingController controller}) {
    return Row(
      children: [
        Text(playerName),
        Container(
            width: 100,
            height: 20,
            child: TextField(
              keyboardType: TextInputType.number,
              controller: controller,
              style: TextStyle(fontSize: 14),
              decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.zero),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.zero),
              ),
            ))
      ],
    );
  }

  static Widget socoreWriteStart(BuildContext context) {
    return InkWell(
        onTap: () {
          showScoreCreateDlgFn(context);
        },
        child: Container(
          alignment: Alignment.center,
          child: Text(
            '시작',
            style: TextStyle(fontSize: 25.spMin, fontWeight: FontWeight.bold),
          ),
        ));
  }

  static Widget scoreListTile(BuildContext context, WidgetRef ref,
      {required int scoreIdx}) {
    final playerNameProviderWatch = ref.watch(playerNameProvider);
    final scoreProviderWatch = ref.watch(scoreProvider);
    return ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: () {
        showScoreModifyDlgFn(context, scoreIdx: scoreIdx);
      },
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children:
            List.generate(playerNameProviderWatch.length, (int playerIdx) {
          String playerScore =
              scoreProviderWatch[playerNameProviderWatch[playerIdx]]![0]
                      [scoreIdx]
                  .toString();
          String playerSumScore =
              scoreProviderWatch[playerNameProviderWatch[playerIdx]]![1]
                      [scoreIdx]
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
    );
  }

  static Widget bottomSumScore(WidgetRef ref, Size size) {
    final scoreProviderWatch = ref.watch(scoreProvider);
    final playerNameProviderWatch = ref.watch(playerNameProvider);
    return Container(
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
    );
  }
}
