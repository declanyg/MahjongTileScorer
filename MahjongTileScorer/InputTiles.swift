//
//  InputTiles.swift
//  MahjongTileScorer
//
//  Created by Declan Young on 3/11/2021.
//

import SwiftUI

struct InputTiles: View {
    @Binding var presentingInputView: Bool
    @Binding var individualCombinations: [Category]
    @State var specificTileCounter: [String:Int] = [:]
    @State var currentCombination = 7
    @Binding var totalTiles: Int
    //Other settings
    @Binding var discardsLessThanTen: Bool
    @Binding var numberOfDiscards: Int
    @Binding var isDealer: Bool
    @Binding var numberOfConsecutiveWins: Int
    @Binding var selfDrawnWin: Bool
    @Binding var lastTileInDeck: Bool
    @Binding var lastTile: String
    @Binding var lastCombination: [String]
    //Revealed Combinations settings
    @State var numberOfRevealedCombinations = 0
    @State var showingInputRevealedCombinations = false
    @State var tilesChosen = false
    @Binding var revealedCombinations: [Bool]
    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                HStack {
                    //Checks if the all selection is chosen
                    if currentCombination == 7 {
                        //Checks if the total tiles is 0. Shows select tiles prompt
                        if totalTiles == 0 {
                            Text("Select Tiles")
                                .font(.system(size: 30, weight: .light, design: .rounded))
                                .frame(height: 48)
                        }
                        else {
                            //Loops through all of the combinations and display them
                            ForEach(individualCombinations) { combination in
                                if combination.tiles.count == 0 {
                                    Spacer(minLength: 24)
                                }
                                ForEach(combination.tiles) { tile in
                                    Image(tile.imageName)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 48)
                                        .id(tile.id)
                                }
                            }
                        }
                    }
                    //Displays the select tiles prompt. This specific if statment included second to avoid crashes
                    else if individualCombinations[currentCombination].tiles.count == 0 {
                        Text("Select Tiles")
                            .font(.system(size: 30, weight: .light, design: .rounded))
                            .frame(height: 48)
                    }
                    //Displays the specific chosen combination
                    else {
                        ForEach(individualCombinations[currentCombination].tiles) { tile in
                            Image(tile.imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 48)
                                .id(tile.id)
                        }
                    }
                }.padding()
            }.frame(height: 80)
            //Creates the picker to input specific combinations
            Picker("Combination", selection: $currentCombination) {
                Text("All").tag(7)
                Text("1").tag(0)
                Text("2").tag(1)
                Text("3").tag(2)
                Text("4").tag(3)
                Text("5").tag(4)
                Text("麻將").tag(5)
                Text("花").tag(6)
            }.pickerStyle(SegmentedPickerStyle())
            //Creates a dropdown menu for the other settings
            DisclosureGroup("More Inputs") {
                ScrollView {
                    //Discards settings
                    Toggle(isOn: $discardsLessThanTen) {
                        Text("Discards Less Than 10")
                    }.padding()
                    //Shows specific amount of discards setting if the discards setting is toggled to true
                    //Possible discards is from 0 to 9 as those are below 10 and they are relevant in the scoring
                    if discardsLessThanTen {
                        Stepper("Number of Discards: \(numberOfDiscards)", value: $numberOfDiscards, in: 0...9)
                            .padding()
                            .onDisappear() {
                                //Resets the variable if the parent setting is switched off
                                numberOfDiscards = 0
                            }
                    }
                    //Dealer settings
                    Toggle(isOn: $isDealer) {
                        Text("Dealer")
                    }.padding()
                    //Shows specific amount of consectutive wins setting if the isDealer setting is toggled to true
                    if isDealer {
                        Stepper(LocalizedStringKey("Consecutive Wins: \(numberOfConsecutiveWins)"), value: $numberOfConsecutiveWins, in: 0...100)
                            .padding()
                            .onDisappear() {
                                //Resets the variable if the parent setting is switched off
                                numberOfConsecutiveWins = 0
                            }
                    }
                    //Self Drawn Win setting
                    Toggle(isOn: $selfDrawnWin) {
                        Text("Self Drawn Win")
                    }.padding()
                    //Shows Last Tile in Deck setting if self drawn
                    if selfDrawnWin {
                        Toggle(isOn: $lastTileInDeck) {
                            Text("Last Tile In Deck")
                        }.padding()
                            .onDisappear() {
                                //Resets the variable if the parent setting is switched off
                                lastTileInDeck = false
                            }
                    }
                    //Last Tile setting
                    HStack {
                        Text("Last Tile")
                            .padding()
                        Spacer()
                        Menu {
                            //Creates a picker for each tiles class
                            Picker(selection: $lastTile, label: Text("Dots")) {
                                //loops through all the dots mahjong tile names and creates a button in the picker
                                ForEach(0..<9) {
                                    Text(LocalizedStringKey(PublicVariables.mahjongTileNames[$0].capitalized))
                                        .tag(PublicVariables.mahjongTileNames[$0])
                                }
                            }.pickerStyle(.menu)
                            
                            Picker(selection: $lastTile, label: Text("Bamboo")) {
                                //loops through all the bamboo mahjong tile names and creates a button in the picker
                                ForEach(9..<18) {
                                    Text(LocalizedStringKey(PublicVariables.mahjongTileNames[$0].capitalized))
                                        .tag(PublicVariables.mahjongTileNames[$0])
                                }
                            }.pickerStyle(.menu)
                            
                            Picker(selection: $lastTile, label: Text("Character")) {
                                //loops through all the character mahjong tile names and creates a button in the picker
                                ForEach(18..<27) {
                                    Text(LocalizedStringKey(PublicVariables.mahjongTileNames[$0].capitalized))
                                        .tag(PublicVariables.mahjongTileNames[$0])
                                }
                            }.pickerStyle(.menu)
                            
                            Picker(selection: $lastTile, label: Text("Honours")) {
                                //loops through all the honours mahjong tile names and creates a button in the picker
                                ForEach(27..<34) {
                                    Text(LocalizedStringKey(PublicVariables.mahjongTileNames[$0].capitalized))
                                        .tag(PublicVariables.mahjongTileNames[$0])
                                }
                            }.pickerStyle(.menu)
                            
                        } label: {
                            //Sets the picker to look like the image of the chosen last tile
                            Image(lastTile)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 48)
                        }.padding()
                    }
                    //Last Combination setting
                    HStack {
                        Text("Last Combination")
                            .padding()

                        Spacer()
                        HStack {
                            //Creates tile pickers seen above through the use of a struct
                            TilePickerView(combinationArray: $lastCombination, index: 0)
                                .fixedSize()
                            TilePickerView(combinationArray: $lastCombination, index: 1)
                                .fixedSize()
                            TilePickerView(combinationArray: $lastCombination, index: 2)
                                .fixedSize()
                        }.padding()
                    }
                    //Revealed Tiles settings
                    HStack {
                        Button(action: {
                            print("tapped")
                            //Checking the final combination input setting
                            //Loops through the last combination and checks to see if any of the last tiles are blank.
                            var blankTileCount = 0
                            for i in 0..<lastCombination.count {
                                if lastCombination[i] == "back" {
                                    //Increases the variable by 1
                                    blankTileCount += 1
                                }
                            }

                            //Shows input revealed combiniations popup if conditions are met. Only 1 of the last tiles in the combination can be blank
                            if (blankTileCount < 2 && totalTiles >= 17) {
                                showingInputRevealedCombinations.toggle()
                            }
                            
                        }, label: {
                            Text("Revealed Combinations")
                                .foregroundColor(.black)
                                .padding()
                            Spacer()
                            Text(String(numberOfRevealedCombinations))
                                .foregroundColor(.black)
                                .padding()
                        }).sheet(isPresented: $showingInputRevealedCombinations, content: {
                            //Creates the instance of the input revealed combinations view with the Content View's variables as the parameters
                            InputRevealedCombinations(showingInputRevealedCombinations: $showingInputRevealedCombinations, specificTileCounter: $specificTileCounter, lastCombination: $lastCombination, individualCombinations: $individualCombinations, revealedCombinations: $revealedCombinations, numberOfRevealedCombinations: $numberOfRevealedCombinations)
                        })
                    }
                }.frame(height: 486)
            }.padding()
            .border(PublicVariables.purpleColour)
                    
            List() {
                //Loops through all of the sorted mahjong tile names stored in the PublicVariables class
                ForEach(PublicVariables.sortedMahjongTiles) { category in
                    //Creates a header for the specific mahjong tile category (the class)
                    Section(header: Text(LocalizedStringKey(category.title))) {
                        //Loops through each tile within the class
                        ForEach(category.tiles) { tile in
                            Button(action: {
                                print(tile.title.capitalized)
                                //Initializes the counter for the specific mahjong tile if it's not in the hashtable
                                if specificTileCounter[tile.title] == nil {
                                    specificTileCounter[tile.title] = 0
                                }
                                //Checks if the mahjong tile can be added. The condition are as follows:
                                //If the selection on the picker isn't "All" and
                                //If the selection on the picker is one of the combinations (excluding "All", "麻將" and "花"), the specific chosen combination on the picker has less than 4 tiles, and the amount of that specific tiles is less than 4 and the tile is not a flower
                                //Or the selection on the picker is “麻將" and there's less than 2 tiles
                                //Or the selection on the picker is "花", the flower hasn't been entered yet, and it's a flower
                                if currentCombination != 7  && ((currentCombination <= 4 && individualCombinations[currentCombination].tiles.count < 4 && specificTileCounter[tile.title]! < 4 && tile.className != "bonus") || (currentCombination == 5 && individualCombinations[currentCombination].tiles.count < 2) || (currentCombination == 6 && specificTileCounter[tile.title]! == 0 && tile.className == "bonus")) {
                                    //Adds new instance of the mahjong tile so that it is uniquely idetifiable by the ScrollViewReader
                                    individualCombinations[currentCombination].tiles.append(MahjongTile(title: tile.title, className: tile.className, value: tile.value, specificClassName: tile.specificClassName))
                                    //Increases the tile counter for that specific tile and the total tiles by 1
                                    specificTileCounter[tile.title]! += 1
                                    totalTiles += 1
                                    print("\(tile.title): \(specificTileCounter[tile.title]!)")
                                }
                            }) {
                            HStack {
                                Image(tile.imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 70)
                                VStack(alignment:.leading) {
                                    Text(LocalizedStringKey(tile.title.capitalized))
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
//Tile picker struct to reduce the amount of repeated code
struct TilePickerView: View {
    //Takes in an array and an index as a parameter. This allows for multiple tile pickers with separately stored values
    @Binding var combinationArray: [String]
    var index: Int
    
    var body: some View {
        Menu {
            Picker(selection: $combinationArray[index], label: Text("Dots")) {
                ForEach(0..<9) {
                    Text(LocalizedStringKey(PublicVariables.mahjongTileNames[$0].capitalized))
                        .tag(PublicVariables.mahjongTileNames[$0])
                }
            }.pickerStyle(.menu)
            
            Picker(selection: $combinationArray[index], label: Text("Bamboo")) {
                ForEach(9..<18) {
                    Text(LocalizedStringKey(PublicVariables.mahjongTileNames[$0].capitalized))
                        .tag(PublicVariables.mahjongTileNames[$0])
                }
            }.pickerStyle(.menu)
            
            Picker(selection: $combinationArray[index], label: Text("Character")) {
                ForEach(18..<27) {
                    Text(LocalizedStringKey(PublicVariables.mahjongTileNames[$0].capitalized))
                        .tag(PublicVariables.mahjongTileNames[$0])
                }
            }.pickerStyle(.menu)
            
            Picker(selection: $combinationArray[index], label: Text("Honours")) {
                ForEach(27..<34) {
                    Text(LocalizedStringKey(PublicVariables.mahjongTileNames[$0].capitalized))
                        .tag(PublicVariables.mahjongTileNames[$0])
                }
            }.pickerStyle(.menu)
            
        } label: {
            Image(combinationArray[index])
                .resizable()
                .scaledToFit()
                .frame(height: 48)
        }
    }
}


struct InputTiles_Previews: PreviewProvider {
    static var previews: some View {
        let handOfTiles = [
            Category(tiles: [PublicVariables.mahjongTiles["一萬"]!, PublicVariables.mahjongTiles["一萬"]!, PublicVariables.mahjongTiles["一萬"]!]),
            Category(tiles: [PublicVariables.mahjongTiles["二萬"]!, PublicVariables.mahjongTiles["二萬"]!, PublicVariables.mahjongTiles["二萬"]!]),
            Category(tiles: [PublicVariables.mahjongTiles["三萬"]!, PublicVariables.mahjongTiles["三萬"]!, PublicVariables.mahjongTiles["三萬"]!]),
            Category(tiles: [PublicVariables.mahjongTiles["四萬"]!, PublicVariables.mahjongTiles["四萬"]!, PublicVariables.mahjongTiles["四萬"]!]),
            Category(tiles: [PublicVariables.mahjongTiles["五萬"]!, PublicVariables.mahjongTiles["五萬"]!, PublicVariables.mahjongTiles["五萬"]!]),
            Category(tiles: [PublicVariables.mahjongTiles["六萬"]!, PublicVariables.mahjongTiles["六萬"]!]),
            Category(tiles: [PublicVariables.mahjongTiles["冬"]!])
        ]
        InputTiles(
            presentingInputView: .constant(true),
            individualCombinations: .constant(handOfTiles),
            totalTiles: .constant(17),
            discardsLessThanTen: .constant(true),
            numberOfDiscards: .constant(0),
            isDealer: .constant(true),
            numberOfConsecutiveWins: .constant(0),
            selfDrawnWin: .constant(true),
            lastTileInDeck: .constant(true),
            lastTile: .constant("back"),
            lastCombination: .constant(["back", "back", "back"]),
            revealedCombinations: .constant([false, false, false, false, false])
        )
    }
}


