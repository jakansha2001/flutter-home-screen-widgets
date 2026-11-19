import 'package:flutter/material.dart' show Icons;
import 'package:home_widget_generator/home_widget_generator.dart';

// A second, small widget: Dash fills the square, the streak sits on top.
// Same palette as the Stride widget.
const _background = HWColor.fixed(0xFF111418);
const _orange = HWColor.fixed(0xFFFF7A1A);
const _muted = HWColor.fixed(0xFF8A9099);
const _pill = HWBoxDecoration(
  color: HWColor.fixed(0xB3111418),
  borderRadius: HWBorderRadius.circular(14),
);

// This widget's own data. Each widget has its own keys, so the app saves to it
// separately (StreakHomeWidget.saveData).
const _streak = HWInt('streak', defaultValue: 0, previewValue: 12);
const _goalReached = HWBool('goalReached', defaultValue: false);
const _mascot = HWTimedData(
  HWImageData('mascot', previewAsset: 'assets/images/dash_goal.png'),
);

const _streakStyle = HWTextStyle(
  fontFamily: 'BarlowCondensed',
  fontWeight: HWFontWeight.w800,
  fontSize: 22,
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

@HomeWidget(
  name: 'Streak',
  description: 'Your streak, with Dash.',
  // Same link as the Stride widget: the app listens for widget taps only once,
  // because a second listener on the tap channel replaces the first.
  widgetUrl: 'stride://today',
  android: HomeWidgetAndroidConfiguration(
    minWidth: 110,
    minHeight: 110,
    targetCellWidth: 2,
    targetCellHeight: 2,
    backgroundColor: _background,
    applyContentPadding: false,
  ),
  iOS: HomeWidgetIOSConfiguration(
    groupId: 'group.dev.akanshajain.stride',
    supportedFamilies: [HWWidgetFamily.systemSmall],
    backgroundColor: _background,
    applyContentPadding: false,
  ),
  widget: HWStack(
    fit: HWStackFit.expand,
    children: [
      // Dash fills the whole square.
      HWSizedBox.expand(
        child: HWImage(_mascot, fit: HWImageFit.cover, semanticLabel: 'Dash'),
      ),
      // The streak in a dark pill, top left.
      HWAlign(
        alignment: HWAlignment.topStart,
        child: HWPadding(
          padding: HWEdgeInsets.all(10),
          child: HWDecoratedBox(
            decoration: _pill,
            child: HWPadding(
              padding: HWEdgeInsets.only(left: 6, right: 10, top: 2, bottom: 2),
              child: HWBoolConditional(
                data: _goalReached,
                whenTrue: _streakOn,
                whenFalse: _streakOff,
              ),
            ),
          ),
        ),
      ),
    ],
  ),
)
class Streak {}
