/// Today's walking progress. Plain Dart, no Flutter and no widget code.
class Today {
  const Today({required this.steps, required this.goal, required this.pastStreak});

  final int steps;
  final int goal;

  /// Days in a row the goal was reached, not counting today.
  final int pastStreak;

  bool get goalReached => steps >= goal;

  /// The streak shown to the user: today counts once the goal is reached.
  int get streak => pastStreak + (goalReached ? 1 : 0);

  int get remaining => goalReached ? 0 : goal - steps;

  /// How many of the ten progress blocks are filled.
  int get filledBlocks => (steps * 10 ~/ goal).clamp(0, 10);

  Today copyWith({int? steps, int? goal, int? pastStreak}) => Today(
        steps: steps ?? this.steps,
        goal: goal ?? this.goal,
        pastStreak: pastStreak ?? this.pastStreak,
      );

  Today addSteps(int count) => copyWith(steps: steps + count);

  /// Midnight: a reached goal extends the streak, a missed one ends it.
  Today startNewDay() =>
      copyWith(steps: 0, pastStreak: goalReached ? pastStreak + 1 : 0);
}

/// 10000 -> "10,000"
String withCommas(int value) => value.toString().replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (_) => ',',
    );
