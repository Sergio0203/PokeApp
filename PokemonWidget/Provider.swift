////
////  Provider.swift
////  PokemonApp
////
////  Created by Sérgio César Lira Júnior on 17/09/24.
////
//import WidgetKit
//import SwiftUI
//import Foundation
//
//struct Provider: TimelineProvider {
//    func placeholder(in context: Context) -> SimpleEntry {
//        SimpleEntry(date: Date(), image: "square.and.arrow.up.fill")
//    }
//
//    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
//        let entry = SimpleEntry(date: Date(), image: "square.and.arrow.up.badge.clock.fill")
//        completion(entry)
//    }
//
//    func getTimeline(in context: Context, completion: @escaping (Timeline<EntryType>) -> ()) {
//        var entries: [SimpleEntry] = []
//
//        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
//        let currentDate = Date()
//        
//        for secondOffset in 0 ..< 30 {
//            let entryDate = Calendar.current.date(byAdding: .second, value: secondOffset, to: currentDate)!
//            let start = Calendar.current.startOfDay(for: entryDate)
//            let entry = SimpleEntry(date: start, image: "\(secondOffset)")
//            entries.append(entry)
//        }
//
//        let timeline = Timeline(entries: entries, policy: .atEnd)
//        completion(timeline)
//    }
//
////    func relevances() async -> WidgetRelevances<Void> {
////        // Generate a list containing the contexts this widget is relevant in.
////    }
//}
