package com.workmanager

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetPlugin


class NewAppWidget : AppWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
    ) {
        for (appWidgetId in appWidgetIds) {
            // Get reference to SharedPreferences
            val widgetData = HomeWidgetPlugin.getData(context)
            val views = RemoteViews(context.packageName, R.layout.new_app_widget).apply {

                val title = widgetData.getString("title", null)
                setTextViewText(R.id.headline_title, title ?: "No title set")

                val description = widgetData.getString("message", null)
                setTextViewText(R.id.headline_description, description ?: "No description set")

            }

            // Update the widget
            appWidgetManager.updateAppWidget(appWidgetId, views)
        }
    }
}