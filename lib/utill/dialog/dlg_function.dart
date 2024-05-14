import 'package:flutter/material.dart';
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

showScoreCreateDlgFn(BuildContext context) {
  return showCustomDialog(
      context, (context) => customDialogForm(content: Text('점수 수정')));
}
