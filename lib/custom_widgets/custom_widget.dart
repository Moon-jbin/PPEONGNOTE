import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ppeongnote/providers/global_provider.dart';
import 'package:ppeongnote/utill/dialog/dlg_function.dart';

class CustomWidget {
  static BoxDecoration bgColorWidget() {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.white, Colors.blue.shade100],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    );
  }

  ///```
  /// 플레이어 선택창
  /// @param {int} type - 인원 명 수 (ex : type = 3 => 3명, type = 4 => 4명 )
  ///```
  static Widget playerSelectBox(BuildContext context, {required int type}) {
    return InkWell(
        onTap: () {
          showPlayerNameDlgFn(context, type: type);
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 8.0.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 3,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '$type명',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900,
              ),
            ),
          ),
        ));
  }

  static Widget customTextField(TextEditingController controller,
      {String? hintText, TextInputType? keyboardType}) {
    return TextField(
      autofocus: true,
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: Colors.blue.shade900,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: Colors.blue.shade900,
          ),
        ),
      ),
      style: TextStyle(
        color: Colors.blue.shade900,
      ),
    );
  }

  static Widget playerScoreTF(
      {required String playerName, required TextEditingController controller}) {
    return Container(
      margin: EdgeInsets.all(10.w),
      child: Row(
        children: [
          Text("$playerName : "),
          Expanded(
              child: customTextField(controller,
                  keyboardType: TextInputType.number))
        ],
      ),
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
          return Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(playerScore),
                SizedBox(
                  width: 10.w,
                ),
                Text(playerSumScore)
              ],
            ),
          );
        }),
      ),
    );
  }

  static Widget bottomSumScore(WidgetRef ref, Size size,
      {required ValueNotifier<bool> isGameEnd}) {
    final scoreProviderWatch = ref.watch(scoreProvider);
    final playerNameProviderWatch = ref.watch(playerNameProvider);
    final gameResultWatch = ref.watch(gameResultProvider);

    return Container(
      decoration: const BoxDecoration(
          // color: Colors.red,
          borderRadius: BorderRadius.all(Radius.circular(50)),
          border: Border(top: BorderSide(color: Colors.black12, width: 5.0))),
      width: size.width,
      height: 30.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children:
            // generalScore
            List.generate(playerNameProviderWatch.length, (int playerIdx) {
          String playerSumScore = scoreProviderWatch.isEmpty
              ? "0"
              : scoreProviderWatch[playerNameProviderWatch[playerIdx]]![1]
                  .last
                  .toString();
          print('씌바 => $gameResultWatch');

          return Row(
            children: [
              Text(playerSumScore),
              isGameEnd.value
                  ? Text(" > ${gameResultWatch[playerIdx]}")
                  : Container()
            ],
          );
        }),
      ),
    );
  }
}
