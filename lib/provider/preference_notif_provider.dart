
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:healthy_life_buddy/utils/background_service.dart';
import 'package:healthy_life_buddy/utils/date_time_helper.dart';

Future<void> scheduleSport(DateTime date) async{
  await AndroidAlarmManager.periodic(
      Duration(hours: 24),
      1,
      BackgroundService.callback,
      startAt: DateTimeHelper.format(),
      exact: true,
      wakeup: true
  );
}