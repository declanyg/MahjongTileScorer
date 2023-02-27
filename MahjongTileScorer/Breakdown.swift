//
//  Breakdown.swift
//  MahjongTileScorer
//
//  Created by Declan Young on 15/11/2021.
//

import SwiftUI

struct Breakdown: View {
    @Binding var showingBreakdown: Bool
    @Binding var scoredValues: [String:Int]
    @Binding var totalPoints: Int
    @Binding var individualCombinations: [Category]
    @State var dictionaryOfApplicableScoringMethods: [String: Int] = [:]
    var body: some View {
        NavigationView {
            VStack {
                ScrollView(.horizontal) {
                    HStack {
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
                }.padding()
                
                Text(LocalizedStringKey("Total Points: \(totalPoints)"))
                
                List() {
                    ForEach(scoredValues.sorted(by: >), id: \.key) { key, value in
                        HStack {
                            Text(LocalizedStringKey(key))
                            Spacer()
                            Text(String(value))
                        }
                    }
                }
                
                Spacer()
            }.padding()
                .navigationBarTitle(Text("Breakdown"), displayMode: .inline)
                .navigationBarItems(leading: Button(action: {
                    print("Dismissing sheet view...")
                    showingBreakdown = false
                    PublicVariables.doneButtonClicked = false
                }) {
                    Text("Cancel").bold()
                },
                    trailing: Button(action: {
                        print("Dismissing sheet view...")
                        showingBreakdown = false
                        PublicVariables.doneButtonClicked = true
                    }) {
                        Text("Done").bold()
                    })

        }.accentColor(PublicVariables.purpleColour)
    }
}

func scoreTiles(individualCombinations: [Category], discardsLessThanTen: Bool, numberOfDiscards: Int, isDealer: Bool, numberOfConsecutiveWins: Int, selfDrawnWin: Bool, lastTileInDeck: Bool, lastTile: String, lastCombination: [String], revealedCombinations: [Bool]) -> (Int, [String:Int]) {
    var totalPoints = 0
    var appliedMethods: [String: Int] = [:]
    
    //Flower points
    let numberOfFlowers = individualCombinations[6].tiles.count
    switch numberOfFlowers {
        case 8: //All Flowers
            totalPoints += 30
            appliedMethods["All Flowers"] = 30
            return (totalPoints, appliedMethods)
        case 0:
            break
        default: //Flower Tile
            totalPoints += numberOfFlowers
            appliedMethods["Flower Tile"] = numberOfFlowers
            break
    }
    
    //Self Drawn Win
    if selfDrawnWin {
        totalPoints += 1
        appliedMethods["Self-Drawn Win"] = 1
    }
    //Last Tile in Deck Self-Drawn
    if lastTileInDeck && selfDrawnWin {
        totalPoints += 1
        appliedMethods["Last Tile Win Self-Drawn"] = 1
    }
    
    //Discards points
    switch numberOfDiscards {
    case 0: //Blessing of Heaven
        //You can only win with 0 discards
        if discardsLessThanTen == true && isDealer {
            totalPoints += 40
            appliedMethods["Blessing of Heaven"] = 40
        }
        break
    case 1: //Blessing of Earth
        if !isDealer {
            totalPoints += 40
            appliedMethods["Blessing of Earth"] = 40
        }
        break
    default:
        if numberOfDiscards < 5 { //Win within 5 discards
            totalPoints += 10
            appliedMethods["Win Within 5 Discards"] = 10
        }
        else { //Win within 5 to 10 discards
            totalPoints += 5
            appliedMethods["Win Within 5 To 10 Discards"] = 5
        }
    }
    
    //Checking combination scoring methods
    var hasHonours = false
    var numberOfWinds = 0
    var numberOfDragons = 0
    var combinationsRevealed = 0
    var concealedPungs = 0
    var numberOfPungs = 0
    var numberOfChows = 0
    var singleClass = true
    let firstTripletClassname = individualCombinations[0].tiles[0].className
    var dragonArray: [[Int]] = [[], [], []]
    var dragonRevealedArray: [Bool] = [false, false, false]
    for i in 0..<5 {
        //Checking what class
        if firstTripletClassname != individualCombinations[i].tiles[0].className {
            singleClass = false
        }
        //Checking if kong
        if individualCombinations[i].tiles.count == 4 {
            //Calculate stuff
            if revealedCombinations[i] {
                combinationsRevealed += 1
                totalPoints += 1
                appliedMethods["Melded Kong", default: 0] += 1
            }
            else {
                totalPoints += 2
                appliedMethods["Concealed Kong", default: 0] += 2
                concealedPungs += 1
            }
            if individualCombinations[i].tiles[0].specificClassName == "winds" {
                numberOfWinds += 1
            }
            else if individualCombinations[i].tiles[0].specificClassName == "dragons" {
                numberOfDragons += 1
            }
            continue
        }
        //Checking if pung of honours (Pung of Honours)
        else if individualCombinations[i].tiles[0].className == "honours" {
            numberOfPungs += 1
            if revealedCombinations[i] {
                combinationsRevealed += 1
            }
            else {
                concealedPungs += 1
            }
            if individualCombinations[i].tiles[0].specificClassName == "winds" {
                numberOfWinds += 1
            }
            else if individualCombinations[i].tiles[0].specificClassName == "dragons" {
                numberOfDragons += 1
            }
            hasHonours = true
            totalPoints += 1
            appliedMethods["Pung of Honours", default: 0] += 1
        }
        //Checking if pung and revealed
        else if individualCombinations[i].tiles[0].title == individualCombinations[i].tiles[1].title && !revealedCombinations[i] {
            concealedPungs += 1
            numberOfPungs += 1
        }
        //Checking if chow (sequence)
        else if individualCombinations[i].tiles[0].title != individualCombinations[i].tiles[1].title {
            numberOfChows += 1
            if revealedCombinations[i] {
                combinationsRevealed += 1
            }
            switch (individualCombinations[i].tiles[0].className) {
                case "bamboo":
                    if i == 0 || !dragonArray[0].contains(individualCombinations[i].tiles[0].value) {
                        dragonArray[0].append(individualCombinations[i].tiles[0].value)
                        if revealedCombinations[i] {
                            dragonRevealedArray[0] = true
                        }
                    }
                    break
                case "dot":
                    if i == 0 || !dragonArray[1].contains(individualCombinations[i].tiles[0].value) {
                        dragonArray[1].append(individualCombinations[i].tiles[0].value)
                        if revealedCombinations[i] {
                            dragonRevealedArray[1] = true
                        }
                    }
                    break
                case "character":
                    if i == 0 || !dragonArray[2].contains(individualCombinations[i].tiles[0].value) {
                        dragonArray[2].append(individualCombinations[i].tiles[0].value)
                        if revealedCombinations[i] {
                            dragonRevealedArray[2] = true
                        }
                    }
                    break
                default:
                    break
            }
        }
        else {
            numberOfPungs += 1
            if revealedCombinations[i] {
                combinationsRevealed += 1
            }
        }
    }
    
    //Checking if the pair is a honours tile
    if individualCombinations[5].tiles[0].className == "honours" {
        hasHonours = true
    }
    //No Honours
    if !hasHonours && numberOfFlowers == 0 {
        totalPoints += 3
        appliedMethods["No Honours or Flowers"] = 3
    }
    else {
        if !hasHonours { //No Honours
            totalPoints += 1
            appliedMethods["No Honours"] = 1
        }
        if numberOfFlowers == 0 { //No Flowers
            totalPoints += 1
            appliedMethods["No Flowers"] = 1
        }
    }
    //Checking if full or half flush
    if singleClass && hasHonours {
        totalPoints += 10
        appliedMethods["Half Flush"] = 10
    }
    else if singleClass {
        totalPoints += 40
        appliedMethods["Full Flush"] = 40
    }
    
    //Dragon and winds scoring
    switch (numberOfWinds) {
    case 2:
        //Little 3 winds
        if individualCombinations[5].tiles[0].specificClassName == "winds" {
            totalPoints += 5
            appliedMethods["Little Three Winds"] = 5
        }
        break
    case 3:
        if individualCombinations[5].tiles[0].specificClassName == "winds" {
            //Little 4 winds
            totalPoints += 30
            appliedMethods["Little Four Winds"] = 30
        }
        else {
            //Big 3 winds
            totalPoints += 10
            appliedMethods["Big Three Winds"] = 10
        }
        break
    case 4:
        //Big 4 winds
        totalPoints += 40
        appliedMethods["Big Four Winds"] = 40
        break
    default:
        break
    }
    switch (numberOfDragons) {
    case 2:
        //Little 3 dragons
        if individualCombinations[5].tiles[0].specificClassName == "dragons" {
            totalPoints += 10
            appliedMethods["Little Three Dragons"] = 10
        }
        break
    case 3:
        //Big three dragons
        totalPoints += 30
        appliedMethods["Big Three Dragons"] = 30
        break
    default:
        break
    }
    
    //Checking if concealed hand (Fully Conecealed Hand)
    if combinationsRevealed == 0 {
        totalPoints += 3
        appliedMethods["Fully Concealed Hand"] = 3
    }
    else if combinationsRevealed != 5 {
        totalPoints += 1
        appliedMethods["Concealed Hand"] = 1
    }
    //Checking Concealed Pungs
    switch concealedPungs {
        case 2: //Two concealed pungs
            totalPoints += 2
            appliedMethods["Two Concealed Pungs"] = 2
            break
        case 3: //Three concealed pungs
            totalPoints += 3
            appliedMethods["Three Concealed Pungs"] = 3
            break
        case 4: //Four concealed pungs
            totalPoints += 10
            appliedMethods["Four Concealed Pungs"] = 10
            break
        case 5:
            totalPoints += 40
            appliedMethods["Five Concealed Pungs"] = 40
        default:
            break
    }
    
    //Checking last combination stuff
    if lastTile == lastCombination[1] && !lastCombination.contains("back") { //Closed Wait
        totalPoints += 2
        appliedMethods["Closed Wait"] = 2
    }
    else { //Single Wait
        totalPoints += 2
        appliedMethods["Single Wait"] = 2
    }
    
    //All Chows
    if numberOfChows == 5 && numberOfFlowers != 0{
        totalPoints += 3
        appliedMethods["All Chows (with Flowers or Honours)"] = 3
    }
    else if numberOfChows == 5 && numberOfFlowers == 0 && !hasHonours {
        totalPoints += 10
        appliedMethods["All Chows (without Flowers or Honours)"] = 10
    }
    
    //All Revealed
    if combinationsRevealed == 5 {
        totalPoints += 10
        appliedMethods["All Revealed"] = 10
    }
    
    //Full Straight (Open)
    for i in 0..<dragonArray.count {
        var valuesToFind = [1: false,4: false,7: false]
        for j in 0..<dragonArray[i].count {
            switch dragonArray[i][j] {
            case 1:
                valuesToFind[1] = true
                break
            case 4:
                valuesToFind[4] = true
                break
            case 7:
                valuesToFind[7] = true
            default:
                break
            }
        }
        if valuesToFind[1]! && valuesToFind[4]! && valuesToFind[7]! && dragonRevealedArray[i] {
            totalPoints += 5
            appliedMethods["Full Straight (Open)"] = 5
            break
        }
        else if valuesToFind[1]! && valuesToFind[4]! && valuesToFind[7]! {
            totalPoints += 10
            appliedMethods["Full Straight (Closed)"] = 10
            break
        }
        
    }
    
    //All Pungs
    if numberOfPungs == 5 {
        totalPoints += 10
        appliedMethods["All Pungs"] = 10
    }
    
    return (totalPoints, appliedMethods)
}

//IndividualCombinations Structure
// - Combination 1
// - Combination 2
// - Combination 3
// - Combination 4
// - Combination 5
// - 麻將
// - 花

struct Breakdown_Previews: PreviewProvider {
    
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
        Breakdown(showingBreakdown: .constant(false), scoredValues: .constant(["test":1]), totalPoints: .constant(0), individualCombinations: .constant(individualCombinations))
    }
}
