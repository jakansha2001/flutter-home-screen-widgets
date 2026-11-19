// dart format off
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:home_widget/home_widget.dart';

class StrideHomeWidget {
  const StrideHomeWidget._();

  static const String _$appGroupId = 'group.dev.akanshajain.stride';

  static const String _$paramPrefix = 'home_widget.Stride';

  static Future<void> saveData({
    bool? goalReached,
    int? streak,
    int? steps,
    int? goal,
    List<StrideBlocksItem>? blocks,
    Map<DateTime, StrideTimedData>? timedData,
  }) {
    return Future.wait([
      if (goalReached != null) HomeWidget.saveWidgetData<bool>('${_$paramPrefix}.goalReached', goalReached, appGroupId: _$appGroupId),
      if (streak != null) HomeWidget.saveWidgetData<int>('${_$paramPrefix}.streak', streak, appGroupId: _$appGroupId),
      if (steps != null) HomeWidget.saveWidgetData<int>('${_$paramPrefix}.steps', steps, appGroupId: _$appGroupId),
      if (goal != null) HomeWidget.saveWidgetData<int>('${_$paramPrefix}.goal', goal, appGroupId: _$appGroupId),
      if (blocks != null) () async {
        await HomeWidget.saveFile('${_$paramPrefix}.blocks', Uint8List.fromList(utf8.encode(jsonEncode([for (final _item in blocks) _item.toJson()]))), extension: 'json', appGroupId: _$appGroupId);
      }(),
      if (timedData != null) () async {
        final _timedTimes = timedData.keys.toList()..sort();
        if (_timedTimes.isEmpty) {
          await HomeWidget.saveWidgetData('${_$paramPrefix}.timedData', null, appGroupId: _$appGroupId);
          try {
            await HomeWidget.cancelScheduledWidgetUpdates(androidName: 'StrideHomeWidgetReceiver');
          } catch (error, stackTrace) {
            // Cancelling is best effort; the data was deleted.
            FlutterError.reportError(
              FlutterErrorDetails(
                exception: error,
                stack: stackTrace,
                library: 'home_widget',
                context: ErrorDescription('cancelling scheduled updates for the Stride widget'),
              ),
            );
          }
          return;
        }
        final _timedJson = <String, dynamic>{
          for (final _time in _timedTimes)
            _time.toUtc().millisecondsSinceEpoch.toString(): timedData[_time]!.toJson(),
        };
        await HomeWidget.saveFile('${_$paramPrefix}.timedData', Uint8List.fromList(utf8.encode(jsonEncode(_timedJson))), extension: 'json', appGroupId: _$appGroupId);
        try {
          await HomeWidget.scheduleWidgetUpdates(_timedTimes, androidName: 'StrideHomeWidgetReceiver');
        } catch (error, stackTrace) {
          // Scheduling is best effort; the data was saved.
          FlutterError.reportError(
            FlutterErrorDetails(
              exception: error,
              stack: stackTrace,
              library: 'home_widget',
              context: ErrorDescription('scheduling updates for the Stride widget'),
            ),
          );
        }
      }(),
    ]);
  }

  static Future<void> deleteData({
    bool goalReached = false,
    bool streak = false,
    bool steps = false,
    bool goal = false,
    bool blocks = false,
    bool timedData = false,
  }) {
    return Future.wait([
      if (goalReached) HomeWidget.saveWidgetData('${_$paramPrefix}.goalReached', null, appGroupId: _$appGroupId),
      if (streak) HomeWidget.saveWidgetData('${_$paramPrefix}.streak', null, appGroupId: _$appGroupId),
      if (steps) HomeWidget.saveWidgetData('${_$paramPrefix}.steps', null, appGroupId: _$appGroupId),
      if (goal) HomeWidget.saveWidgetData('${_$paramPrefix}.goal', null, appGroupId: _$appGroupId),
      if (blocks) HomeWidget.saveWidgetData('${_$paramPrefix}.blocks', null, appGroupId: _$appGroupId),
      if (timedData) () async {
        await HomeWidget.saveWidgetData('${_$paramPrefix}.timedData', null, appGroupId: _$appGroupId);
        try {
          await HomeWidget.cancelScheduledWidgetUpdates(androidName: 'StrideHomeWidgetReceiver');
        } catch (error, stackTrace) {
          // Cancelling is best effort; the data was deleted.
          FlutterError.reportError(
            FlutterErrorDetails(
              exception: error,
              stack: stackTrace,
              library: 'home_widget',
              context: ErrorDescription('cancelling scheduled updates for the Stride widget'),
            ),
          );
        }
      }(),
    ]);
  }

  /// Reads every stored value back.
  ///
  /// The keys of [timedData] are local-time [DateTime]s, so they compare equal to a
  /// local [DateTime] for the same instant. Timestamps are stored as epoch
  /// milliseconds: sub-millisecond precision of the saved keys is not preserved.
  /// Keys are compared by instant, so a local [DateTime] and its `toUtc()` twin
  /// denote the same entry and only one of them survives a save.
  static Future<({bool? goalReached, int? streak, int? steps, int? goal, List<StrideBlocksItem>? blocks, Map<DateTime, StrideTimedData>? timedData})> getData() async {
    final _blocksPath = await HomeWidget.getWidgetData<String>('${_$paramPrefix}.blocks', appGroupId: _$appGroupId);
    List<StrideBlocksItem>? blocks;
    if (_blocksPath != null) {
      try {
        final _blocksJson = jsonDecode(await File(_blocksPath).readAsString());
        if (_blocksJson is List) blocks = [for (final _item in _blocksJson) StrideBlocksItem.fromJson(_item is Map<String, dynamic> ? _item : null)];
      } on Exception {
        blocks = null;
      }
    }
    final _timedDataPath = await HomeWidget.getWidgetData<String>('${_$paramPrefix}.timedData', appGroupId: _$appGroupId);
    Map<DateTime, StrideTimedData>? timedData;
    if (_timedDataPath != null) {
      try {
        final raw = await File(_timedDataPath).readAsString();
        final decoded = jsonDecode(raw);
        if (decoded is Map<String, dynamic>) {
          final entries = <DateTime, StrideTimedData>{};
          for (final entry in decoded.entries) {
            final millis = int.tryParse(entry.key);
            if (millis == null) continue;
            final value = entry.value;
            entries[DateTime.fromMillisecondsSinceEpoch(millis, isUtc: true).toLocal()] = StrideTimedData.fromJson(value is Map<String, dynamic> ? value : null);
          }
          timedData = entries;
        }
      } on Exception {
        timedData = null;
      }
    }
    return (
      goalReached: await HomeWidget.getWidgetData<bool>('${_$paramPrefix}.goalReached', defaultValue: false, appGroupId: _$appGroupId),
      streak: await HomeWidget.getWidgetData<int>('${_$paramPrefix}.streak', defaultValue: 0, appGroupId: _$appGroupId),
      steps: await HomeWidget.getWidgetData<int>('${_$paramPrefix}.steps', defaultValue: 0, appGroupId: _$appGroupId),
      goal: await HomeWidget.getWidgetData<int>('${_$paramPrefix}.goal', defaultValue: 10000, appGroupId: _$appGroupId),
      blocks: blocks,
      timedData: timedData,
    );
  }


  static Future<bool?> updateWidget() {
    return HomeWidget.updateWidget(
      androidName: 'StrideHomeWidgetReceiver',
      iOSName: 'StrideHomeWidget',
    );
  }

  /// Asks the launcher to re-render this widget's gallery preview.
  ///
  /// Android 15 and newer only; returns false elsewhere and when the system
  /// rate limit (about two updates per hour and widget) was hit. The plugin
  /// registers the preview automatically when the app starts, so this is only
  /// needed after data changes that should show in the gallery right away.
  static Future<bool> updatePreview() async {
    return await HomeWidget.updateWidgetPreview(
      androidName: 'StrideHomeWidgetReceiver',
    ) ?? false;
  }

  /// Whether the launcher lets the app ask to add this widget to the home
  /// screen: Android 8 or newer with a launcher that supports pinning. Always
  /// false on iOS.
  static Future<bool> isRequestPinWidgetSupported() async {
    return await HomeWidget.isRequestPinWidgetSupported() ?? false;
  }

  /// Asks the launcher to add this widget to the home screen.
  ///
  /// Shows the system pin dialog where [isRequestPinWidgetSupported] is true
  /// and does nothing anywhere else.
  static Future<void> requestPinWidget() {
    return HomeWidget.requestPinWidget(
      androidName: 'StrideHomeWidgetReceiver',
    );
  }

  /// Every instance of this widget currently placed on a home screen.
  ///
  /// Android reports one entry per placed instance, iOS one entry per family
  /// the widget is placed in.
  static Future<List<HomeWidgetInfo>> getInstalledWidgets() async {
    final widgets = await HomeWidget.getInstalledWidgets();
    return widgets.where(_$isThisWidget).toList();
  }

  /// Whether at least one instance of this widget is on a home screen.
  static Future<bool> isInstalled() async {
    return (await getInstalledWidgets()).isNotEmpty;
  }

  /// Whether [info] describes this widget.
  ///
  /// Android reports the provider's short class name — `.Receiver` when it
  /// lives in the package of the application id, and the qualified name
  /// otherwise — which is why the suffix is matched.
  static bool _$isThisWidget(HomeWidgetInfo info) {
    final androidClassName = info.androidClassName;
    if (androidClassName != null) {
      return androidClassName.endsWith('.StrideHomeWidgetReceiver');
    }
    return info.iOSKind == 'StrideHomeWidget';
  }

  /// The URL a tap on the widget opens the app with, as the app
  /// will receive it.
  ///
  /// The configured `widgetUrl` carrying the `homeWidget` query
  /// parameter, parsed — so its scheme is lower-cased, exactly like
  /// the URL handed to the app.
  static final Uri widgetUrl = Uri.parse('stride://today?homeWidget');

  /// The URL the app was launched with by a tap on the widget, or null
  /// when it was started any other way.
  ///
  /// Only the URL this widget opens on the platform the app is running
  /// on is reported; a tap on any other widget is not.
  static Future<Uri?> initiallyLaunchedFromWidget() async {
    final uri = await HomeWidget.initiallyLaunchedFromHomeWidget();
    if (uri == null || !_$matchesWidgetUrl(uri)) {
      return null;
    }
    return uri;
  }

  /// The URL of every tap on the widget while the app is running.
  ///
  /// A tap that started the app in the first place is not replayed here
  /// — read [initiallyLaunchedFromWidget] for that one, or listen to
  /// [launchedFromWidget] for both.
  ///
  /// Only the URL this widget opens on the platform the app is running
  /// on is reported; a tap on any other widget is not.
  static Stream<Uri> get widgetClicked =>
      HomeWidget.widgetClicked
          .where((uri) => uri != null && _$matchesWidgetUrl(uri))
          .cast<Uri>();

  /// Every tap on the widget, launch included.
  ///
  /// Yields the launch URL first when the app was started by a tap on
  /// the widget, then every tap that follows while it runs. Taps landing
  /// while the launch URL is still being read are kept, not dropped.
  ///
  /// Only the URL this widget opens on the platform the app is running
  /// on is reported; a tap on any other widget is not.
  static Stream<Uri> launchedFromWidget() async* {
    final clicks = StreamController<Uri>();
    final subscription = HomeWidget.widgetClicked.listen(
      (uri) {
        if (uri != null && _$matchesWidgetUrl(uri)) clicks.add(uri);
      },
      onDone: clicks.close,
    );
    try {
      final initial = await HomeWidget.initiallyLaunchedFromHomeWidget();
      if (initial != null && _$matchesWidgetUrl(initial)) yield initial;
      yield* clicks.stream;
    } finally {
      await subscription.cancel();
      await clicks.close();
    }
  }

  /// Whether [uri] is the URL this platform's widget opens.
  ///
  /// Schemes are compared case-insensitively: the URL reaches the app parsed,
  /// which lower-cases the scheme it was written with.
  static bool _$matchesWidgetUrl(Uri uri) {
    final url = _$platformWidgetUrl;
    if (url == null) return false;
    return _$lowerCaseScheme(uri) == _$lowerCaseScheme(url);
  }

  /// The URL the widget opens on the platform the app is running on, or
  /// null where it opens none.
  static Uri? get _$platformWidgetUrl {
    if (Platform.isAndroid) return widgetUrl;
    if (Platform.isIOS) return widgetUrl;
    return null;
  }

  static String _$lowerCaseScheme(Uri uri) {
    final text = uri.toString();
    return uri.scheme.toLowerCase() + text.substring(uri.scheme.length);
  }
}

class StrideTimedData {
  final String? message;

  const StrideTimedData({
    this.message,
  });

  factory StrideTimedData.fromJson(Map<String, dynamic>? json) {
    json ??= const {};
    return StrideTimedData(
      message: _readString(json['message']) ?? 'Lace up. Every step counts.',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (message != null) 'message': message,
    };
  }
}

class StrideBlocksItem {
  final bool? filled;

  const StrideBlocksItem({
    this.filled,
  });

  factory StrideBlocksItem.fromJson(Map<String, dynamic>? json) {
    json ??= const {};
    return StrideBlocksItem(
      filled: _readBool(json['filled']) ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (filled != null) 'filled': filled,
    };
  }
}

String? _readString(Object? value) => value is String ? value : null;
bool? _readBool(Object? value) => value is bool ? value : null;
