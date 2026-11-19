// GENERATED CODE - DO NOT MODIFY BY HAND
//
// This is a placeholder Glance (Jetpack Compose) widget.
package dev.akanshajain.stride

import androidx.compose.runtime.Composable
import android.content.Context
import androidx.compose.ui.graphics.Color
import androidx.glance.GlanceId
import androidx.glance.GlanceModifier
import androidx.glance.appwidget.GlanceAppWidget
import androidx.glance.appwidget.provideContent
import androidx.glance.background
import androidx.glance.currentState
import androidx.glance.layout.Box
import androidx.glance.layout.fillMaxSize
import androidx.glance.text.Text
import es.antonborri.home_widget.HomeWidgetGlanceState
import es.antonborri.home_widget.HomeWidgetGlanceStateDefinition
import es.antonborri.home_widget.HomeWidgetPlugin
import androidx.glance.layout.Column
import androidx.glance.layout.Alignment
import androidx.glance.layout.Spacer
import androidx.glance.layout.fillMaxHeight
import androidx.glance.layout.Row
import androidx.glance.layout.fillMaxWidth
import androidx.glance.ColorFilter
import androidx.glance.Image
import androidx.glance.ImageProvider
import androidx.glance.LocalSize
import es.antonborri.home_widget.HomeWidgetFonts
import androidx.glance.color.ColorProvider
import androidx.compose.ui.unit.dp
import androidx.glance.layout.size
import androidx.glance.layout.padding
import androidx.glance.layout.width
import androidx.glance.layout.height
import androidx.glance.appwidget.cornerRadius
import androidx.core.os.ConfigurationCompat
import java.util.Locale
import java.text.NumberFormat
import androidx.glance.GlanceTheme
import androidx.glance.appwidget.SizeMode
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.glance.action.clickable
import android.net.Uri
import es.antonborri.home_widget.actionStartActivity

class StrideHomeWidget : GlanceAppWidget() {
  override val stateDefinition = HomeWidgetGlanceStateDefinition()

  override val sizeMode: SizeMode = SizeMode.Exact

  override suspend fun provideGlance(context: Context, id: GlanceId) {
    val measuring: (HomeWidgetFonts.TextBounds) -> GlanceAppWidget = { bounds ->
      object : GlanceAppWidget() {
        override suspend fun provideGlance(context: Context, id: GlanceId) {
          provideContent { WidgetContent(context, HomeWidgetGlanceState(HomeWidgetPlugin.getData(context)), textBounds = bounds) }
        }
      }
    }
    val measured = HomeWidgetFonts.measureTextBounds(context, id, measuring)
    provideContent {
      val size = LocalSize.current
      var textBounds by remember { mutableStateOf(measured) }
      LaunchedEffect(size) {
        if (!textBounds.covers(size)) {
          textBounds += HomeWidgetFonts.measureTextBounds(context, id, size, measuring)
        }
      }
      WidgetContent(context, currentState(), textBounds = textBounds)
    }
  }

  override suspend fun providePreview(context: Context, widgetCategory: Int) {
    provideContent { WidgetContent(context, HomeWidgetGlanceState(HomeWidgetPlugin.getData(context)), preview = true, textBounds = HomeWidgetFonts.TextBounds.NONE) }
  }

  fun previewFingerprint(context: Context): String {
    val hwLocales = hwCurrentLocales(context)
    val hwPreviewData =
        StrideData.previewFromPreferences(HomeWidgetPlugin.getData(context))
    return listOf(
      "b29ddc56",
      hwLocales.joinToString(","),
      hwPreviewData.toString(),
    ).joinToString("|")
  }

  @Composable
  private fun WidgetContent(context: Context, currentState: HomeWidgetGlanceState, preview: Boolean = false, textBounds: HomeWidgetFonts.TextBounds) {
    val prefs = currentState.preferences
    val widgetData =
        if (preview) StrideData.previewFromPreferences(prefs)
        else StrideData.fromPreferences(prefs)
    GlanceTheme {
            Box(modifier = GlanceModifier.background(ColorProvider(day = Color(0xFF111418), night = Color(0xFF111418))).padding(16.dp).fillMaxSize().clickable(onClick = actionStartActivity<MainActivity>(context, Uri.parse("stride://today?homeWidget"))), contentAlignment = Alignment.Center) {
                Column(modifier = GlanceModifier.fillMaxSize(), horizontalAlignment = Alignment.Start) {
                    Row(modifier = GlanceModifier.fillMaxWidth(), verticalAlignment = Alignment.CenterVertically) {
                        Image(
                            modifier = GlanceModifier,
                            provider = ImageProvider(
                                if (textBounds.isProbe("8fc3baea", LocalSize.current)) HomeWidgetFonts.probeBitmap()
                                else HomeWidgetFonts.textBitmap(
                                    context,
                                    HomeWidgetFonts.typeface(context, "BarlowCondensed", 600, false),
                                    "TODAY",
                                    fontSizeSp = 14f,
                                    maxWidthDp = textBounds.width("8fc3baea", LocalSize.current),
                                    maxHeightDp = textBounds.height("8fc3baea", LocalSize.current),
                                )
                            ),
                            contentDescription = if (textBounds.isProbe("8fc3baea", LocalSize.current)) "hw_text_bounds:8fc3baea" else "TODAY",
                            colorFilter = ColorFilter.tint(ColorProvider(day = Color(0xFF8A9099), night = Color(0xFF8A9099))),
                        )
                        Spacer(modifier = GlanceModifier.defaultWeight())
                        if (widgetData.goalReached == true) {
                            Row(verticalAlignment = Alignment.CenterVertically) {
                                Image(modifier = GlanceModifier.size(20.dp), provider = ImageProvider(HomeWidgetFonts.iconBitmap(context, R.font.hw_font_stride__icons_materialicons, 0xE392, 20f)), contentDescription = null, colorFilter = ColorFilter.tint(ColorProvider(day = Color(0xFFFF7A1A), night = Color(0xFFFF7A1A))))
                                Image(
                                    modifier = GlanceModifier.padding(start = 2.0.dp),
                                    provider = ImageProvider(
                                        if (textBounds.isProbe("68bfc364", LocalSize.current)) HomeWidgetFonts.probeBitmap()
                                        else HomeWidgetFonts.textBitmap(
                                            context,
                                            HomeWidgetFonts.typeface(context, "BarlowCondensed", 800, false),
                                            hwFormatDecimal((widgetData.streak ?: 0L), null, null, true, hwFormatLocale(context)),
                                            fontSizeSp = 20f,
                                            maxWidthDp = textBounds.width("68bfc364", LocalSize.current),
                                            maxHeightDp = textBounds.height("68bfc364", LocalSize.current),
                                        )
                                    ),
                                    contentDescription = if (textBounds.isProbe("68bfc364", LocalSize.current)) "hw_text_bounds:68bfc364" else hwFormatDecimal((widgetData.streak ?: 0L), null, null, true, hwFormatLocale(context)),
                                    colorFilter = ColorFilter.tint(ColorProvider(day = Color(0xFFFF7A1A), night = Color(0xFFFF7A1A))),
                                )
                            }
                        } else {
                            Row(verticalAlignment = Alignment.CenterVertically) {
                                Image(modifier = GlanceModifier.size(20.dp), provider = ImageProvider(HomeWidgetFonts.iconBitmap(context, R.font.hw_font_stride__icons_materialicons, 0xE392, 20f)), contentDescription = null, colorFilter = ColorFilter.tint(ColorProvider(day = Color(0xFF8A9099), night = Color(0xFF8A9099))))
                                Image(
                                    modifier = GlanceModifier.padding(start = 2.0.dp),
                                    provider = ImageProvider(
                                        if (textBounds.isProbe("68bfc364", LocalSize.current)) HomeWidgetFonts.probeBitmap()
                                        else HomeWidgetFonts.textBitmap(
                                            context,
                                            HomeWidgetFonts.typeface(context, "BarlowCondensed", 800, false),
                                            hwFormatDecimal((widgetData.streak ?: 0L), null, null, true, hwFormatLocale(context)),
                                            fontSizeSp = 20f,
                                            maxWidthDp = textBounds.width("68bfc364", LocalSize.current),
                                            maxHeightDp = textBounds.height("68bfc364", LocalSize.current),
                                        )
                                    ),
                                    contentDescription = if (textBounds.isProbe("68bfc364", LocalSize.current)) "hw_text_bounds:68bfc364" else hwFormatDecimal((widgetData.streak ?: 0L), null, null, true, hwFormatLocale(context)),
                                    colorFilter = ColorFilter.tint(ColorProvider(day = Color(0xFF8A9099), night = Color(0xFF8A9099))),
                                )
                            }
                        }
                    }
                    Spacer(modifier = GlanceModifier.defaultWeight())
                    Row(verticalAlignment = Alignment.Top) {
                        if (widgetData.goalReached == true) {
                            Box(modifier = GlanceModifier.padding(top = HomeWidgetFonts.baselinePadding(context, listOf(if (widgetData.goalReached == true) HomeWidgetFonts.textAscentPx(context, HomeWidgetFonts.typeface(context, "BarlowCondensed", 800, false), 44f) else HomeWidgetFonts.textAscentPx(context, HomeWidgetFonts.typeface(context, "BarlowCondensed", 800, false), 44f), HomeWidgetFonts.textAscentPx(context, HomeWidgetFonts.typeface(context, "BarlowCondensed", 400, false), 18f), HomeWidgetFonts.textAscentPx(context, HomeWidgetFonts.typeface(context, "BarlowCondensed", 400, false), 18f)), 0))) {
                                Image(
                                    modifier = GlanceModifier,
                                    provider = ImageProvider(
                                        if (textBounds.isProbe("62bf0949", LocalSize.current)) HomeWidgetFonts.probeBitmap()
                                        else HomeWidgetFonts.textBitmap(
                                            context,
                                            HomeWidgetFonts.typeface(context, "BarlowCondensed", 800, false),
                                            hwFormatDecimal((widgetData.steps ?: 0L), null, null, true, hwFormatLocale(context)),
                                            fontSizeSp = 44f,
                                            maxWidthDp = textBounds.width("62bf0949", LocalSize.current),
                                            maxHeightDp = textBounds.height("62bf0949", LocalSize.current),
                                        )
                                    ),
                                    contentDescription = if (textBounds.isProbe("62bf0949", LocalSize.current)) "hw_text_bounds:62bf0949" else hwFormatDecimal((widgetData.steps ?: 0L), null, null, true, hwFormatLocale(context)),
                                    colorFilter = ColorFilter.tint(ColorProvider(day = Color(0xFFC6FF3D), night = Color(0xFFC6FF3D))),
                                )
                            }
                        } else {
                            Box(modifier = GlanceModifier.padding(top = HomeWidgetFonts.baselinePadding(context, listOf(if (widgetData.goalReached == true) HomeWidgetFonts.textAscentPx(context, HomeWidgetFonts.typeface(context, "BarlowCondensed", 800, false), 44f) else HomeWidgetFonts.textAscentPx(context, HomeWidgetFonts.typeface(context, "BarlowCondensed", 800, false), 44f), HomeWidgetFonts.textAscentPx(context, HomeWidgetFonts.typeface(context, "BarlowCondensed", 400, false), 18f), HomeWidgetFonts.textAscentPx(context, HomeWidgetFonts.typeface(context, "BarlowCondensed", 400, false), 18f)), 0))) {
                                Image(
                                    modifier = GlanceModifier,
                                    provider = ImageProvider(
                                        if (textBounds.isProbe("62bf0949", LocalSize.current)) HomeWidgetFonts.probeBitmap()
                                        else HomeWidgetFonts.textBitmap(
                                            context,
                                            HomeWidgetFonts.typeface(context, "BarlowCondensed", 800, false),
                                            hwFormatDecimal((widgetData.steps ?: 0L), null, null, true, hwFormatLocale(context)),
                                            fontSizeSp = 44f,
                                            maxWidthDp = textBounds.width("62bf0949", LocalSize.current),
                                            maxHeightDp = textBounds.height("62bf0949", LocalSize.current),
                                        )
                                    ),
                                    contentDescription = if (textBounds.isProbe("62bf0949", LocalSize.current)) "hw_text_bounds:62bf0949" else hwFormatDecimal((widgetData.steps ?: 0L), null, null, true, hwFormatLocale(context)),
                                    colorFilter = ColorFilter.tint(ColorProvider(day = Color(0xFFF5F7FA), night = Color(0xFFF5F7FA))),
                                )
                            }
                        }
                        Box(modifier = GlanceModifier.padding(top = HomeWidgetFonts.baselinePadding(context, listOf(if (widgetData.goalReached == true) HomeWidgetFonts.textAscentPx(context, HomeWidgetFonts.typeface(context, "BarlowCondensed", 800, false), 44f) else HomeWidgetFonts.textAscentPx(context, HomeWidgetFonts.typeface(context, "BarlowCondensed", 800, false), 44f), HomeWidgetFonts.textAscentPx(context, HomeWidgetFonts.typeface(context, "BarlowCondensed", 400, false), 18f), HomeWidgetFonts.textAscentPx(context, HomeWidgetFonts.typeface(context, "BarlowCondensed", 400, false), 18f)), 1)).padding(start = 6.0.dp)) {
                            Image(
                                modifier = GlanceModifier,
                                provider = ImageProvider(
                                    if (textBounds.isProbe("4dc7f67c", LocalSize.current)) HomeWidgetFonts.probeBitmap()
                                    else HomeWidgetFonts.textBitmap(
                                        context,
                                        HomeWidgetFonts.typeface(context, "BarlowCondensed", 400, false),
                                        "/",
                                        fontSizeSp = 18f,
                                        maxWidthDp = textBounds.width("4dc7f67c", LocalSize.current),
                                        maxHeightDp = textBounds.height("4dc7f67c", LocalSize.current),
                                    )
                                ),
                                contentDescription = if (textBounds.isProbe("4dc7f67c", LocalSize.current)) "hw_text_bounds:4dc7f67c" else "/",
                                colorFilter = ColorFilter.tint(ColorProvider(day = Color(0xFF8A9099), night = Color(0xFF8A9099))),
                            )
                        }
                        Box(modifier = GlanceModifier.padding(top = HomeWidgetFonts.baselinePadding(context, listOf(if (widgetData.goalReached == true) HomeWidgetFonts.textAscentPx(context, HomeWidgetFonts.typeface(context, "BarlowCondensed", 800, false), 44f) else HomeWidgetFonts.textAscentPx(context, HomeWidgetFonts.typeface(context, "BarlowCondensed", 800, false), 44f), HomeWidgetFonts.textAscentPx(context, HomeWidgetFonts.typeface(context, "BarlowCondensed", 400, false), 18f), HomeWidgetFonts.textAscentPx(context, HomeWidgetFonts.typeface(context, "BarlowCondensed", 400, false), 18f)), 2)).padding(start = 6.0.dp)) {
                            Image(
                                modifier = GlanceModifier,
                                provider = ImageProvider(
                                    if (textBounds.isProbe("2ffc2289", LocalSize.current)) HomeWidgetFonts.probeBitmap()
                                    else HomeWidgetFonts.textBitmap(
                                        context,
                                        HomeWidgetFonts.typeface(context, "BarlowCondensed", 400, false),
                                        hwFormatDecimal((widgetData.goal ?: 10000L), null, null, true, hwFormatLocale(context)),
                                        fontSizeSp = 18f,
                                        maxWidthDp = textBounds.width("2ffc2289", LocalSize.current),
                                        maxHeightDp = textBounds.height("2ffc2289", LocalSize.current),
                                    )
                                ),
                                contentDescription = if (textBounds.isProbe("2ffc2289", LocalSize.current)) "hw_text_bounds:2ffc2289" else hwFormatDecimal((widgetData.goal ?: 10000L), null, null, true, hwFormatLocale(context)),
                                colorFilter = ColorFilter.tint(ColorProvider(day = Color(0xFF8A9099), night = Color(0xFF8A9099))),
                            )
                        }
                    }
                    Spacer(modifier = GlanceModifier.defaultWeight())
                    Row(verticalAlignment = Alignment.CenterVertically) {
                        val hwItems = widgetData.blocks.orEmpty().take(10)
                        hwItems.forEachIndexed { hwIndex, hwItem ->
                            if (hwItem.filled == true) {
                                Box(modifier = GlanceModifier.padding(start = if (hwIndex > 0) 5.0.dp else 0.dp)) {
                                    Spacer(modifier = GlanceModifier.width(22.0.dp).height(8.0.dp).background(ColorProvider(day = Color(0xFFC6FF3D), night = Color(0xFFC6FF3D))).cornerRadius(4.0.dp))
                                }
                            } else {
                                Box(modifier = GlanceModifier.padding(start = if (hwIndex > 0) 5.0.dp else 0.dp)) {
                                    Spacer(modifier = GlanceModifier.width(22.0.dp).height(8.0.dp).background(ColorProvider(day = Color(0xFF2A2F37), night = Color(0xFF2A2F37))).cornerRadius(4.0.dp))
                                }
                            }
                        }
                    }
                    Spacer(modifier = GlanceModifier.defaultWeight())
                    Image(
                        modifier = GlanceModifier,
                        provider = ImageProvider(
                            if (textBounds.isProbe("ea1f7041", LocalSize.current)) HomeWidgetFonts.probeBitmap()
                            else HomeWidgetFonts.textBitmap(
                                context,
                                HomeWidgetFonts.typeface(context, "BarlowCondensed", 500, false),
                                widgetData.message ?: "",
                                fontSizeSp = 15f,
                                maxWidthDp = textBounds.width("ea1f7041", LocalSize.current),
                                maxHeightDp = textBounds.height("ea1f7041", LocalSize.current),
                            )
                        ),
                        contentDescription = if (textBounds.isProbe("ea1f7041", LocalSize.current)) "hw_text_bounds:ea1f7041" else widgetData.message ?: "",
                        colorFilter = ColorFilter.tint(ColorProvider(day = Color(0xFFF5F7FA), night = Color(0xFFF5F7FA))),
                    )
                }
            }
    }

  }
}

data class StrideData(
    val goalReached: Boolean? = null,
    val streak: Long? = null,
    val steps: Long? = null,
    val goal: Long? = null,
    val message: String? = null,
    val blocks: List<StrideBlocksItem>? = null,
) {
    companion object {
        private const val PREFERENCES_PREFIX = "home_widget.Stride"

        fun fromPreferences(prefs: android.content.SharedPreferences, now: Long = System.currentTimeMillis()): StrideData {
            val timedValues = resolveTimedValues(prefs, now)
            return StrideData(
                goalReached = if (prefs.contains("${PREFERENCES_PREFIX}.goalReached")) prefs.getBoolean("${PREFERENCES_PREFIX}.goalReached", false) else false,
                streak = if (prefs.contains("${PREFERENCES_PREFIX}.streak")) (try { prefs.getInt("${PREFERENCES_PREFIX}.streak", 0).toLong() } catch (_: ClassCastException) { prefs.getLong("${PREFERENCES_PREFIX}.streak", 0L) }) else 0L,
                steps = if (prefs.contains("${PREFERENCES_PREFIX}.steps")) (try { prefs.getInt("${PREFERENCES_PREFIX}.steps", 0).toLong() } catch (_: ClassCastException) { prefs.getLong("${PREFERENCES_PREFIX}.steps", 0L) }) else 0L,
                goal = if (prefs.contains("${PREFERENCES_PREFIX}.goal")) (try { prefs.getInt("${PREFERENCES_PREFIX}.goal", 0).toLong() } catch (_: ClassCastException) { prefs.getLong("${PREFERENCES_PREFIX}.goal", 0L) }) else 10000L,
                message = if (timedValues.has("message") && !timedValues.isNull("message")) timedValues.optString("message") else "Lace up. Every step counts.",
                blocks = StrideBlocksItem.fromPath(prefs.getString("${PREFERENCES_PREFIX}.blocks", null)),
            )
        }

        fun previewFromPreferences(prefs: android.content.SharedPreferences, now: Long = System.currentTimeMillis()): StrideData {
            val timedValues = resolveTimedValues(prefs, now)
            return StrideData(
                goalReached = if (prefs.contains("${PREFERENCES_PREFIX}.goalReached")) prefs.getBoolean("${PREFERENCES_PREFIX}.goalReached", false) else false,
                streak = if (prefs.contains("${PREFERENCES_PREFIX}.streak")) (try { prefs.getInt("${PREFERENCES_PREFIX}.streak", 0).toLong() } catch (_: ClassCastException) { prefs.getLong("${PREFERENCES_PREFIX}.streak", 0L) }) else 12L,
                steps = if (prefs.contains("${PREFERENCES_PREFIX}.steps")) (try { prefs.getInt("${PREFERENCES_PREFIX}.steps", 0).toLong() } catch (_: ClassCastException) { prefs.getLong("${PREFERENCES_PREFIX}.steps", 0L) }) else 6240L,
                goal = if (prefs.contains("${PREFERENCES_PREFIX}.goal")) (try { prefs.getInt("${PREFERENCES_PREFIX}.goal", 0).toLong() } catch (_: ClassCastException) { prefs.getLong("${PREFERENCES_PREFIX}.goal", 0L) }) else 10000L,
                message = if (timedValues.has("message") && !timedValues.isNull("message")) timedValues.optString("message") else "A short walk gets you there",
                blocks = StrideBlocksItem.fromPath(prefs.getString("${PREFERENCES_PREFIX}.blocks", null))
                    ?: listOf(
                        StrideBlocksItem(filled = true),
                        StrideBlocksItem(filled = true),
                        StrideBlocksItem(filled = true),
                        StrideBlocksItem(filled = true),
                        StrideBlocksItem(filled = true),
                        StrideBlocksItem(filled = true),
                        StrideBlocksItem(filled = false),
                        StrideBlocksItem(filled = false),
                        StrideBlocksItem(filled = false),
                        StrideBlocksItem(filled = false),
                    ),
            )
        }

        private fun resolveTimedValues(prefs: android.content.SharedPreferences, now: Long): org.json.JSONObject {
            val path = prefs.getString("${PREFERENCES_PREFIX}.timedData", null) ?: return org.json.JSONObject()
            return try {
                val file = java.io.File(path)
                if (!file.exists()) return org.json.JSONObject()
                val json = org.json.JSONObject(file.readText())
                var activeKey: String? = null
                var activeTimestamp = 0L
                val keys = json.keys()
                while (keys.hasNext()) {
                    val key = keys.next()
                    val timestamp = key.toLongOrNull() ?: continue
                    if (timestamp <= now && (activeKey == null || timestamp > activeTimestamp)) {
                        activeKey = key
                        activeTimestamp = timestamp
                    }
                }
                val resolvedKey = activeKey ?: return org.json.JSONObject()
                json.optJSONObject(resolvedKey) ?: org.json.JSONObject()
            } catch (_: Exception) {
                org.json.JSONObject()
            }
        }
    }
}

data class StrideBlocksItem(
    val filled: Boolean? = null,
) {
    companion object {
        fun fromPath(path: String?): List<StrideBlocksItem>? {
            if (path == null) return null
            return try {
                val file = java.io.File(path)
                if (!file.exists()) return null
                fromJsonArray(org.json.JSONArray(file.readText()))
            } catch (_: Exception) {
                null
            }
        }

        fun fromJsonArray(array: org.json.JSONArray?): List<StrideBlocksItem>? {
            if (array == null) return null
            return List(array.length()) { index -> fromJson(array.optJSONObject(index)) }
        }

        fun fromJson(obj: org.json.JSONObject?): StrideBlocksItem {
            val json = obj ?: org.json.JSONObject()
            return StrideBlocksItem(
                filled = if (json.has("filled") && !json.isNull("filled")) json.optBoolean("filled") else false,
            )
        }
    }
}


private fun hwCurrentLocales(context: Context): List<String> {
    val configured = ConfigurationCompat
        .getLocales(context.resources.configuration)
    val tags = mutableListOf<String>()
    for (index in 0 until configured.size()) {
        val locale = configured[index] ?: continue
        val tag = locale.toLanguageTag()
        if (tag.isNotEmpty() && tag != "und") tags.add(tag)
    }
    if (tags.isEmpty()) {
        val fallback = Locale.getDefault().toLanguageTag()
        if (fallback.isNotEmpty() && fallback != "und") tags.add(fallback)
    }
    return tags
}

private fun hwFormatLocale(context: Context): Locale =
    ConfigurationCompat.getLocales(context.resources.configuration)[0]
        ?: Locale.getDefault()

private fun hwFormatDecimal(
    value: Number,
    minFraction: Int?,
    maxFraction: Int?,
    grouping: Boolean,
    locale: Locale,
): String {
    val formatter = NumberFormat.getNumberInstance(locale)
    formatter.isGroupingUsed = grouping
    minFraction?.let { formatter.minimumFractionDigits = it }
    maxFraction?.let { formatter.maximumFractionDigits = it }
    return formatter.format(value)
}
