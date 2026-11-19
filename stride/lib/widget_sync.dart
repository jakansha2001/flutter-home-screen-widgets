import 'package:flutter/widgets.dart';

import 'src/home_widget/stride.home_widget.dart';
import 'today.dart';

/// Write, then nudge: save everything the widget shows, then ask the OS to
/// redraw it. The widget never runs app code; it only reads what is saved here.
Future<void> updateStrideWidget(Today today, {bool fastForward = false}) async {
  await StrideHomeWidget.saveData(
    steps: today.steps,
    goal: today.goal,
    streak: today.streak,
    goalReached: today.goalReached,
    blocks: [
      for (var i = 0; i < 10; i++)
        StrideBlocksItem(filled: i < today.filledBlocks),
    ],
    timedData: _timeline(today, fastForward: fastForward),
  );
  await StrideHomeWidget.updateWidget();
}

/// One of the Dash pictures in assets/images.
AssetImage dashImage(String name) => AssetImage('assets/images/dash_$name.png');

/// How far apart the entries come in the stage demo.
const fastForwardGap = Duration(seconds: 30);

/// What the widget shows over the rest of the day, switching on its own even
/// with the app closed: a message and a Dash picture per entry.
///
/// Normally the entries follow the time of day. With [fastForward] they come
/// [fastForwardGap] apart, so the change can be watched on stage.
Map<DateTime, StrideTimedData> _timeline(
  Today today, {
  required bool fastForward,
}) {
  final now = DateTime.now();
  final dash = dashImage(today.dash);

  if (today.goalReached) {
    // Celebrate now, then Dash goes to rest: at 9 pm, or one gap later on stage.
    final restAt = fastForward
        ? now.add(fastForwardGap)
        : DateTime(now.year, now.month, now.day, 21);
    return {
      now: StrideTimedData(message: 'Goal smashed!', mascot: dash),
      if (restAt.isAfter(now))
        restAt: StrideTimedData(
          message: 'Rest up. See you tomorrow.',
          mascot: dashImage('rest'),
        ),
    };
  }

  final messages = [
    'Lace up. Every step counts.',
    'Lunch walk? ${withCommas(today.remaining)} to go.',
    'A short walk gets you there.',
    'Streak at risk. One walk saves it.',
  ];

  if (fastForward) {
    return {
      for (var i = 0; i < messages.length; i++)
        now.add(fastForwardGap * i): StrideTimedData(
          message: messages[i],
          mascot: dash,
        ),
    };
  }

  final midnight = DateTime(now.year, now.month, now.day);
  const hours = [0, 12, 17, 20];
  return {
    for (var i = 0; i < messages.length; i++)
      midnight.add(Duration(hours: hours[i])): StrideTimedData(
        message: messages[i],
        mascot: dash,
      ),
  };
}
