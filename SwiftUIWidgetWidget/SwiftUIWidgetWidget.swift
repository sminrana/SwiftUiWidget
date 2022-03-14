//
//  SwiftUIWidgetWidget.swift
//  SwiftUIWidgetWidget
//
//  Created by Smin Rana on 3/13/22.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: TimelineProvider {
    func getSnapshot(in context: Context, completion: @escaping (QuoteEntry) -> Void) {
        let entry = QuoteEntry(date: Date(), description: "-")
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<QuoteEntry>) -> Void) {
        var entries: [QuoteEntry] = []

        // Get data in every hour
        let currentDate = Date()
        let entryDate = Calendar.current.date(byAdding: .second, value: 3600, to: currentDate)!

        // Call the Api to load data
        DailyQuoteApi().getDailyQuote(completion: { result, data in
            if result == .success {
                let d = try! JSONDecoder().decode(QuoteModel.self, from: data as! Data)
                
                let entry = QuoteEntry(date: entryDate, description: d.description)
                entries.append(entry)
                
                let timeline = Timeline(entries: entries, policy: .atEnd)
                completion(timeline)
            } else {
                // Error handle
            }
        })
    }
    
    func placeholder(in context: Context) -> QuoteEntry {
        QuoteEntry(date: Date(), description: "-")
    }
}

struct QuoteEntry: TimelineEntry {
    let date: Date
    let description: String
}

struct SwiftUIWidgetWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        Text(entry.description)
            .foregroundColor(Color.red)
    }
}

@main
struct SwiftUIWidgetWidget: Widget {
    let kind: String = "SwiftUIWidgetWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            SwiftUIWidgetWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct SwiftUIWidgetWidget_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIWidgetWidgetEntryView(entry: QuoteEntry(date: Date(), description: "Hello 1"))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
