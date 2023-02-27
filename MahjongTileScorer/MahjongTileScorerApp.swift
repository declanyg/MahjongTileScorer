//
//  MahjongTileScorerApp.swift
//  MahjongTileScorer
//
//  Created by Declan Young on 2/11/2021.
//

import SwiftUI

@main
struct MahjongTileScorerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
