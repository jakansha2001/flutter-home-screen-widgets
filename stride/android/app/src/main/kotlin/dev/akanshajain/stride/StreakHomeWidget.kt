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
import androidx.glance.layout.Alignment
import androidx.glance.Image
import androidx.glance.ImageProvider
import androidx.glance.layout.ContentScale
import androidx.glance.layout.Row
import androidx.compose.ui.unit.dp
import androidx.glance.ColorFilter
import androidx.glance.layout.size
import es.antonborri.home_widget.HomeWidgetFonts
import androidx.glance.color.ColorProvider
import androidx.glance.LocalSize
import androidx.glance.layout.padding
import androidx.glance.appwidget.cornerRadius
import androidx.core.os.ConfigurationCompat
import java.util.Locale
import android.graphics.Bitmap
import android.graphics.BitmapFactory
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

class StreakHomeWidget : GlanceAppWidget() {
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
        StreakData.previewFromPreferences(HomeWidgetPlugin.getData(context))
    return listOf(
      "f5343661",
      hwLocales.joinToString(","),
      hwPreviewData.toString(),
      listOf(hwPreviewData.mascot).joinToString(",") { hwPath -> hwPath?.let { java.io.File(it).lastModified().toString() } ?: "" },
    ).joinToString("|")
  }

  @Composable
  private fun WidgetContent(context: Context, currentState: HomeWidgetGlanceState, preview: Boolean = false, textBounds: HomeWidgetFonts.TextBounds) {
    val prefs = currentState.preferences
    val widgetData =
        if (preview) StreakData.previewFromPreferences(prefs)
        else StreakData.fromPreferences(prefs)
    GlanceTheme {
            Box(modifier = GlanceModifier.background(ColorProvider(day = Color(0xFF111418), night = Color(0xFF111418))).fillMaxSize().clickable(onClick = actionStartActivity<MainActivity>(context, Uri.parse("stride://today?homeWidget"))), contentAlignment = Alignment.Center) {
                Box(modifier = GlanceModifier.fillMaxSize(), contentAlignment = Alignment.TopStart) {
                    Box(modifier = GlanceModifier.fillMaxSize()) {
                        widgetData.mascot?.let { path -> hwDecodeImage(context, path, null, null) }
                            ?.let { bitmap ->
                                Image(
                                    provider = ImageProvider(bitmap),
                                    contentDescription = "Dash",
                                    contentScale = ContentScale.Crop,
                                    modifier = GlanceModifier.fillMaxSize(),
                                )
                            }
                    }
                    Box(modifier = GlanceModifier.fillMaxSize(), contentAlignment = Alignment.TopStart) {
                        Box(modifier = GlanceModifier.padding(start = 10.0.dp, top = 10.0.dp, end = 10.0.dp, bottom = 10.0.dp)) {
                            if (widgetData.goalReached == true) {
                                Row(modifier = GlanceModifier.background(ColorProvider(day = Color(0xB3111418), night = Color(0xB3111418))).cornerRadius(14.0.dp).padding(start = 6.0.dp, top = 2.0.dp, end = 10.0.dp, bottom = 2.0.dp), verticalAlignment = Alignment.CenterVertically) {
                                    Image(modifier = GlanceModifier.size(20.dp), provider = ImageProvider(HomeWidgetFonts.iconBitmap(context, R.font.hw_font_streak__icons_materialicons, 0xE392, 20f)), contentDescription = null, colorFilter = ColorFilter.tint(ColorProvider(day = Color(0xFFFF7A1A), night = Color(0xFFFF7A1A))))
                                    Image(
                                        modifier = GlanceModifier.padding(start = 2.0.dp),
                                        provider = ImageProvider(
                                            if (textBounds.isProbe("271e1b52", LocalSize.current)) HomeWidgetFonts.probeBitmap()
                                            else HomeWidgetFonts.textBitmap(
                                                context,
                                                HomeWidgetFonts.typeface(context, "BarlowCondensed", 800, false),
                                                hwFormatDecimal((widgetData.streak ?: 0L), null, null, true, hwFormatLocale(context)),
                                                fontSizeSp = 22f,
                                                maxWidthDp = textBounds.width("271e1b52", LocalSize.current),
                                                maxHeightDp = textBounds.height("271e1b52", LocalSize.current),
                                            )
                                        ),
                                        contentDescription = if (textBounds.isProbe("271e1b52", LocalSize.current)) "hw_text_bounds:271e1b52" else hwFormatDecimal((widgetData.streak ?: 0L), null, null, true, hwFormatLocale(context)),
                                        colorFilter = ColorFilter.tint(ColorProvider(day = Color(0xFFFF7A1A), night = Color(0xFFFF7A1A))),
                                    )
                                }
                            } else {
                                Row(modifier = GlanceModifier.background(ColorProvider(day = Color(0xB3111418), night = Color(0xB3111418))).cornerRadius(14.0.dp).padding(start = 6.0.dp, top = 2.0.dp, end = 10.0.dp, bottom = 2.0.dp), verticalAlignment = Alignment.CenterVertically) {
                                    Image(modifier = GlanceModifier.size(20.dp), provider = ImageProvider(HomeWidgetFonts.iconBitmap(context, R.font.hw_font_streak__icons_materialicons, 0xE392, 20f)), contentDescription = null, colorFilter = ColorFilter.tint(ColorProvider(day = Color(0xFF8A9099), night = Color(0xFF8A9099))))
                                    Image(
                                        modifier = GlanceModifier.padding(start = 2.0.dp),
                                        provider = ImageProvider(
                                            if (textBounds.isProbe("271e1b52", LocalSize.current)) HomeWidgetFonts.probeBitmap()
                                            else HomeWidgetFonts.textBitmap(
                                                context,
                                                HomeWidgetFonts.typeface(context, "BarlowCondensed", 800, false),
                                                hwFormatDecimal((widgetData.streak ?: 0L), null, null, true, hwFormatLocale(context)),
                                                fontSizeSp = 22f,
                                                maxWidthDp = textBounds.width("271e1b52", LocalSize.current),
                                                maxHeightDp = textBounds.height("271e1b52", LocalSize.current),
                                            )
                                        ),
                                        contentDescription = if (textBounds.isProbe("271e1b52", LocalSize.current)) "hw_text_bounds:271e1b52" else hwFormatDecimal((widgetData.streak ?: 0L), null, null, true, hwFormatLocale(context)),
                                        colorFilter = ColorFilter.tint(ColorProvider(day = Color(0xFF8A9099), night = Color(0xFF8A9099))),
                                    )
                                }
                            }
                        }
                    }
                }
            }
    }

  }
}

data class StreakData(
    val goalReached: Boolean? = null,
    val streak: Long? = null,
    val mascot: String? = null,
) {
    companion object {
        private const val PREFERENCES_PREFIX = "home_widget.Streak"

        fun fromPreferences(prefs: android.content.SharedPreferences, now: Long = System.currentTimeMillis()): StreakData {
            val timedValues = resolveTimedValues(prefs, now)
            return StreakData(
                goalReached = if (prefs.contains("${PREFERENCES_PREFIX}.goalReached")) prefs.getBoolean("${PREFERENCES_PREFIX}.goalReached", false) else false,
                streak = if (prefs.contains("${PREFERENCES_PREFIX}.streak")) (try { prefs.getInt("${PREFERENCES_PREFIX}.streak", 0).toLong() } catch (_: ClassCastException) { prefs.getLong("${PREFERENCES_PREFIX}.streak", 0L) }) else 0L,
                mascot = if (timedValues.has("mascot") && !timedValues.isNull("mascot")) timedValues.optString("mascot") else null,
            )
        }

        fun previewFromPreferences(prefs: android.content.SharedPreferences, now: Long = System.currentTimeMillis()): StreakData {
            val timedValues = resolveTimedValues(prefs, now)
            return StreakData(
                goalReached = if (prefs.contains("${PREFERENCES_PREFIX}.goalReached")) prefs.getBoolean("${PREFERENCES_PREFIX}.goalReached", false) else false,
                streak = if (prefs.contains("${PREFERENCES_PREFIX}.streak")) (try { prefs.getInt("${PREFERENCES_PREFIX}.streak", 0).toLong() } catch (_: ClassCastException) { prefs.getLong("${PREFERENCES_PREFIX}.streak", 0L) }) else 12L,
                mascot = if (timedValues.has("mascot") && !timedValues.isNull("mascot")) timedValues.optString("mascot") else "assets/images/dash_goal.png",
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

private fun hwDecodeImage(
    context: Context,
    path: String,
    widthDp: Double?,
    heightDp: Double?,
): Bitmap? {
    fun decode(options: BitmapFactory.Options): Bitmap? =
        if (path.startsWith("/")) {
            BitmapFactory.decodeFile(path, options)
        } else {
            context.assets.open("flutter_assets/$path").use {
                BitmapFactory.decodeStream(it, null, options)
            }
        }

    fun sampleSize(bounds: BitmapFactory.Options): Int {
        if (bounds.outWidth <= 0 || bounds.outHeight <= 0) return 1
        val metrics = context.resources.displayMetrics
        val fallback = minOf(metrics.widthPixels, metrics.heightPixels)
        val widthPx = widthDp?.let { (it * metrics.density).toInt() }
        val heightPx = heightDp?.let { (it * metrics.density).toInt() }
        val targetWidth = widthPx
            ?: heightPx?.let {
                (it.toLong() * bounds.outWidth / bounds.outHeight).toInt().coerceAtLeast(1)
            }
            ?: fallback
        val targetHeight = heightPx
            ?: widthPx?.let {
                (it.toLong() * bounds.outHeight / bounds.outWidth).toInt().coerceAtLeast(1)
            }
            ?: fallback
        if (targetWidth <= 0 || targetHeight <= 0) return 1
        var sampleSize = 1
        while (bounds.outWidth / (sampleSize * 2) >= targetWidth &&
            bounds.outHeight / (sampleSize * 2) >= targetHeight) {
            sampleSize *= 2
        }
        return sampleSize
    }

    return try {
        val bounds = BitmapFactory.Options().apply { inJustDecodeBounds = true }
        decode(bounds)
        if (bounds.outWidth <= 0 || bounds.outHeight <= 0) {
            null
        } else {
            decode(
                BitmapFactory.Options().apply { inSampleSize = sampleSize(bounds) },
            )
        }
    } catch (_: Exception) {
        null
    }
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
