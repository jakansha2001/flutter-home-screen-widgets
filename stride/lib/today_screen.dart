import 'dart:async';

import 'package:flutter/material.dart';

import 'src/home_widget/stride.home_widget.dart';
import 'theme.dart';
import 'today.dart';
import 'widget_sync.dart';

class TodayScreen extends StatefulWidget {
  const TodayScreen({super.key});

  @override
  State<TodayScreen> createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {
  Today _today = const Today(steps: 0, goal: 10000, pastStreak: 0);
  StreamSubscription<Uri>? _widgetTaps;

  @override
  void initState() {
    super.initState();
    _restore();
    // Listen: a tap on the widget opens the app, from cold start or while running.
    _widgetTaps = StrideHomeWidget.launchedFromWidget().listen(
      (_) => _showLogWalk(),
    );
  }

  @override
  void dispose() {
    _widgetTaps?.cancel();
    super.dispose();
  }

  /// The widget's saved data doubles as the app's storage.
  Future<void> _restore() async {
    final saved = await StrideHomeWidget.getData();
    final steps = saved.steps ?? 0;
    final goal = saved.goal ?? 10000;
    final reached = saved.goalReached ?? false;
    final streak = saved.streak ?? 0;
    if (!mounted) return;
    setState(() {
      _today = Today(
        steps: steps,
        goal: goal,
        pastStreak: reached ? streak - 1 : streak,
      );
    });
  }

  Future<void> _update(Today next, {bool fastForward = false}) async {
    setState(() => _today = next);
    await updateStrideWidget(next, fastForward: fastForward);
  }

  void _showLogWalk() {
    if (!mounted) return;
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: StrideColors.surface,
      builder: (context) => _LogWalkSheet(
        remaining: _today.remaining,
        onAdd: (count) {
          Navigator.pop(context);
          _update(_today.addSteps(count));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final today = _today;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
          children: [
            Row(
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'STRIDE',
                        style: TextStyle(
                          fontFamily: numbers,
                          fontWeight: FontWeight.w800,
                          fontSize: 48,
                          height: 1,
                          letterSpacing: 2,
                          color: StrideColors.white,
                        ),
                      ),
                      SizedBox(height: 4),
                      _Label("TODAY'S WALK"),
                    ],
                  ),
                ),
                // The same Dash the widget shows.
                ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image(
                    image: dashImage(today.dash),
                    width: 120,
                    height: 120,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _StepsHeadline(today: today),
            const SizedBox(height: 20),
            _Blocks(filled: today.filledBlocks),
            const SizedBox(height: 28),
            _StreakRow(today: today),
            const SizedBox(height: 40),
            FilledButton(
              onPressed: () => _update(today.addSteps(1000)),
              child: const Text('+1,000 STEPS'),
            ),
            const SizedBox(height: 32),
            const _Label('DAILY GOAL'),
            const SizedBox(height: 8),
            SegmentedButton<int>(
              segments: const [
                ButtonSegment(value: 5000, label: Text('5k')),
                ButtonSegment(value: 8000, label: Text('8k')),
                ButtonSegment(value: 10000, label: Text('10k')),
              ],
              selected: {today.goal},
              showSelectedIcon: false,
              onSelectionChanged: (goal) =>
                  _update(today.copyWith(goal: goal.first)),
            ),
            const SizedBox(height: 40),
            _DemoControls(
              onNewDay: () => _update(today.startNewDay()),
              onRemoveSteps: () => _update(today.addSteps(-1000)),
              onFastForward: () => _update(today, fastForward: true),
              onStreakChange: (delta) => _update(
                today.copyWith(
                  pastStreak: (today.pastStreak + delta).clamp(0, 999),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StepsHeadline extends StatelessWidget {
  const _StepsHeadline({required this.today});

  final Today today;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          withCommas(today.steps),
          style: TextStyle(
            fontFamily: numbers,
            fontWeight: FontWeight.w800,
            fontSize: 112,
            height: 0.9,
            color: today.goalReached ? StrideColors.lime : StrideColors.white,
          ),
        ),
        Text(
          today.goalReached
              ? 'GOAL REACHED'
              : '${withCommas(today.remaining)} TO GO  ·  GOAL ${withCommas(today.goal)}',
          style: const TextStyle(
            fontFamily: numbers,
            fontWeight: FontWeight.w600,
            fontSize: 18,
            letterSpacing: 1,
            color: StrideColors.muted,
          ),
        ),
      ],
    );
  }
}

/// The same ten blocks the widget shows.
class _Blocks extends StatelessWidget {
  const _Blocks({required this.filled});

  final int filled;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < 10; i++)
          Expanded(
            child: Container(
              height: 10,
              margin: EdgeInsets.only(right: i == 9 ? 0 : 6),
              decoration: BoxDecoration(
                color: i < filled ? StrideColors.lime : StrideColors.track,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
      ],
    );
  }
}

class _StreakRow extends StatelessWidget {
  const _StreakRow({required this.today});

  final Today today;

  @override
  Widget build(BuildContext context) {
    final color = today.goalReached ? StrideColors.orange : StrideColors.muted;
    return Row(
      children: [
        Icon(Icons.local_fire_department, color: color, size: 32),
        const SizedBox(width: 6),
        Text(
          '${today.streak}',
          style: TextStyle(
            fontFamily: numbers,
            fontWeight: FontWeight.w800,
            fontSize: 32,
            color: color,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          today.goalReached ? 'day streak' : 'day streak · walk to keep it',
          style: const TextStyle(color: StrideColors.muted, fontSize: 15),
        ),
      ],
    );
  }
}

class _Label extends StatelessWidget {
  const _Label(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontFamily: numbers,
        fontWeight: FontWeight.w600,
        fontSize: 14,
        letterSpacing: 2,
        color: StrideColors.muted,
      ),
    );
  }
}

/// Stage-only shortcuts, kept visibly separate from the real app.
class _DemoControls extends StatelessWidget {
  const _DemoControls({
    required this.onNewDay,
    required this.onRemoveSteps,
    required this.onFastForward,
    required this.onStreakChange,
  });

  final VoidCallback onNewDay;
  final VoidCallback onRemoveSteps;
  final VoidCallback onFastForward;
  final ValueChanged<int> onStreakChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: StrideColors.track),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _Label('DEMO CONTROLS'),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              OutlinedButton(onPressed: onNewDay, child: const Text('New day')),
              OutlinedButton(
                onPressed: onRemoveSteps,
                child: const Text('−1,000 steps'),
              ),
              OutlinedButton(
                onPressed: onFastForward,
                child: const Text('Nudges every 30 s'),
              ),
              _StreakStepper(onChange: onStreakChange),
            ],
          ),
        ],
      ),
    );
  }
}

/// "−  streak  +" in one pill, the same height and outline as the other buttons.
class _StreakStepper extends StatelessWidget {
  const _StreakStepper({required this.onChange});

  final ValueChanged<int> onChange;

  @override
  Widget build(BuildContext context) {
    final outline = Theme.of(context).colorScheme.outline;
    return Container(
      height: 40,
      decoration: ShapeDecoration(
        shape: StadiumBorder(side: BorderSide(color: outline)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () => onChange(-1),
            icon: const Icon(Icons.remove, size: 18),
            color: StrideColors.lime,
            visualDensity: VisualDensity.compact,
            tooltip: 'Streak −1',
          ),
          const Text('streak', style: TextStyle(color: StrideColors.lime)),
          IconButton(
            onPressed: () => onChange(1),
            icon: const Icon(Icons.add, size: 18),
            color: StrideColors.lime,
            visualDensity: VisualDensity.compact,
            tooltip: 'Streak +1',
          ),
        ],
      ),
    );
  }
}

/// Opened by a tap on the widget: log a walk right away.
class _LogWalkSheet extends StatelessWidget {
  const _LogWalkSheet({required this.remaining, required this.onAdd});

  final int remaining;
  final ValueChanged<int> onAdd;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'BACK FROM A WALK?',
            style: TextStyle(
              fontFamily: numbers,
              fontWeight: FontWeight.w800,
              fontSize: 28,
            ),
          ),
          if (remaining > 0)
            Text(
              '${withCommas(remaining)} steps to go today.',
              style: const TextStyle(color: StrideColors.muted),
            ),
          const SizedBox(height: 20),
          Row(
            children: [
              for (final count in [1000, 2500, 5000]) ...[
                Expanded(
                  child: FilledButton(
                    onPressed: () => onAdd(count),
                    child: Text('+${withCommas(count)}'),
                  ),
                ),
                if (count != 5000) const SizedBox(width: 8),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
