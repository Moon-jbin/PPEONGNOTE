import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:ppeongnote/locator.dart';
import 'package:ppeongnote/service/shared_preferences_service.dart';

class CustomDrawer extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SharedPreferencesService sharedPreferncesService =
        locator<SharedPreferencesService>();
    List<ScoreDataInfo> getScoreData = sharedPreferncesService.getScoreData();
    List<String> settingTitle = ["게임 기록", "설정"];
    ValueNotifier<String> versionCode = useState('');

    void initVersion() async {
      final PackageInfo packageInfo = await PackageInfo.fromPlatform();
      versionCode.value = packageInfo.version;
    }

    useEffect(() {
      initVersion();
      return null;
    }, []);

    return Column(
      children: [
        Column(
          children: List.generate(
            settingTitle.length,
            (index) => Container(
                decoration: BoxDecoration(
                  border:
                      Border(bottom: BorderSide(color: Colors.grey.shade300)),
                ),
                child: ListTile(
                  title: Text(settingTitle[index]),
                )),
          ),
        ),
        Spacer(),
        Text('Ver $versionCode')
      ],
    );

    // ListView.builder(
    //   itemCount: getScoreData.length,
    //   itemBuilder: (BuildContext context, int index) {
    //     return ListTile(
    //       title: Text(getScoreData[index].penaltyTitle),
    //       subtitle: Text(getScoreData[index].date),
    //     );
    //   },
    // );
  }
}
