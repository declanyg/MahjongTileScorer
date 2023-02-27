//
//  DictionaryInfo.swift
//  MahjongTileScorer
//
//  Created by Declan Young on 9/12/2021.
//

import SwiftUI

struct DictionaryInfo: View {
    var currentMethodName: String
    var currentMethodHand: [MahjongTile]
    var points: String
    var methodInfo: [String: String] = [
        //1 point
        "Flower Tile": "One point per flower tile",
        "No Flowers": "Hand contains no flower tiles",
        "Pung of Honours": "Hand contains a triplet of honour tiles",
        "No Honours": "Hand contains no honour tiles",
        "Self-Drawn Win": "Winning with a self-drawn tile",
        "Melded Kong": "Hand contains one open quad",
        "Robbing the Kong": "Winning with a tile that was used to promote a quad",
        "Last Tile Win Self-Drawn": "Winning on the last tile of the wall by self-drawing. Can combine with Self-Draw",
        "Concealed Hand": "Winning with a concealed hand",
        //2 points
        "Concealed Kong": "Hand contains a concealed quad",
        "Single Wait": "Winning with a single wait",
        "Closed Wait": "Winning with a closed wait",
        "Two Concealed Pungs": "Hand contains two concealed triplets",
        //3 points
        "No Honours or Flowers": "Hand contains no flower tiles or honour tiles. (Does not combine with No Flowers or No Honours)",
        "Fully Concealed Hand": "Going out on a fully concealed hand",
        "All Chows (with Flowers or Honours)": "Hand contains all sequences, flower tiles, and/or a pair of honour tiles",
        //5 points
        "Three Concealed Pungs": "Hand contains three concealed triplets",
        "Win Within 5 to 10 Discards": "Winning when there is more than 5 but less than 10 discards on the table",
        "Full Straight (Open)": "Hand contains three sequences from 1-9 of the same suit with at least one sequence open",
        "Little Three Winds": "Hand contains two triplets and a pair of wind tiles",
        //10 points
        "Half Flush": "Hand is composed of one suit and honour tiles",
        "All Pungs": "Hand contains all pungs",
        "Full Straight (Closed)": "Hand contains three seqeuences from 1-9 of the same suit with all sequences closed",
        "All Chows (without Flowers and Honours)": "Hand contains all sequences and no honour tiles or flower tiles",
        "All Revealed": "Winning wwith all open sets. The pair can be won by discard or self-draw",
        "Win Within 5 Discards": "Winning when there are 5 or less discards on the table",
        "Little Three Dragons": "Two triplets and a pair composed of dragon tiles",
        "Ready Hand": "Player has a ready hand with the initially dealt hand. The read hand must be announced and cannot be changed thereafter",
        "Big Three Winds": "Three triplets composed of wind tiles",
        "Four Concealed Pungs": "Hand contains four concealed triplets. Quads count as a concealed triplet",
        //20 points
        "7 Flowers And Robbing The 8th": "Having seven flowers and robbing the eight. No other scoring is counted",
        //30 points
        "All Flowers": "Having eight flower tiles. No other scoring is counted",
        "Little Four Winds": "Having three triplets and a pair composed of wind tiles",
        "Big Three Dragons": "Having three triplets composed of dragon tiles",
        "Seven Pairs and a Pung": "Hand contains seven pairs (identical or not) and one triplet",
        //40 points
        "Big Four Winds": "Hand contains four triplets composed of wind tiles",
        "Full Flush": "Hand is composed of one suit",
        "Blessing of Heaven": "Winning as the dealer on the initially dealt hand",
        "Blessing of Earth": "Winning as a non-dealer on the dealer's first discard",
        "Five Concealed Pungs": "Hand contains five concealed triplets. A quand counts as a concealed triplet"
    ]
    var body: some View {
        NavigationView {
            VStack {
                if currentMethodHand.count <= 4 {
                    HStack(alignment: .center) {
                        MahjongTileImages(currentMethodHand: currentMethodHand)
                    }.padding()
                }
                else {
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack {
                            MahjongTileImages(currentMethodHand: currentMethodHand)
                        }
                    }.frame(width: UIScreen.main.bounds.size.width - 80)
                    .padding()
                }
                Text(LocalizedStringKey(points))
                    .font(.system(size: 24))
                    .padding()
                Text(LocalizedStringKey(methodInfo[currentMethodName]!))
                    .frame(width: UIScreen.main.bounds.size.width - 80)
                
                Spacer()
            }
        }.navigationBarTitle(Text(LocalizedStringKey(currentMethodName)))
    }
}

struct MahjongTileImages: View {
    var currentMethodHand: [MahjongTile]
    var body: some View {
        ForEach(currentMethodHand) { tile in
            if tile.title == "" {
                Spacer(minLength: 24)
            }
            else {
                Image(tile.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 70)
            }
        }
    }
}

struct DictionaryInfo_Previews: PreviewProvider {
    static var previews: some View {
            DictionaryInfo(currentMethodName: "Flower Tile", currentMethodHand:[
                PublicVariables.mahjongTiles["一條"]!,
                PublicVariables.mahjongTiles["一條"]!,
                PublicVariables.mahjongTiles["一條"]!,
                PublicVariables.mahjongTiles["space"]!,
                PublicVariables.mahjongTiles["二條"]!,
                PublicVariables.mahjongTiles["二條"]!,
                PublicVariables.mahjongTiles["二條"]!
            ], points: "10 points")
        DictionaryInfo(currentMethodName: "Flower Tile", currentMethodHand:[
            PublicVariables.mahjongTiles["一條"]!,
            PublicVariables.mahjongTiles["一條"]!,
            PublicVariables.mahjongTiles["一條"]!,
        ], points: "20 points")
    }
}
