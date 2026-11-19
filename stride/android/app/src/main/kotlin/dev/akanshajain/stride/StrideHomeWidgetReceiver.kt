// GENERATED CODE - DO NOT MODIFY BY HAND
package dev.akanshajain.stride

import android.content.Context
import es.antonborri.home_widget.HomeWidgetGlanceWidgetReceiver

class StrideHomeWidgetReceiver : HomeWidgetGlanceWidgetReceiver<StrideHomeWidget>() {
  override val glanceAppWidget = StrideHomeWidget()

  override fun previewFingerprint(context: Context): String =
      glanceAppWidget.previewFingerprint(context)
}
