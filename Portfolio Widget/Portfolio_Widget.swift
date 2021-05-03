//
//  Portfolio_Widget.swift
//  Portfolio Widget
//
//  Created by CS3714 on 5/3/21.
//  Copyright © 2021 GameStock. All rights reserved.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent(), stockItem: apiGetStockData(stockSymbol: "AAPL"))
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration, stockItem: apiGetStockData(stockSymbol: "AAPL"))
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration, stockItem: apiGetStockData(stockSymbol: "AAPL"))
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
    public let stockItem: StockStruct
}

struct Portfolio_WidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        PortfolioWidgetView(stock: apiGetStockData(stockSymbol: "AAPL"))
    }
}

@main
struct Portfolio_Widget: Widget {
    let kind: String = "Portfolio_Widget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            Portfolio_WidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct Portfolio_Widget_Previews: PreviewProvider {
    static var previews: some View {
        Portfolio_WidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent(), stockItem: apiGetStockData(stockSymbol: "AAPL")))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
