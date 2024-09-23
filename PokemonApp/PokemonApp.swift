//
//  PokemonAppApp.swift
//  PokemonApp
//
//  Created by Sérgio César Lira Júnior on 12/09/24.
//

import SwiftUI
import BackgroundTasks
@main
///TODO:  BackgroundTask
struct PokemonApp: App {
    var viewModel = HomeViewModel()
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
//        .backgroundTask(.appRefresh("NewPokemon")){
//            await scheduleAppRefresh()
//            await viewModel.fetchPokemon()
//        }
    }
    
//    func scheduleAppRefresh(){
//        let today = Calendar.current.startOfDay(for: .now)
//        let tomorrow = Calendar.current.date(byAdding: .minute, value: 1, to: today)!
//        let midnightComponent = DateComponents(hour: 0)
//        let midnight = Calendar.current.date(byAdding: midnightComponent, to: tomorrow)
//        
//        let request = BGAppRefreshTaskRequest(identifier: "NewPokemon")
//        request.earliestBeginDate = .now
//        try? BGTaskScheduler.shared.submit(request)
//    }
}
