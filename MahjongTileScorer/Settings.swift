//
//  Settings.swift
//  MahjongTileScorer
//
//  Created by Declan Young on 3/2/2022.
//

import SwiftUI

struct Settings: View {
    @State var langauges = ["English", "Chinese"]
    @State var currentLanguage = "en"
    var body: some View {
        Picker(selection: $currentLanguage, label: Text("Language")) {
            ForEach(0..<langauges.count) {
                Text(langauges[$0])
                    .tag(langauges[$0])
            }
        }
    }
}



struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
