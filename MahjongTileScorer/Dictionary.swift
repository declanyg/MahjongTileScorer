//
//  Dictionary.swift
//  MahjongTileScorer
//
//  Created by Declan Young on 9/11/2021.
//

import SwiftUI

struct Dictionary: View {
    var body: some View {
        NavigationView {
            List() {
                ForEach(scoringMethodsArray) { category in
                    Section(header: Text(LocalizedStringKey(category.title))) {
                        ForEach(category.methods) {method in
                            NavigationLink(destination: DictionaryInfo(currentMethodName: method.title, currentMethodHand: method.tiles, points: category.title)) {
                                HStack {
                                    Text(LocalizedStringKey(method.title))
                                        .font(.system(size: 16))
                                        .frame(width:150)
                                        .multilineTextAlignment(.center)
                                    ScrollView(.horizontal) {
                                        HStack {
                                            ForEach(method.tiles) { tile in
                                                if tile.title == "" {
                                                Spacer(minLength: 24)
                                                }
                                                else {
                                                    Image(tile.imageName)
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(height: 48)
                                                }
                                            }
                                        }
                                    }
                                }.frame(height: 50)
                            }
                        }
                    }
                }
            }.navigationBarTitle(Text("Dictionary"))
        }
    }
    
    var scoringMethodsArray = [
        Category (title: "1 Point", methods: [
            ScoringMethod(title: "Flower Tile", tiles: [MahjongTile(title: "spring", className: "bonus")]),
            ScoringMethod(title:"No Flowers"),
            ScoringMethod(title:"Pung of Honours", tiles: [MahjongTile] (repeating: MahjongTile(title: "red dragon", className: "honours"), count: 3)),
            ScoringMethod(title:"No Honours"),
            ScoringMethod(title: "Self-Drawn Win"),
            ScoringMethod(title: "Melded Kong", tiles: [MahjongTile] (repeating: MahjongTile(title: "1 bamboo", className: "bamboo", value: 1), count: 4)),
            ScoringMethod(title: "Robbing the Kong"),
            ScoringMethod(title: "Last Tile Win Self-Drawn"),
            ScoringMethod(title: "Concealed Hand")
            ]),
        Category (title: "2 Points", methods: [
            ScoringMethod(title: "Concealed Kong", tiles: [MahjongTile] (repeating: MahjongTile(title: "back"), count: 4)),
            ScoringMethod(title: "Single Wait"),
            ScoringMethod(title: "Closed Wait"),
            ScoringMethod(title: "Two Concealed Pungs", tiles: [
                MahjongTile(title: "back"),MahjongTile(title: "back"),MahjongTile(title: "back"), MahjongTile(title: ""), MahjongTile(title: "back"), MahjongTile(title: "back"), MahjongTile(title: "back")]),
        ]),
        Category (title: "3 Points", methods : [
            ScoringMethod(title: "No Honours or Flowers"),
            ScoringMethod(title: "Fully Concealed Hand"),
            ScoringMethod(title: "All Chows (with Flowers or Honours)", tiles: [
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["space"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["space"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["space"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["space"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["space"]!,
                PublicVariables.mahjongTiles["???"]!,
                PublicVariables.mahjongTiles["???"]!
            ])
        ]),
        Category (title: "5 Points", methods : [
            ScoringMethod(title: "Three Concealed Pungs", tiles: [
                PublicVariables.mahjongTiles["back"]!,
                PublicVariables.mahjongTiles["back"]!,
                PublicVariables.mahjongTiles["back"]!,
                PublicVariables.mahjongTiles["space"]!,
                PublicVariables.mahjongTiles["back"]!,
                PublicVariables.mahjongTiles["back"]!,
                PublicVariables.mahjongTiles["back"]!,
                PublicVariables.mahjongTiles["space"]!,
                PublicVariables.mahjongTiles["back"]!,
                PublicVariables.mahjongTiles["back"]!,
                PublicVariables.mahjongTiles["back"]!
            ]),
            ScoringMethod(title: "Win Within 5 to 10 Discards"),
            ScoringMethod(title: "Full Straight (Open)", tiles: [
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["space"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["space"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["??????"]!
            ]),
            ScoringMethod(title: "Little Three Winds", tiles: [
                PublicVariables.mahjongTiles["???"]!,
                PublicVariables.mahjongTiles["???"]!,
                PublicVariables.mahjongTiles["???"]!,
                PublicVariables.mahjongTiles["space"]!,
                PublicVariables.mahjongTiles["???"]!,
                PublicVariables.mahjongTiles["???"]!,
                PublicVariables.mahjongTiles["???"]!,
                PublicVariables.mahjongTiles["space"]!,
                PublicVariables.mahjongTiles["???"]!,
                PublicVariables.mahjongTiles["???"]!,
            ])
        ]),
        Category (title: "10 Points", methods : [
            ScoringMethod(title: "Half Flush", tiles: [
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["space"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["space"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["space"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["space"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["space"]!,
                PublicVariables.mahjongTiles["???"]!,
                PublicVariables.mahjongTiles["???"]!,
            ]),
            ScoringMethod(title: "All Pungs", tiles: [
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["space"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["space"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["space"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["space"]!,
                PublicVariables.mahjongTiles["???"]!,
                PublicVariables.mahjongTiles["???"]!,
                PublicVariables.mahjongTiles["???"]!,
                PublicVariables.mahjongTiles["space"]!,
                PublicVariables.mahjongTiles["???"]!,
                PublicVariables.mahjongTiles["???"]!
            ]),
            ScoringMethod(title: "Full Straight (Closed)", tiles: [
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["space"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["space"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["??????"]!
            ]),
            ScoringMethod(title: "All Chows (without Flowers and Honours)", tiles: [
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["space"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["space"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["space"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["space"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["space"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["??????"]!
            ]),
            ScoringMethod(title: "All Revealed"),
            ScoringMethod(title: "Win Within 5 Discards"),
            ScoringMethod(title: "Little Three Dragons", tiles:[
                PublicVariables.mahjongTiles["???"]!,
                PublicVariables.mahjongTiles["???"]!,
                PublicVariables.mahjongTiles["???"]!,
                PublicVariables.mahjongTiles["space"]!,
                PublicVariables.mahjongTiles["???"]!,
                PublicVariables.mahjongTiles["???"]!,
                PublicVariables.mahjongTiles["???"]!,
                PublicVariables.mahjongTiles["space"]!,
                PublicVariables.mahjongTiles["???"]!,
                PublicVariables.mahjongTiles["???"]!
            ]),
            ScoringMethod(title: "Ready Hand"),
            ScoringMethod(title: "Big Three Winds", tiles: [
                PublicVariables.mahjongTiles["???"]!,
                PublicVariables.mahjongTiles["???"]!,
                PublicVariables.mahjongTiles["???"]!,
                PublicVariables.mahjongTiles["space"]!,
                PublicVariables.mahjongTiles["???"]!,
                PublicVariables.mahjongTiles["???"]!,
                PublicVariables.mahjongTiles["???"]!,
                PublicVariables.mahjongTiles["space"]!,
                PublicVariables.mahjongTiles["???"]!,
                PublicVariables.mahjongTiles["???"]!,
                PublicVariables.mahjongTiles["???"]!
            ]),
            ScoringMethod(title: "Four Concealed Pungs", tiles: [
                PublicVariables.mahjongTiles["back"]!,
                PublicVariables.mahjongTiles["back"]!,
                PublicVariables.mahjongTiles["back"]!,
                PublicVariables.mahjongTiles["space"]!,
                PublicVariables.mahjongTiles["back"]!,
                PublicVariables.mahjongTiles["back"]!,
                PublicVariables.mahjongTiles["back"]!,
                PublicVariables.mahjongTiles["space"]!,
                PublicVariables.mahjongTiles["back"]!,
                PublicVariables.mahjongTiles["back"]!,
                PublicVariables.mahjongTiles["back"]!,
            ])
        ]),
        Category (title: "20 Points", methods : [
            ScoringMethod(title: "7 Flowers And Robbing The 8th")
        ]),
        Category (title: "30 Points", methods : [
            ScoringMethod(title: "All Flowers", tiles: [
                PublicVariables.mahjongTiles["???"]!,
                PublicVariables.mahjongTiles["???"]!,
                PublicVariables.mahjongTiles["???"]!,
                PublicVariables.mahjongTiles["???"]!,
                PublicVariables.mahjongTiles["???"]!,
                PublicVariables.mahjongTiles["???"]!,
                PublicVariables.mahjongTiles["???"]!,
                PublicVariables.mahjongTiles["???"]!
            ]),
            ScoringMethod(title: "Little Four Winds", tiles:[
                PublicVariables.mahjongTiles["???"]!,
                PublicVariables.mahjongTiles["???"]!,
                PublicVariables.mahjongTiles["???"]!,
                PublicVariables.mahjongTiles["space"]!,
                PublicVariables.mahjongTiles["???"]!,
                PublicVariables.mahjongTiles["???"]!,
                PublicVariables.mahjongTiles["???"]!,
                PublicVariables.mahjongTiles["space"]!,
                PublicVariables.mahjongTiles["???"]!,
                PublicVariables.mahjongTiles["???"]!,
                PublicVariables.mahjongTiles["???"]!,
                PublicVariables.mahjongTiles["???"]!,
                PublicVariables.mahjongTiles["???"]!
            ]),
            ScoringMethod(title: "Big Three Dragons", tiles: [
                PublicVariables.mahjongTiles["???"]!,
                PublicVariables.mahjongTiles["???"]!,
                PublicVariables.mahjongTiles["???"]!,
                PublicVariables.mahjongTiles["space"]!,
                PublicVariables.mahjongTiles["???"]!,
                PublicVariables.mahjongTiles["???"]!,
                PublicVariables.mahjongTiles["???"]!,
                PublicVariables.mahjongTiles["space"]!,
                PublicVariables.mahjongTiles["???"]!,
                PublicVariables.mahjongTiles["???"]!,
                PublicVariables.mahjongTiles["???"]!
            ]),
            ScoringMethod(title: "Seven Pairs and a Pung", tiles: [
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["space"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["space"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["space"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["space"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["space"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["space"]!,
                PublicVariables.mahjongTiles["???"]!,
                PublicVariables.mahjongTiles["???"]!
            ])
        ]),
        Category (title: "40 Points", methods : [
            ScoringMethod(title: "Big Four Winds", tiles: [
                PublicVariables.mahjongTiles["???"]!,
                PublicVariables.mahjongTiles["???"]!,
                PublicVariables.mahjongTiles["???"]!,
                PublicVariables.mahjongTiles["space"]!,
                PublicVariables.mahjongTiles["???"]!,
                PublicVariables.mahjongTiles["???"]!,
                PublicVariables.mahjongTiles["???"]!,
                PublicVariables.mahjongTiles["space"]!,
                PublicVariables.mahjongTiles["???"]!,
                PublicVariables.mahjongTiles["???"]!,
                PublicVariables.mahjongTiles["???"]!,
                PublicVariables.mahjongTiles["space"]!,
                PublicVariables.mahjongTiles["???"]!,
                PublicVariables.mahjongTiles["???"]!,
                PublicVariables.mahjongTiles["???"]!
            ]),
            ScoringMethod(title: "Full Flush", tiles: [
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["space"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["space"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["space"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["space"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["space"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["??????"]!,
                PublicVariables.mahjongTiles["??????"]!,
            ]),
            ScoringMethod(title: "Blessing of Heaven"),
            ScoringMethod(title: "Blessing of Earth"),
            ScoringMethod(title: "Five Concealed Pungs", tiles: [
                PublicVariables.mahjongTiles["back"]!,
                PublicVariables.mahjongTiles["back"]!,
                PublicVariables.mahjongTiles["back"]!,
                PublicVariables.mahjongTiles["space"]!,
                PublicVariables.mahjongTiles["back"]!,
                PublicVariables.mahjongTiles["back"]!,
                PublicVariables.mahjongTiles["back"]!,
                PublicVariables.mahjongTiles["space"]!,
                PublicVariables.mahjongTiles["back"]!,
                PublicVariables.mahjongTiles["back"]!,
                PublicVariables.mahjongTiles["back"]!,
                PublicVariables.mahjongTiles["space"]!,
                PublicVariables.mahjongTiles["back"]!,
                PublicVariables.mahjongTiles["back"]!,
                PublicVariables.mahjongTiles["back"]!,
                PublicVariables.mahjongTiles["space"]!,
                PublicVariables.mahjongTiles["back"]!,
                PublicVariables.mahjongTiles["back"]!,
                PublicVariables.mahjongTiles["back"]!,
            ])
        ])
    ]
    
}

struct Dictionary_Previews: PreviewProvider {
    static var previews: some View {
        Dictionary()
    }
}

