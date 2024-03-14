import SwiftUI
import SwiftyJSON

struct GameRoomView: View {
    @State private var mysticOffset: CGFloat = -200
    @State private var deckOffset: CGFloat = 400
    @State private var opacity: Double = 0.0
    @State private var buttonopacity: Double = 0.0
    @State private var showLoginButtons: Bool = false
    @State private var showNewText: Bool = true
    @State private var isNavigationActive: Bool = false
    @State private var isSettingsPopupVisible = false
    @State private var showPlayButton = false
    @State private var refreshID = UUID()
    @State private var showWinSheet = false
    @State private var showLoseSheet = false
    @State private var isHomeActive = false
    @State private var isEndActive = false
    
    let theme: String
    let topic: String
    
    @ViewBuilder
    var destinationToHomeView: some View {
        if isEndActive {
            NavigationBarView()
        } else {
            EmptyView()
        }
    }
    
    var body: some View {
        
        ZStack {
            Image("gameroombg")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
                .frame(width: 400)
            
            
            VStack{
                
                HStack{
                    OppositePlayerProfileView(imageName: "player", name: "Arul", totalCards: 4)
                    OppositePlayerProfileView(imageName: "player", name: "Abhishek", totalCards: 4)
                }
                .padding(.bottom, 40.0)
                
                
                HStack{
                    Text("\(AppData.shared.username)")
                    Spacer()
                  
                    ZStack{
                        Circle()
                            .fill(Color.green)
                            .frame(width: 40)
                        Text("\(AppData.shared.score)")
                            .foregroundColor(.white)
                    }
                    
                }
                .font(.system(size: 26))
                .bold()
                .padding(.bottom, 20.0)
                
                if let unwrappedJsonData = JSONDataManager.shared.jsonData {
                    if(unwrappedJsonData[AppData.shared.themeselected][AppData.shared.topicselected]["Cards"].isEmpty){
                        NavigationLink(
                            destination: destinationToHomeView,
                            isActive: $isEndActive,
                            label: {
                                EmptyView()
                            }
                        )
                    }else{
                        VStack{
                            CardStack(jsonData: unwrappedJsonData, theme: theme, topic: topic)
                                .offset(x: 20)
                                .id(refreshID)
                        }
                    }
                }
                
                Spacer().frame(height: 30)
                
                HStack{
                    Spacer()
                    if(showPlayButton == true || AppData.shared.mychance == 1){
                        CustomButton(buttonText: "PLAY") {
                            print("Play Button clicked!")
                            DataSocketManager.shared.play_call()
                        }
                    }
                    Spacer()
                    Image("settings")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .onTapGesture {
                            // Show the settings popup
                            isSettingsPopupVisible.toggle()
                        }
                }
                
            }.frame(width: 370, height: 840).padding(.top,50.0)
            
            // Background for the popup
            if isSettingsPopupVisible {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        isSettingsPopupVisible = false
                    }
            }
            
            // Popup content
            if isSettingsPopupVisible {
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            isSettingsPopupVisible = false
                        }) {
                            Image("cross")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 40, height: 40)
                        }
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding()
                    }
                    
                    NavigationLink(
                        destination: destinationToHomeView,
                        isActive: $isHomeActive,
                        label: {
                            EmptyView()
                        }
                    )
                    
                    
                    CustomButton(buttonText: "EXIT") {
                        print("Exit")
                        DataSocketManager.shared.leave_room()
                        isHomeActive = true
                        print(isHomeActive)
                    }
                    
                    Spacer()
                }
                .background(Color.white)
                .cornerRadius(20)
                .padding()
                .frame(height: 200)
            }
        }
        .padding()
        .navigationBarBackButtonHidden(true)
        .sheet(isPresented: $showWinSheet, onDismiss: {
            // Loop through the jsonData to find and remove matching key-value pairs
            if var jsonData = JSONDataManager.shared.jsonData {
                print(jsonData[AppData.shared.themeselected][AppData.shared.topicselected]["Cards"])
                if var cards = jsonData[AppData.shared.themeselected][AppData.shared.topicselected]["Cards"].dictionaryObject as? [String: [String: String]] {
                    var keysToRemove: [String] = []
                    
                    for (key, values) in cards {
                        // Check if the key-value pair matches the condition
                        if let parameterValue = values[AppData.shared.parameter_name], parameterValue == AppData.shared.parameter_value {
                            // Add the key to the list of keys to remove
                            keysToRemove.append(key)
                        }
                    }
                    
                    // Remove the key-value pairs from the "Cards" dictionary
                    for key in keysToRemove {
                        cards.removeValue(forKey: key)
                    }
                    
                    // Convert the modified Swift dictionary back to a JSON object
                    if let updatedCards = cards as? [String: Any] {
                        jsonData[AppData.shared.themeselected][AppData.shared.topicselected]["Cards"] = JSON(updatedCards)
                        if(jsonData[AppData.shared.themeselected][AppData.shared.topicselected]["Cards"].isEmpty){
                            JSONDataManager.shared.jsonData = jsonData
                            print("Exit because cards over")
                            DataSocketManager.shared.leave_room()
                            isEndActive = true
                        }else{
                            JSONDataManager.shared.jsonData = jsonData
                            refreshID = UUID()
                        }
                    }
                    print(jsonData[AppData.shared.themeselected][AppData.shared.topicselected]["Cards"])
                }
                
            } else {
                print("JSON data is nil")
            }
            
            showWinSheet = false
        }) {
            Text("You win!")
                .font(.title)
                .foregroundColor(.black)
                .padding()
        }
        .sheet(isPresented: $showLoseSheet, onDismiss: {
            // Loop through the jsonData to find and remove matching key-value pairs
            if var jsonData = JSONDataManager.shared.jsonData {
                print(jsonData[AppData.shared.themeselected][AppData.shared.topicselected]["Cards"])
                if var cards = jsonData[AppData.shared.themeselected][AppData.shared.topicselected]["Cards"].dictionaryObject as? [String: [String: String]] {
                    var keysToRemove: [String] = []
                    
                    for (key, values) in cards {
                        // Check if the key-value pair matches the condition
                        if let parameterValue = values[AppData.shared.parameter_name], parameterValue == AppData.shared.parameter_value {
                            // Add the key to the list of keys to remove
                            keysToRemove.append(key)
                        }
                    }
                    
                    // Remove the key-value pairs from the "Cards" dictionary
                    for key in keysToRemove {
                        cards.removeValue(forKey: key)
                    }
                    
                    // Convert the modified Swift dictionary back to a JSON object
                    if let updatedCards = cards as? [String: Any] {
                        jsonData[AppData.shared.themeselected][AppData.shared.topicselected]["Cards"] = JSON(updatedCards)
                        if(jsonData[AppData.shared.themeselected][AppData.shared.topicselected]["Cards"].isEmpty){
                            JSONDataManager.shared.jsonData = jsonData
                            print("Exit because cards over")
                            DataSocketManager.shared.leave_room()
                            isEndActive = true
                        }else{
                            JSONDataManager.shared.jsonData = jsonData
                            refreshID = UUID()
                        }
                    }
                    print(jsonData[AppData.shared.themeselected][AppData.shared.topicselected]["Cards"])
                }
                
            } else {
                print("JSON data is nil")
            }
            
            showLoseSheet = false
        }) {
            Text("You Loose!")
                .font(.title)
                .foregroundColor(.black)
                .padding()
        }
        .id(refreshID)
        .onReceive(DataSocketManager.shared.$startScoreUpdate) { newValue in
            if newValue {
                if !DataSocketManager.shared.otherPlayerSendValues {
                    callAPI(endpoint: "/score_update", method: "POST", formData: ["room_id": AppData.shared.roomID]) { responseString in
                        DispatchQueue.main.async {
                            if let responseString = responseString,
                               let data = responseString.data(using: .utf8),
                               let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                               let scores = json["scores"] as? [String: Int],
                               let winner = json["winner"] as? String {
                                
                                if let score = scores[AppData.shared.username] {
                                    AppData.shared.score = score
                                }
                                
                                // Handle the response
                                print("Response:\(responseString)")
                                DataSocketManager.shared.startScoreUpdate = false
                                print(refreshID)
                                if AppData.shared.username == winner {
                                    AppData.shared.mychance = 1
                                    showWinSheet = true
                                    showPlayButton = true
                                } else {
                                    AppData.shared.mychance = 0
                                    showLoseSheet = true
                                    showPlayButton = false
                                }
                            } else {
                                // Handle the error
                                print("Failed to fetch data")
                            }
                        }
                    }
                }
            }
        }
        
    }
}

//struct GameRoomView_Previews: PreviewProvider {
//    static var previews: some View {
//        GameRoomView()
//    }
//}
