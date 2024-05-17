import 'package:flutter/material.dart';
import 'package:ppeongnote/utill/dialog/component/create_score.dart';
import 'package:ppeongnote/utill/dialog/component/modify_score.dart';
import 'package:ppeongnote/utill/dialog/component/player_name.dart';
import 'package:ppeongnote/utill/dialog/component/scoreback_notice.dart';
import 'package:ppeongnote/utill/dialog/dlg_form.dart';

///```
/// Example
///```
// showWifiEnableDlgFn(BuildContext context) {
//   return showCustomDialog(
//       context,
//       (context) => customDialogForm(
//               content: OkDialog(
//             okText: tr('popup_ok_btn_2'),
//             imagePath: scopeImagePath,
//             title: tr('customer_connect_help_2_subtitle'),
//             msg: tr('customer_connect_help_5_msg'),
//             onTap: () {
//               Navigator.pop(context);
//               WiFiForIoTPlugin.setEnabled(true, shouldOpenSettings: true);
//             },
//           )));
// }

///```
/// 점수 생성 Dlg
///```
showScoreCreateDlgFn(BuildContext context) {
  return showCustomDialog(
      context, (context) => customDialogForm(content: CreateScore()));
}

///```
/// 점수 수정 Dlg
///```
showScoreModifyDlgFn(BuildContext context, {required int scoreIdx}) {
  return showCustomDialog(context,
      (context) => customDialogForm(content: ModifyScore(scoreIdx: scoreIdx)));
}

///```
/// Player 이름 생성 Dlg
///```
showPlayerNameDlgFn(BuildContext context, {required int type}) {
  return showCustomDialog(
      context, (context) => customDialogForm(content: PlayerName(type: type)));
}

///```
/// 스코어 페이지에서 뒤로갈 때 나오는 Dlg
///```
showBackNoticeDlgFn(BuildContext context) {
  return showCustomDialog(
      context, (context) => customDialogForm(content: ScoreBackNotice()));
}
