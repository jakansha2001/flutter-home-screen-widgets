import 'package:flutter/material.dart' show Icons;
import 'package:home_widget_generator/home_widget_generator.dart';

// Night run palette.
const _background = HWColor.fixed(0xFF111418);
const _lime = HWColor.fixed(0xFFC6FF3D);
const _orange = HWColor.fixed(0xFFFF7A1A);
const _white = HWColor.fixed(0xFFF5F7FA);
const _muted = HWColor.fixed(0xFF8A9099);
const _track = HWColor.fixed(0xFF2A2F37);

// The data the app saves for the widget.
const _steps = HWInt('steps', defaultValue: 0, previewValue: 6240);
const _goal = HWInt('goal', defaultValue: 10000);
const _streak = HWInt('streak', defaultValue: 0, previewValue: 12);
const _goalReached = HWBool('goalReached', defaultValue: false);
const _message = HWTimedData(
  HWString(
    'message',
    defaultValue: 'Lace up. Every step counts.',
    previewValue: 'A short walk gets you there',
  ),
);
// Dash changes with progress, and on a schedule (goal reached -> resting).
const _mascot = HWTimedData(
  HWImageData('mascot', previewAsset: 'assets/images/dash_walk.png'),
);

const _font = 'BarlowCondensed';

const _stepsStyle = HWTextStyle(
  fontFamily: _font,
  fontWeight: HWFontWeight.w800,
  fontSize: 40,
);
const _stepsWhite = HWText(
  _steps,
  style: HWTextStyle(baseStyle: _stepsStyle, color: _white),
);
const _stepsLime = HWText(
  _steps,
  style: HWTextStyle(baseStyle: _stepsStyle, color: _lime),
);

const _streakStyle = HWTextStyle(
  fontFamily: _font,
  fontWeight: HWFontWeight.w800,
  fontSize: 20,
);
const _streakOn = HWRow(
  spacing: 2,
  children: [
    HWIcon.fixed(Icons.local_fire_department, size: 20, color: _orange),
    HWText(
      _streak,
      style: HWTextStyle(baseStyle: _streakStyle, color: _orange),
    ),
  ],
);
const _streakOff = HWRow(
  spacing: 2,
  children: [
    HWIcon.fixed(Icons.local_fire_department, size: 20, color: _muted),
    HWText(
      _streak,
      style: HWTextStyle(baseStyle: _streakStyle, color: _muted),
    ),
  ],
);

const _blockOn = HWSizedBox(
  width: 13,
  height: 8,
  child: HWDecoratedBox(
    decoration: HWBoxDecoration(
      color: _lime,
      borderRadius: HWBorderRadius.circular(4),
    ),
    child: HWSizedBox.expand(),
  ),
);
const _blockOff = HWSizedBox(
  width: 13,
  height: 8,
  child: HWDecoratedBox(
    decoration: HWBoxDecoration(
      color: _track,
      borderRadius: HWBorderRadius.circular(4),
    ),
    child: HWSizedBox.expand(),
  ),
);

@HomeWidget(
  name: 'Stride',
  description: 'Your steps today and your streak.',
  widgetUrl: 'stride://today',
  android: HomeWidgetAndroidConfiguration(
    targetCellWidth: 4,
    targetCellHeight: 2,
    backgroundColor: _background,
  ),
  iOS: HomeWidgetIOSConfiguration(
    groupId: 'group.dev.akanshajain.stride',
    supportedFamilies: [HWWidgetFamily.systemMedium],
    backgroundColor: _background,
  ),
  widget: HWRow(
    spacing: 10,
    children: [
      // Numbers on the left, taking the room Dash leaves.
      HWSizedBox.expand(
        child: HWColumn(
          crossAxisAlignment: HWCrossAxisAlignment.start,
          mainAxisAlignment: HWMainAxisAlignment.spaceBetween,
          children: [
            // Top: label on the left, streak on the right.
            HWRow(
              mainAxisAlignment: HWMainAxisAlignment.spaceBetween,
              children: [
                HWText.fixed(
                  'TODAY',
                  style: HWTextStyle(
                    fontFamily: _font,
                    fontWeight: HWFontWeight.w600,
                    fontSize: 14,
                    color: _muted,
                  ),
                ),
                HWBoolConditional(
                  data: _goalReached,
                  whenTrue: _streakOn,
                  whenFalse: _streakOff,
                ),
              ],
            ),
            // Steps: turns lime once the goal is reached.
            HWRow(
              crossAxisAlignment: HWCrossAxisAlignment.baseline,
              spacing: 6,
              children: [
                HWBoolConditional(
                  data: _goalReached,
                  whenTrue: _stepsLime,
                  whenFalse: _stepsWhite,
                ),
                HWText.fixed(
                  '/',
                  style: HWTextStyle(
                    fontFamily: _font,
                    fontSize: 18,
                    color: _muted,
                  ),
                ),
                HWText(
                  _goal,
                  style: HWTextStyle(
                    fontFamily: _font,
                    fontSize: 18,
                    color: _muted,
                  ),
                ),
              ],
            ),
            // Progress: ten blocks, one per tenth of the goal.
            HWRow.builder(
              'blocks',
              maxItems: 10,
              spacing: 4,
              item: HWBoolConditional(
                data: HWItemData(
                  HWBool('filled', defaultValue: false),
                  previewValues: [
                    true, true, true, true, true, true, //
                    false, false, false, false,
                  ],
                ),
                whenTrue: _blockOn,
                whenFalse: _blockOff,
              ),
            ),
            // A nudge that changes through the day on its own.
            HWText(
              _message,
              style: HWTextStyle(
                fontFamily: _font,
                fontWeight: HWFontWeight.w500,
                fontSize: 15,
                color: _white,
              ),
            ),
          ],
        ),
      ),
      // Dash on the right.
      HWImage(
        _mascot,
        width: 120,
        height: 120,
        fit: HWImageFit.cover,
        semanticLabel: 'Dash',
      ),
    ],
  ),
)
class Stride {}
