//
//  PokemonWidget.swift
//  PokemonWidget
//
//  Created by Sérgio César Lira Júnior on 12/09/24.
//

import WidgetKit
import SwiftUI
import UIKit

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        
        let currentDate = Date()
        
        entries.append(SimpleEntry(date: currentDate))
        
        let timeline = Timeline(entries: entries, policy: .never)
        completion(timeline)
    }
    
    
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct PokemonWidgetEntryView : View {
    var entry: Provider.Entry
    
    @Environment(\.widgetFamily) var widgetFamily
   
    let data = DataService()
    var body: some View {
        HStack {
            pokemonImage
            
            if widgetFamily == .systemMedium {
                scores
            }
        }
        .padding()
    }
    
    @ViewBuilder
    private var scores: some View{
        Spacer()
        VStack(spacing: 20){
            Text("Highcore: \(data.highScore)")
            Text("Score: \(data.score)")
        }
        .foregroundStyle(.white)
        .fontWidth(.condensed)
        .fontWeight(.bold)
    }
    
    @ViewBuilder
    private var pokemonImage: some View {
        if let url = URL(string: data.pokemonData.sprites.front_default ?? ""),
               let imageData = try? Data(contentsOf: url),
               let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .brightness(data.isGuessed ? 0 : -1)
            }
    }
}

struct PokemonWidget: Widget {
    let kind: String = "PokemonWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                PokemonWidgetEntryView(entry: entry)
                    .containerBackground(.red.gradient, for: .widget)
                    
            } else {
                PokemonWidgetEntryView(entry: entry)
                    .background(.red.gradient)
                    
            }
        }
        .configurationDisplayName("Quem é esse pokemon?")
        .description("Todo dia um pokemmon diferente para adivinhar")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

