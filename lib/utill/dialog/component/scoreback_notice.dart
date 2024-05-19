import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ppeongnote/providers/global_provider.dart';
import 'package:ppeongnote/utill/routing/navigation_service.dart';
import 'package:ppeongnote/utill/routing/router_name.dart';

class ScoreBackNotice extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scoreProviderRead = ref.read(scoreProvider.notifier);
    final playerNameProviderRead = ref.read(playerNameProvider.notifier);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('종료 하시겠습니까?'),
        TextButton(
            onPressed: () {
              scoreProviderRead.initState();
              playerNameProviderRead.initState();
              NavigationService().routerGO(context, HomeRoute);
            },
            child: Text('확인'))
      ],
    );
  }
}
