//
//  LunchTimeApp.swift
//  LunchTime
//
//  Created by Devin Eror on 11/14/23.
//

import SwiftUI
import SwiftData



@main
struct LunchTimeApp: App {
    
    let container: ModelContainer = {
        let schema = Schema([FavoriteSpot.self])
        let container = try! ModelContainer(for: schema, configurations: [])
        return container
    }()
    
    var body: some Scene {
        WindowGroup {
            let spotsModel: SpotsModel = SpotsModel()
            
            ContentView(spotsModel: spotsModel)
        }
        .modelContainer(container)
    }
}
