import SwiftUI

struct LoadingGameRoomView: View {
    @State private var showLoading: Bool = true
    @State private var isActive: Bool = false
    let theme: String
    let imageName: String
    
    var body: some View {
        ZStack {
            Image("gameroombg")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
                .opacity(showLoading ? 1 : 0)
            
            if showLoading {
                Text("Loading \(imageName)")
                    .foregroundColor(.black)
                    .italic()
                    .font(Font.custom("Hoefler Text", size: 30))
                    .shadow(color: .black, radius: 5, x: 0, y: 0)
                    .onAppear {
                        if(imageName != ""){
                            if let  newJSONData = shuffleCards(for: AppData.shared.themeselected, topic: AppData.shared.topicselected){
                                JSONDataManager.shared.jsonData = newJSONData
                                print(JSONDataManager.shared.jsonData)
                            } else {
                                print("Error: Failed to retrieve new JSON data")
                            }
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                            withAnimation {
                                showLoading = false
                                if(imageName != ""){
                                    isActive = true
                                    print("have made true in loading game room")
                                }
                            }
                        }
                    }
                //                NavigationLink(destination: GameRoomView(theme: theme, topic: imageName), isActive: $isActive, label: { Text("Join")
                //                        .foregroundColor(.white)
                //                        .padding(.horizontal, 24.0)
                //                        .padding(.vertical, 14.0)
                //                        .background(
                //                            LinearGradient(gradient: Gradient(colors: [Color(hue: 0.628, saturation: 0.553, brightness: 0.841), Color(red: 75/255, green: 0/255, blue: 130/255)]), startPoint: .leading, endPoint: .trailing)
                //                        )
                //                        .cornerRadius(10)
                //                })
                
            }
        }
        .background(
            NavigationLink("", destination: GameRoomView(theme: theme, topic: imageName), isActive: $isActive)
        )
        .navigationBarBackButtonHidden(true)
    }
}

//struct LoadingGameRoomView_Previews: PreviewProvider {
// static var previews: some View {
//  LoadingGameRoomView()
//  }
//}
