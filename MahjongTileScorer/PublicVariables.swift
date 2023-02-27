//
//  PublicVariables.swift
//  MahjongTileScorer
//
//  Created by Declan Young on 2/11/2021.
//


import SwiftUI

class PublicVariables {
    //Allows for the easy reuse of the purple colour highlight
    static var purpleColour = Color(red: 151/255, green: 79/255, blue: 202/255)
    //Creating a dictionary containing each of the mahjong tiles for easy creation of specific tiles and to display in the input view
    static var mahjongTiles: [String:MahjongTile] = [
        //Circle tiles
        "一餅": MahjongTile(title: "1 dot", className: "dot", value: 1),
        "二餅": MahjongTile(title: "2 dot", className: "dot", value: 2),
        "三餅": MahjongTile(title: "3 dot", className: "dot", value: 3),
        "四餅": MahjongTile(title: "4 dot", className: "dot", value: 4),
        "五餅": MahjongTile(title: "5 dot", className: "dot", value: 5),
        "六餅": MahjongTile(title: "6 dot", className: "dot", value: 6),
        "七餅": MahjongTile(title: "7 dot", className: "dot", value: 7),
        "八餅": MahjongTile(title: "8 dot", className: "dot", value: 8),
        "九餅": MahjongTile(title: "9 dot", className: "dot", value: 9),
        //Line tiles
        "一條": MahjongTile(title: "1 bamboo", className: "bamboo", value: 1),
        "二條": MahjongTile(title: "2 bamboo", className: "bamboo", value: 2),
        "三條": MahjongTile(title: "3 bamboo", className: "bamboo", value: 3),
        "四條": MahjongTile(title: "4 bamboo", className: "bamboo", value: 4),
        "五條": MahjongTile(title: "5 bamboo", className: "bamboo", value: 5),
        "六條": MahjongTile(title: "6 bamboo", className: "bamboo", value: 6),
        "七條": MahjongTile(title: "7 bamboo", className: "bamboo", value: 7),
        "八條": MahjongTile(title: "8 bamboo", className: "bamboo", value: 8),
        "九條": MahjongTile(title: "9 bamboo", className: "bamboo", value: 9),
        //Ten thousand tiles
        "一萬": MahjongTile(title: "1 character", className: "character", value: 1),
        "二萬": MahjongTile(title: "2 character", className: "character", value: 2),
        "三萬": MahjongTile(title: "3 character", className: "character", value: 3),
        "四萬": MahjongTile(title: "4 character", className: "character", value: 4),
        "五萬": MahjongTile(title: "5 character", className: "character", value: 5),
        "六萬": MahjongTile(title: "6 character", className: "character", value: 6),
        "七萬": MahjongTile(title: "7 character", className: "character", value: 7),
        "八萬": MahjongTile(title: "8 character", className: "character", value: 8),
        "九萬": MahjongTile(title: "9 character", className: "character", value: 9),
        //Honours tiles
        "東": MahjongTile(title: "east wind", className: "honours"),
        "南": MahjongTile(title: "south wind", className: "honours"),
        "西": MahjongTile(title: "west wind", className: "honours"),
        "北": MahjongTile(title: "north wind", className: "honours"),
        "中": MahjongTile(title: "red dragon", className: "honours"),
        "發": MahjongTile(title: "green dragon", className: "honours"),
        "白": MahjongTile(title: "white dragon", className: "honours"),
        //Bonus Tiles
        "春": MahjongTile(title: "spring", className: "bonus"),
        "夏": MahjongTile(title: "summer", className: "bonus"),
        "秋": MahjongTile(title: "autumn", className: "bonus"),
        "冬": MahjongTile(title: "winter", className: "bonus"),
        "梅": MahjongTile(title: "plum", className: "bonus"),
        "蘭": MahjongTile(title: "orchid", className: "bonus"),
        "菊": MahjongTile(title: "chrysanthemum", className: "bonus"),
        "竹": MahjongTile(title: "bamboo", className: "bonus"),
        //Miscellaneous Tile
        "back": MahjongTile(title: "back"),
        "space": MahjongTile(title: "")
    ]
    static var sortedMahjongTiles: [Category] = [
        Category (title: "Dots", tiles: [
            MahjongTile(title: "1 dot", className: "dot", value: 1),
            MahjongTile(title: "2 dot", className: "dot", value: 2),
            MahjongTile(title: "3 dot", className: "dot", value: 3),
            MahjongTile(title: "4 dot", className: "dot", value: 4),
            MahjongTile(title: "5 dot", className: "dot", value: 5),
            MahjongTile(title: "6 dot", className: "dot", value: 6),
            MahjongTile(title: "7 dot", className: "dot", value: 7),
            MahjongTile(title: "8 dot", className: "dot", value: 8),
            MahjongTile(title: "9 dot", className: "dot", value: 9)
        ]),
        Category (title: "Bamboos", tiles: [
            MahjongTile(title: "1 bamboo", className: "bamboo", value: 1),
            MahjongTile(title: "2 bamboo", className: "bamboo", value: 2),
            MahjongTile(title: "3 bamboo", className: "bamboo", value: 3),
            MahjongTile(title: "4 bamboo", className: "bamboo", value: 4),
            MahjongTile(title: "5 bamboo", className: "bamboo", value: 5),
            MahjongTile(title: "6 bamboo", className: "bamboo", value: 6),
            MahjongTile(title: "7 bamboo", className: "bamboo", value: 7),
            MahjongTile(title: "8 bamboo", className: "bamboo", value: 8),
            MahjongTile(title: "9 bamboo", className: "bamboo", value: 9)
        ]),
        Category (title: "Characters", tiles: [
            MahjongTile(title: "1 character", className: "character", value: 1),
            MahjongTile(title: "2 character", className: "character", value: 2),
            MahjongTile(title: "3 character", className: "character", value: 3),
            MahjongTile(title: "4 character", className: "character", value: 4),
            MahjongTile(title: "5 character", className: "character", value: 5),
            MahjongTile(title: "6 character", className: "character", value: 6),
            MahjongTile(title: "7 character", className: "character", value: 7),
            MahjongTile(title: "8 character", className: "character", value: 8),
            MahjongTile(title: "9 character", className: "character", value: 9)
        ]),
        Category (title: "Honours", tiles: [
            MahjongTile(title: "east wind", className: "honours", specificClassName: "winds"),
            MahjongTile(title: "south wind", className: "honours", specificClassName: "winds"),
            MahjongTile(title: "west wind", className: "honours", specificClassName: "winds"),
            MahjongTile(title: "north wind", className: "honours", specificClassName: "winds"),
            MahjongTile(title: "red dragon", className: "honours", specificClassName: "dragons"),
            MahjongTile(title: "green dragon", className: "honours", specificClassName: "dragons"),
            MahjongTile(title: "white dragon", className: "honours", specificClassName: "dragons")
        ]),
        Category (title: "Bonuses", tiles: [
            MahjongTile(title: "spring", className: "bonus"),
            MahjongTile(title: "summer", className: "bonus"),
            MahjongTile(title: "autumn", className: "bonus"),
            MahjongTile(title: "winter", className: "bonus"),
            MahjongTile(title: "plum", className: "bonus"),
            MahjongTile(title: "orchid", className: "bonus"),
            MahjongTile(title: "chrysanthemum", className: "bonus"),
            MahjongTile(title: "bamboo", className: "bonus")
        ])
    ]
    //Input View
    //Used for the specific tile input funciton
    static var mahjongTileNames: [String] = [
        "1 dot", "2 dot", "3 dot", "4 dot", "5 dot", "6 dot", "7 dot", "8 dot", "9 dot",
        "1 bamboo", "2 bamboo", "3 bamboo", "4 bamboo", "5 bamboo", "6 bamboo", "7 bamboo", "8 bamboo", "9 bamboo",
        "1 character", "2 character", "3 character", "4 character", "5 character", "6 character", "7 character", "8 character", "9 character",
        "east wind", "south wind", "west wind", "north wind", "red dragon", "green dragon", "white dragon",
        "back"
    ]
    //Breakdown View
    //Used to help segue back to the home screen
    static var doneButtonClicked: Bool = false
    
    //Settings
    static var currentLanguage: String = "en"
}


struct MahjongTile: Identifiable {
    var id = UUID()
    var title: String = ""
    var className: String = "None"
    var value: Int = -1
    var imageName: String {return title}
    var specificClassName: String = "None"
}

struct Category: Identifiable {
    var id = UUID()
    var title: String = ""
    var tiles: [MahjongTile] = []
    var methods: [ScoringMethod] = []
}

struct ScoringMethod: Identifiable {
    var id = UUID()
    var title: String
    var tiles: [MahjongTile] = []
}
