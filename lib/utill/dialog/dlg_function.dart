import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ppeongnote/providers/global_provider.dart';
import 'package:ppeongnote/providers/score_provider.dart';
import 'package:ppeongnote/utill/dialog/component/create_score.dart';
import 'package:ppeongnote/utill/dialog/component/modify_score.dart';
import 'package:ppeongnote/utill/dialog/component/penalty_dlg.dart';
import 'package:ppeongnote/utill/dialog/component/player_name.dart';
import 'package:ppeongnote/utill/dialog/component/scoreback_notice.dart';
import 'package:ppeongnote/utill/dialog/dlg_form.dart';
import 'package:ppeongnote/utill/routing/navigation_service.dart';
import 'package:ppeongnote/utill/routing/router_name.dart';

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
showBackNoticeDlgFn(BuildContext context, WidgetRef ref) {
  final scoreProviderRead = ref.read(scoreProvider.notifier);
  final playerNameProviderRead = ref.read(playerNameProvider.notifier);
  return showCustomDialog(
      context,
      (context) => customDialogForm(
              content: OkCancelDlg(
            title: "종료 하시겠습니까?",
            onTap: () {
              scoreProviderRead.initState();
              playerNameProviderRead.initState();
              NavigationService().routerGO(context, HomeRoute);
            },
          )));
}

///```
/// 벌칙 입력 Dlg
///```
showPenaltyDlgFn(BuildContext context, {required int type}) {
  return showCustomDialog(
      context, (context) => customDialogForm(content: PenaltyDlg(type: type)));
}

///```
/// 저장 클릭시 나올 Dlg
///```
showSaveDlgFn(BuildContext context, WidgetRef ref,
    {required ValueNotifier<bool> isGameEnd}) {
  final scoreFunctionRead = ref.read(scoreFunctionProvider.notifier);
  final spIndexWatch = ref.watch(spIndexProvider);
  bool isModifyPage = spIndexWatch >= 0;
  return showCustomDialog(
      context,
      (context) => customDialogForm(
          content: OkCancelDlg(
              title:
                  isModifyPage ? "저장 하시겠습니까?" : "저장 하시겠습니까?\n저장 후 홈으로 이동합니다.",
              onTap: () {
                scoreFunctionRead.gameDataSave(context, ref,
                    isGameEnd: isGameEnd);
              })));
}
