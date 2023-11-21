//
//  LunchTimeApp.swift
//  LunchTime
//
//  Created by Devin Eror on 11/14/23.
//

import SwiftUI



@main
struct LunchTimeApp: App {
    var body: some Scene {
        WindowGroup {
            let spotsModel: SpotsModel = SpotsModel()
            
            ContentView(spotsModel: spotsModel)
        }
    }
}
