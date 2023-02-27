//
//  InputRevealedCombinations.swift
//  MahjongTileScorer
//
//  Created by Declan Young on 28/12/2021.
//

import SwiftUI

struct InputRevealedCombinations: View {
    @Binding var showingInputRevealedCombinations: Bool
    @Binding var specificTileCounter: [String:Int]
    @Binding var lastCombination: [String]
    @Binding var individualCombinations: [Category]
    @Binding var revealedCombinations: [Bool]
    @Binding var numberOfRevealedCombinations: Int
    @State var kongAdded = false
    @State var kongsAdded = 0
    var body: some View {
        NavigationView {
            List() {
                //Loop through all tiles
                ForEach(0..<individualCombinations.count - 2) { i in
                    Button(action: {
                        print("tapped")
                        revealedCombinations[i].toggle()
                    }) {
                        HStack {
                            ForEach(individualCombinations[i].tiles) { tile in
                                Image(tile.imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 70)
                                    .id(tile.id)
                            }
                            if revealedCombinations[i] {
                                Spacer()
                                Image(systemName: "checkmark")
                                    .resizable()
                                    .frame(width: 12, height: 12)
                                    .padding()
                            }
                        }
                    }
                }
            }.padding()
                .navigationBarTitle(Text("Revealed Combinations"), displayMode: .inline)
                .navigationBarItems(
                    trailing: Button(action: {
                        print("Dismissing sheet view...")
                        numberOfRevealedCombinations = revealedCombinations.filter{$0}.count
                        showingInputRevealedCombinations = false
                    }) {
                        Text("Done").bold()
                    })

        }
    }
}

struct InputRevealedCombinations_Previews: PreviewProvider {
    
    static var handOfTiles = [
        PublicVariables.mahjongTiles["一萬"]!,
        PublicVariables.mahjongTiles["二萬"]!,
        PublicVariables.mahjongTiles["三萬"]!,
        PublicVariables.mahjongTiles["四萬"]!,
        PublicVariables.mahjongTiles["五萬"]!,
        PublicVariables.mahjongTiles["六萬"]!,
        PublicVariables.mahjongTiles["七萬"]!,
        PublicVariables.mahjongTiles["八萬"]!,
        PublicVariables.mahjongTiles["九萬"]!,
        PublicVariables.mahjongTiles["中"]!,
        PublicVariables.mahjongTiles["中"]!,
        PublicVariables.mahjongTiles["中"]!,
        PublicVariables.mahjongTiles["中"]!,
        PublicVariables.mahjongTiles["發"]!,
        PublicVariables.mahjongTiles["發"]!,
        PublicVariables.mahjongTiles["發"]!,
        PublicVariables.mahjongTiles["九條"]!,
        PublicVariables.mahjongTiles["九條"]!
    ]
    static var individualCombinations = [
        Category(tiles: [PublicVariables.mahjongTiles["一萬"]!, PublicVariables.mahjongTiles["一萬"]!, PublicVariables.mahjongTiles["一萬"]!]),
        Category(tiles: [PublicVariables.mahjongTiles["二萬"]!, PublicVariables.mahjongTiles["二萬"]!, PublicVariables.mahjongTiles["二萬"]!]),
        Category(tiles: [PublicVariables.mahjongTiles["三萬"]!, PublicVariables.mahjongTiles["三萬"]!, PublicVariables.mahjongTiles["三萬"]!]),
        Category(tiles: [PublicVariables.mahjongTiles["四萬"]!, PublicVariables.mahjongTiles["四萬"]!, PublicVariables.mahjongTiles["四萬"]!]),
        Category(tiles: [PublicVariables.mahjongTiles["五萬"]!, PublicVariables.mahjongTiles["五萬"]!, PublicVariables.mahjongTiles["五萬"]!]),
        Category(tiles: [PublicVariables.mahjongTiles["六萬"]!, PublicVariables.mahjongTiles["六萬"]!]),
        Category(tiles: [PublicVariables.mahjongTiles["冬"]!])
    ]
    
    static var previews: some View {
        InputRevealedCombinations(showingInputRevealedCombinations: .constant(false), specificTileCounter: .constant(["temp":1]), lastCombination: .constant(["2 dot", "2 dot", "2 dot"]), individualCombinations: .constant(individualCombinations), revealedCombinations: .constant([false, false, false, false, false]), numberOfRevealedCombinations: .constant(3))
    }
}
