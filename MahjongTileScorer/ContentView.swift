//
//  ContentView.swift
//  MahjongTileScorer
//
//  Created by Declan Young on 2/11/2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State var showingBreakdown = false
    @State private var presentingInputView: Bool = false
    @State var individualCombinations: [Category] = [Category(), Category(), Category(), Category(), Category(), Category(), Category()]
    @State var scoredValues: [String:Int] = [:]
    @State var totalScoredValues: Int = 0
    //Input Tiles Variables for Breakdown
    @State var totalTiles = 0
    @State var discardsLessThanTen = false
    @State var numberOfDiscards = 0
    @State var isDealer = false
    @State var numberOfConsecutiveWins = 0
    @State var selfDrawnWin = false
    @State var lastTileInDeck = false
    @State var lastTile: String = "back"
    @State var lastCombination: [String] = ["back", "back", "back"]
    @State var revealedCombinations = [false, false, false, false, false]
    @State var showingAlert = false
    //Alert Variables
    @State var alertMessage = ""
    var body: some View {
        TabView {
            NavigationView {
            VStack {
                Image("MahjongIcon")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 256)
                    .padding()
                //Creating a navigation link to segue to the input view
                NavigationLink(
                    //The input view has the content view's variables as the parameters to ensure that they can be passed to the breakdown view as well
                    destination: InputTiles(presentingInputView: $presentingInputView, individualCombinations: $individualCombinations, totalTiles: $totalTiles, discardsLessThanTen: $discardsLessThanTen, numberOfDiscards: $numberOfDiscards, isDealer: $isDealer, numberOfConsecutiveWins: $numberOfConsecutiveWins, selfDrawnWin: $selfDrawnWin, lastTileInDeck: $lastTileInDeck, lastTile: $lastTile, lastCombination: $lastCombination, revealedCombinations: $revealedCombinations)
                        .toolbar {
                            Button("Done") {
                                print("Done")
                                //Checks if the tiles entered are greater than or equal to 17. If it is, it shows the breakdown, else it displays an error alert
                                if totalTiles >= 17 {
                                    //Scores the mahjong tile hand and saves the returned tuple value to the 2 variables
                                    (totalScoredValues, scoredValues) = scoreTiles(individualCombinations: individualCombinations, discardsLessThanTen: discardsLessThanTen, numberOfDiscards: numberOfDiscards, isDealer: isDealer, numberOfConsecutiveWins: numberOfConsecutiveWins, selfDrawnWin: selfDrawnWin, lastTileInDeck: lastTileInDeck, lastTile: lastTile, lastCombination: lastCombination, revealedCombinations: revealedCombinations)
                                    showingBreakdown.toggle()
                                }
                                else if  lastTile == "back" {
                                    alertMessage = "Please enter last tile and/or combination"
                                    showingAlert = true
                                }
                                else {
                                    alertMessage = "Please enter 17 or more tiles"
                                    showingAlert = true
                                }
                            }.sheet(isPresented: $showingBreakdown, onDismiss: {
                                //Checks if the done button on the breakdown view is pressed. If it is, it resets the variables and dismisses the input view
                                if PublicVariables.doneButtonClicked == true {
                                    presentingInputView = false
                                    //Reset Variables
                                    resetVariables()
                                }
                                    print("dimsised")
                            }) {
                                //Creates the instance of the breakdown view with specific variables
                                Breakdown(showingBreakdown: $showingBreakdown, scoredValues: $scoredValues, totalPoints: $totalScoredValues, individualCombinations: $individualCombinations)
                            }
                            .alert(isPresented: $showingAlert) {
                                //Creates the alert
                                Alert(title: Text("Error"), message: Text(LocalizedStringKey(alertMessage)), dismissButton: .default(Text("Dismiss")))
                            }
                        }
                        .onDisappear(perform: {
                            //Resets the variables when the input view is dismissed
                            resetVariables()
                        }),
                    isActive: $presentingInputView,
                    label: {
                        Text("Input...")
                            .frame(width: 200, height: 44, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .background(PublicVariables.purpleColour)
                            .foregroundColor(Color.white)
                            .cornerRadius(16)
                            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, 5)
                    }).navigationBarTitleDisplayMode (.inline)
            }.navigationBarTitle(Text("Home"))
            }.tabItem {
                //Creates the tab bar item
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            //Creates the dictionary view instance and tab icon
            Dictionary()
                .tabItem {
                    Image(systemName: "book.fill")
                    Text("Dictionary")
                }
            //Creates the settings view instance and tab icon
            Settings()
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("Settings")
                }
            //Changes the colour highlight to a purple
        }.accentColor(PublicVariables.purpleColour)
        .shadow(color: PublicVariables.purpleColour.opacity(0.3), radius: 10, x:0, y:10)
    }
    
    func resetVariables() {
        individualCombinations = [Category(), Category(), Category(), Category(), Category(), Category(), Category()]
        scoredValues = [:]
        totalScoredValues = 0
        discardsLessThanTen = false
        numberOfDiscards = 0
        isDealer = false
        numberOfConsecutiveWins = 0
        selfDrawnWin = false
        lastTileInDeck = false
        lastTile = "back"
        lastCombination = ["back", "back", "back"]
        revealedCombinations = [false, false, false, false, false]
        totalTiles = 0
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

