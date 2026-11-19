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
      for (var i = 0; i < 10; i++) StrideBlocksItem(filled: i < today.filledBlocks),
    ],
    timedData: _nudges(today, fastForward: fastForward),
  );
  await StrideHomeWidget.updateWidget();
}

/// How far apart the messages come in the stage demo.
const fastForwardGap = Duration(seconds: 30);

/// Messages the widget switches between on its own, even with the app closed.
///
/// Normally they follow the time of day. With [fastForward] the same messages
/// come [fastForwardGap] apart, so the change can be watched on stage.
Map<DateTime, StrideTimedData> _nudges(Today today, {required bool fastForward}) {
  final now = DateTime.now();
  if (today.goalReached) {
    return {now: const StrideTimedData(message: 'Goal smashed. See you tomorrow.')};
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
        now.add(fastForwardGap * i): StrideTimedData(message: messages[i]),
    };
  }

  final midnight = DateTime(now.year, now.month, now.day);
  const hours = [0, 12, 17, 20];
  return {
    for (var i = 0; i < messages.length; i++)
      midnight.add(Duration(hours: hours[i])): StrideTimedData(message: messages[i]),
  };
}
