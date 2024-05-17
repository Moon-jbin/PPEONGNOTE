import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ppeongnote/utill/routing/navigation_service.dart';
import 'package:ppeongnote/utill/routing/router_name.dart';

class ScoreBackNotice extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('종료 하시겠습니까?'),
        TextButton(
            onPressed: () {
              NavigationService().routerGO(context, HomeRoute);
            },
            child: Text('확인'))
      ],
    );
  }
}
