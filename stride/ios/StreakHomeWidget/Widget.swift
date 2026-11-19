// GENERATED CODE - DO NOT MODIFY BY HAND
//
// Placeholder SwiftUI widget.
//
// App Group ID used here: StreakHomeWidgetFlavor.appGroupId

import CoreText
import ImageIO
import SwiftUI
import WidgetKit

enum StreakHomeWidgetFlavor {
  static let appGroupId = "group.dev.akanshajain.stride"
}

struct Provider: TimelineProvider {
  func placeholder(in context: Context) -> StreakHomeWidgetEntry {
    StreakHomeWidgetEntry(date: Date(), data: StreakData.previewFromUserDefaults(nil))
  }

  func getSnapshot(in context: Context, completion: @escaping (StreakHomeWidgetEntry) -> Void) {
    if context.isPreview {
      let prefs: UserDefaults? = UserDefaults(suiteName: StreakHomeWidgetFlavor.appGroupId)
      let data = StreakData.previewFromUserDefaults(prefs)
      completion(StreakHomeWidgetEntry(date: Date(), data: data))
      return
    }

    let prefs = UserDefaults(suiteName: StreakHomeWidgetFlavor.appGroupId)
    let data = StreakData.fromUserDefaults(prefs)

    completion(StreakHomeWidgetEntry(date: Date(), data: data))

  }

  func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
    let prefs = UserDefaults(suiteName: StreakHomeWidgetFlavor.appGroupId)
    let timedEntries = StreakData.loadTimedEntries(prefs)
    let now = Date()
    var entries: [StreakHomeWidgetEntry] = [
      StreakHomeWidgetEntry(
        date: now,
        data: StreakData.fromUserDefaults(prefs, at: now, timedEntries: timedEntries)
      )
    ]
    for timedEntry in timedEntries where timedEntry.date > now {
      entries.append(
        StreakHomeWidgetEntry(
          date: timedEntry.date,
          data: StreakData.fromUserDefaults(prefs, at: timedEntry.date, timedEntries: timedEntries)
        )
      )
    }
    completion(Timeline(entries: entries, policy: .atEnd))

  }
}

struct StreakHomeWidgetEntry: TimelineEntry {
  let date: Date
  let data: StreakData
}


struct StreakHomeWidgetEntryView: View {
  var entry: Provider.Entry

  var body: some View {
        ZStack(alignment: .topLeading) {
            Group {
                if let path = entry.data.mascot, let uiImage = hwDecodeImage(path, nil, nil) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipped()
                        .accessibilityLabel("Dash")
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            Group {
                if entry.data.goalReached == true {
                    HStack(alignment: .center, spacing: 0) {
                        Text(String(UnicodeScalar(UInt32(0xE392))!))
                            .font(hwBundledFont("hw_font_icons_materialicons", size: 20))
                            .frame(width: 20, height: 20)
                            .foregroundColor(Color(red: 1.0, green: 0.47843137254901963, blue: 0.10196078431372549, opacity: 1.0))
                            .accessibilityHidden(true)
                        Text(hwFormatDecimal(NSNumber(value: entry.data.streak ?? 0), minFraction: nil, maxFraction: nil, grouping: true))
                            .font(hwFont("BarlowCondensed", 800, false, 22)).foregroundColor(Color(red: 1.0, green: 0.47843137254901963, blue: 0.10196078431372549, opacity: 1.0))
                        .padding(.leading, 2.0)
                    }
                } else {
                    HStack(alignment: .center, spacing: 0) {
                        Text(String(UnicodeScalar(UInt32(0xE392))!))
                            .font(hwBundledFont("hw_font_icons_materialicons", size: 20))
                            .frame(width: 20, height: 20)
                            .foregroundColor(Color(red: 0.5411764705882353, green: 0.5647058823529412, blue: 0.6, opacity: 1.0))
                            .accessibilityHidden(true)
                        Text(hwFormatDecimal(NSNumber(value: entry.data.streak ?? 0), minFraction: nil, maxFraction: nil, grouping: true))
                            .font(hwFont("BarlowCondensed", 800, false, 22)).foregroundColor(Color(red: 0.5411764705882353, green: 0.5647058823529412, blue: 0.6, opacity: 1.0))
                        .padding(.leading, 2.0)
                    }
                }
            }
            .padding(EdgeInsets(top: 2.0, leading: 6.0, bottom: 2.0, trailing: 10.0))
            .background(RoundedRectangle(cornerRadius: 14.0).fill(Color(red: 0.06666666666666667, green: 0.0784313725490196, blue: 0.09411764705882353, opacity: 0.7019607843137254)))
            .padding(EdgeInsets(top: 10.0, leading: 10.0, bottom: 10.0, trailing: 10.0))
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .clipped()
    .applyContainerBackground(Color(red: 0.06666666666666667, green: 0.0784313725490196, blue: 0.09411764705882353, opacity: 1.0))
    .widgetURL(URL(string: "stride://today?homeWidget"))
  }
}

struct StreakHomeWidget: Widget {
  let kind: String = "StreakHomeWidget"

  var body: some WidgetConfiguration {
    StaticConfiguration(kind: kind, provider: Provider()) { entry in
      StreakHomeWidgetEntryView(entry: entry)
    }
    .configurationDisplayName("Streak")
    .description("Your streak, with Dash.")
    .supportedFamilies([.systemSmall])
    .disableContentMarginsIfNeeded()
  }
}

extension View {
  @ViewBuilder
  func applyContainerBackground<T: View>(_ backgroundView: T) -> some View {
    if #available(iOSApplicationExtension 17.0, *) {
      self.containerBackground(for: .widget) { backgroundView }
    } else {
      self.background(backgroundView)
    }
  }
}

extension WidgetConfiguration {
  func disableContentMarginsIfNeeded() -> some WidgetConfiguration {
    if #available(iOSApplicationExtension 15.0, macOS 12.0, watchOS 9.0, *) {
      return self.contentMarginsDisabled()
    } else {
      return self
    }
  }
}

struct StreakData {
  let goalReached: Bool?
  let streak: Int?
  let mascot: String?

  static let paramPrefix = "home_widget.Streak"

  static func fromUserDefaults(
    _ defaults: UserDefaults?,
    at date: Date = Date(),
    timedEntries: [(date: Date, values: [String: Any])]? = nil
  ) -> StreakData {
    let timedValues = activeTimedValues(timedEntries ?? loadTimedEntries(defaults), at: date)
    return StreakData(
      goalReached: (defaults?.object(forKey: "\(paramPrefix).goalReached") as? Bool ?? false),
      streak: (defaults?.object(forKey: "\(paramPrefix).streak") as? Int ?? 0),
      mascot: timedValues["mascot"] as? String,
    )
  }

  static func previewFromUserDefaults(
    _ defaults: UserDefaults?,
    at date: Date = Date(),
    timedEntries: [(date: Date, values: [String: Any])]? = nil
  ) -> StreakData {
    let timedValues = activeTimedValues(timedEntries ?? loadTimedEntries(defaults), at: date)
    return StreakData(
      goalReached: (defaults?.object(forKey: "\(paramPrefix).goalReached") as? Bool ?? false),
      streak: (defaults?.object(forKey: "\(paramPrefix).streak") as? Int ?? 12),
      mascot: (timedValues["mascot"] as? String) ?? "assets/images/dash_goal.png",
    )
  }

  fileprivate static func loadTimedEntries(_ defaults: UserDefaults?) -> [(date: Date, values: [String: Any])] {
    guard let path = defaults?.string(forKey: "\(paramPrefix).timedData") else { return [] }
    guard FileManager.default.fileExists(atPath: path) else { return [] }
    do {
      let raw = try Data(contentsOf: URL(fileURLWithPath: path))
      guard let json = try JSONSerialization.jsonObject(with: raw) as? [String: Any] else { return [] }
      var entries: [(date: Date, values: [String: Any])] = []
      for (key, value) in json {
        guard let millis = Double(key), let values = value as? [String: Any] else { continue }
        entries.append((date: Date(timeIntervalSince1970: millis / 1000), values: values))
      }
      entries.sort { $0.date < $1.date }
      return entries
    } catch {
      return []
    }
  }

  fileprivate static func activeTimedValues(_ entries: [(date: Date, values: [String: Any])], at date: Date) -> [String: Any] {
    var values: [String: Any] = [:]
    for entry in entries {
      if entry.date > date { break }
      values = entry.values
    }
    return values
  }
}


func hwDecodeImage(_ path: String, _ widthPt: Double?, _ heightPt: Double?) -> UIImage? {
  func assetFile(_ asset: String) -> String? {
    let appBundleURL = Bundle.main.bundleURL
      .deletingLastPathComponent()
      .deletingLastPathComponent()
    let url = appBundleURL
      .appendingPathComponent("Frameworks/App.framework/flutter_assets")
      .appendingPathComponent(asset)
    return FileManager.default.fileExists(atPath: url.path) ? url.path : nil
  }

  guard let file = path.hasPrefix("/") ? path : assetFile(path),
    let source = CGImageSourceCreateWithURL(URL(fileURLWithPath: file) as CFURL, nil)
  else { return nil }
  let displayScale = UITraitCollection.current.displayScale
  let scale = displayScale > 0 ? displayScale : 3
  let fallback = CGFloat(1536)
  let targetWidth = widthPt.map { CGFloat($0) * scale } ?? fallback
  let targetHeight = heightPt.map { CGFloat($0) * scale } ?? fallback
  let maxPixelSize = Int(max(targetWidth, targetHeight).rounded())
  guard maxPixelSize > 0 else { return nil }
  let options: [CFString: Any] = [
    kCGImageSourceCreateThumbnailFromImageAlways: true,
    kCGImageSourceCreateThumbnailWithTransform: true,
    kCGImageSourceShouldCacheImmediately: true,
    kCGImageSourceThumbnailMaxPixelSize: maxPixelSize,
  ]
  guard
    let thumbnail = CGImageSourceCreateThumbnailAtIndex(source, 0, options as CFDictionary)
  else { return nil }
  return UIImage(cgImage: thumbnail, scale: scale, orientation: .up)
}

private final class HWFontCache: @unchecked Sendable {
  static let shared = HWFontCache()

  private let lock = NSRecursiveLock()
  private var descriptors: [String: CTFontDescriptor?] = [:]
  private var fonts: [String: Font?] = [:]

  func font(_ key: String, _ size: CGFloat, _ build: () -> Font?) -> Font? {
    lock.lock()
    defer { lock.unlock() }
    let cacheKey = "\(key)|\(size)"
    if let cached = fonts[cacheKey] { return cached }
    let font = build()
    fonts[cacheKey] = font
    return font
  }

  func descriptor(_ url: URL) -> CTFontDescriptor? {
    lock.lock()
    defer { lock.unlock() }
    let path = url.path
    if let known = descriptors[path] { return known }
    let parsed = (CTFontManagerCreateFontDescriptorsFromURL(url as CFURL)
      as? [CTFontDescriptor])?.first
    descriptors[path] = parsed
    return parsed
  }
}

func hwFontFromURL(_ url: URL, _ size: CGFloat) -> Font? {
  return HWFontCache.shared.font(url.path, size) { () -> Font? in
    guard let descriptor = HWFontCache.shared.descriptor(url) else { return nil }
    return Font(CTFontCreateWithFontDescriptor(descriptor, size, nil))
  }
}

func hwAssetFont(_ asset: String, _ size: CGFloat) -> Font {
  let font = HWFontCache.shared.font("asset:" + asset, size) { () -> Font? in
    let url = Bundle.main.bundleURL
      .deletingLastPathComponent()
      .deletingLastPathComponent()
      .appendingPathComponent("Frameworks/App.framework/flutter_assets")
      .appendingPathComponent(asset)
    guard FileManager.default.fileExists(atPath: url.path) else { return nil }
    return hwFontFromURL(url, size)
  }
  return font ?? .system(size: size)
}

func hwBundledFont(_ name: String, size: CGFloat) -> Font {
  let font = HWFontCache.shared.font("bundle:" + name, size) { () -> Font? in
    for ext in ["otf", "ttf", "ttc"] {
      guard let url = Bundle.main.url(forResource: name, withExtension: ext)
      else { continue }
      if let font = hwFontFromURL(url, size) { return font }
    }
    return nil
  }
  return font ?? .system(size: size)
}

private final class HWFontManifest: @unchecked Sendable {
  struct Variant {
    let asset: String
    let weight: Int
    let italic: Bool
  }

  static let shared = HWFontManifest()

  private let lock = NSLock()
  private var families: [String: [Variant]]?

  func variants(of family: String) -> [Variant] {
    lock.lock()
    defer { lock.unlock() }
    if families == nil { families = HWFontManifest.read() }
    return families?[family] ?? []
  }

  private static func read() -> [String: [Variant]] {
    let url = Bundle.main.bundleURL
      .deletingLastPathComponent()
      .deletingLastPathComponent()
      .appendingPathComponent("Frameworks/App.framework/flutter_assets")
      .appendingPathComponent("FontManifest.json")
    guard let data = try? Data(contentsOf: url),
      let entries = try? JSONSerialization.jsonObject(with: data) as? [[String: Any]]
    else { return [:] }

    var families: [String: [Variant]] = [:]
    for entry in entries {
      guard let family = entry["family"] as? String,
        let fonts = entry["fonts"] as? [[String: Any]]
      else { continue }
      let variants = fonts.compactMap { font -> Variant? in
        guard let asset = font["asset"] as? String else { return nil }
        return Variant(
          asset: asset,
          weight: font["weight"] as? Int ?? 400,
          italic: font["style"] as? String == "italic")
      }
      if !variants.isEmpty { families[family] = variants }
    }
    return families
  }
}

func hwFont(_ family: String, _ weight: Int, _ italic: Bool, _ size: CGFloat) -> Font {
  let variants = HWFontManifest.shared.variants(of: family)
  let matchingStyle = variants.filter { $0.italic == italic }
  let pool = matchingStyle.isEmpty ? variants : matchingStyle
  if let exact = pool.first(where: { $0.weight == weight }) {
    return hwAssetFont(exact.asset, size)
  }
  let lighter = pool.filter { $0.weight < weight }.sorted { $0.weight > $1.weight }
  let heavier = pool.filter { $0.weight > weight }.sorted { $0.weight < $1.weight }
  guard let nearest = (weight <= 400 ? lighter + heavier : heavier + lighter).first
  else { return .system(size: size) }
  return hwAssetFont(nearest.asset, size)
}

func hwFormatLocale() -> Locale {
  return Locale.current
}

func hwFormatDecimal(
  _ value: NSNumber, minFraction: Int?, maxFraction: Int?, grouping: Bool
) -> String {
  let formatter = NumberFormatter()
  formatter.locale = hwFormatLocale()
  formatter.numberStyle = .decimal
  formatter.usesGroupingSeparator = grouping
  if let minFraction { formatter.minimumFractionDigits = minFraction }
  if let maxFraction { formatter.maximumFractionDigits = maxFraction }
  return formatter.string(from: value) ?? value.stringValue
}
