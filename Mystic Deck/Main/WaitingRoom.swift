import SwiftUI

struct HomeView: View {
    
    var body: some View {
        ZStack {
            // Background Image
            Image("themebk")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            LinearGradient(gradient: Gradient(colors: [Color(hue: 0.628, saturation: 0.553, brightness: 0.601), Color.clear]), startPoint: .top, endPoint: .center)
                .edgesIgnoringSafeArea(.top)
            
            VStack {
                
                Spacer()
//                Button(action: DataSocketManager.shared.establishSocketConnection, label: {
//                    Text("Button")
//                        .foregroundColor(.black)
//                        .background(Color.white)
//                        .padding()
//                })
                // Join and Create Room Buttons
                VStack(spacing: 30) {
                    NavigationLink(destination: LoadingView()) {
                        // Join Room Button
                        ButtonView(label: "Join Room")
                    }
                    
                    NavigationLink(destination: WaitingRoomView(comingfrom: "create_room")) {
                        // Create Room Button
                        ButtonView(label: "Create Room")
                    }
                }
                
                Spacer()
                
                
//                HStack(spacing: 20) {
//                    BoxView(content: "Points")
//                    BoxView(content: "Duration")
//                    BoxView(content: "Stats")
//                }
                
                Spacer()
                
                // Tabular View
                TableView()
                
                Spacer()
            }.scaledToFit()
        }
    }
}



struct ButtonView: View {
    var label: String
    
    var body: some View {
        Text(label)
            .foregroundColor(.white)
            .padding()
            .font(.system(size: 25))
            .frame(width: 300, height: 100)
            .background(LinearGradient(gradient: Gradient(colors: [Color(hue: 0.628, saturation: 0.553, brightness: 0.841), Color(red: 75/255, green: 0/255, blue: 130/255)]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(20)
    }
}

struct BoxView: View {
    var content: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .fill(Color.white)
            .frame(width: 100, height: 100)
            .overlay(
                Text(content)
                    .foregroundColor(.black)
                    .fontWeight(.bold)
            )
            .scaledToFit()
    }
}

struct TableView: View {
    let data = [
        ("John", 10, "b1"),   // Added profile image names
        ("Alice", 15, "b2"),
        ("Bob", 8, "b3")
    ]

    let cellHeight: CGFloat = 70

    var body: some View {
        VStack {
            HStack {
//                Text("#")
//                    .padding()
//                    .frame(maxWidth: .infinity / 8) // Adjust column width
//                    .background(Color.blue)
//                    .foregroundColor(.white)
//                    .border(Color.black)
//                    .cornerRadius(8) // Adjust the corner radius as needed

                Text("Profiles")
                    .padding()
                    .frame(maxWidth: .infinity / 2) // Adjust column width
                    .background(Color.black.opacity(0.6))
                    .foregroundColor(.white)
//                    .border(Color.black)
                    .cornerRadius(8) // Adjust the corner radius as needed

                Text("Wins")
                    .padding()
                    .frame(maxWidth: .infinity / 4) // Adjust column width
                    .background(Color.black.opacity(0.6))
                    .foregroundColor(.white)
//                    .border(Color.black)
                    .cornerRadius(8) // Adjust the corner radius as needed
            }

            ForEach(data.indices, id: \.self) { index in
                HStack {
                    Text("\(index + 1)") // Add a number in front of Profiles
                        .padding()
                        .frame(maxWidth: 40) // Adjust column width
//                        .border(Color.black)
                        .cornerRadius(8) // Adjust the corner radius as needed
                        .foregroundColor(.white)

                    Image(data[index].2) // Load image from assets
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50) // Set profile picture size
//                        .border(Color.black)
                        .cornerRadius(8) // Adjust the corner radius as needed
                        .foregroundColor(.white)

                    Text(data[index].0)
                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing:20))
                        .frame(maxWidth: .infinity / 2) // Adjust column width
//                        .border(Color.black)
                        .cornerRadius(8) // Adjust the corner radius as needed
                        .foregroundColor(.white)

                    Text("\(data[index].1)")
                        .padding()
                        .frame(maxWidth: .infinity / 4) // Adjust column width
//                        .border(Color.black)
                        .cornerRadius(8) // Adjust the corner radius as needed
                        .foregroundColor(.white)
                }
                .frame(height: cellHeight) // Set the height of each cell
            }
        }
        .padding()
    }
}



struct WaitingRoomView: View {
    @State private var imageSize: CGFloat = 1.0 // default scale factor
    @State private var generatedcode:String="xxxxxx"
    @State var comingfrom:String
    @State private var privateShouldNavigateToLoadingGameRoom: Bool = false
    @State private var showShareWindow = false
    @ViewBuilder
    var destinationView: some View {
        if privateShouldNavigateToLoadingGameRoom {
            LoadingGameRoomView(theme: AppData.shared.themeselected, imageName: AppData.shared.topicselected)
        } else {
            EmptyView()
        }
    }
    var body: some View {
        NavigationView {
            ZStack {
                // Background Image
                Image("themebk")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                    VStack {
                        // Title
                        Text("Waiting Room")
                            .font(.system(size: 26, weight: .bold, design: .rounded))
                            .fontWeight(.bold)
                            .foregroundColor(Color(hue: 0.728, saturation: 0.953, brightness: 0.741))
                            .multilineTextAlignment(.center)
                            .lineLimit(nil)
                            .padding(.top, 20)
                        Spacer()
                       
                        
                        // Buttons at the middle of each edge
                        VStack {
                            HStack {
                                Spacer()
                                Button(action: {
                                    // Action for b1
                                }) {
                                    VStack {
                                        Image("b1")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 150 * imageSize, height: 150 * imageSize)
                                        Text("Waiting for Players To Join...")
                                            .foregroundColor(.black)
                                        
                                    }
                                }
                                Spacer()
                            }
                            
//                            HStack {
//                                Button(action: {
//                                    // Action for b2
//                                }) {
//                                    VStack {
//                                        Image("b2")
//                                            .resizable()
//                                            .scaledToFit()
//                                            .frame(width: 150 * imageSize, height: 150 * imageSize)
//                                        Text("User2")
//                                            .foregroundColor(.black)
//                                    }
//                                }
//                                //Spacer()
//                               // Spacer()
//                               // Spacer()
//                                Button(action: {
//                                    // Action for b3
//                                }) {
//                                    VStack {
//                                        Image("b3")
//                                            .resizable()
//                                            .scaledToFit()
//                                            .frame(width: 150 * imageSize, height: 150 * imageSize)
//                                        Text("User3")
//                                            .foregroundColor(.black)
//                                    }
//                                }
//                            }
                            
//                            HStack {
//                                Spacer()
//                                Button(action: {
//                                    // Action for b4
//                                }) {
//                                    VStack {
//                                        Image("b4")
//                                            .resizable()
//                                            .scaledToFit()
//                                            .frame(width: 150 * imageSize, height: 150 * imageSize)
//                                        Text("User4")
//                                            .foregroundColor(.black)
//                                    }
//                                }
//                                Spacer()
//                            }
                        }
                        Spacer()
                        
                        // Share Button and Rectangle
                        VStack {
                            if(comingfrom == "create_room"){
                                HStack {
                                    Spacer()
                                    Button(action: {
                                        // Implement share action
                                        // Present share sheet
                                        // Toggle share window
                                                                    withAnimation {
                                                                        showShareWindow.toggle()
                                                                    }
                                    }) {
                                        Image(systemName: "square.and.arrow.up")
                                            .resizable()
                                            .foregroundColor(.white)
                                            .frame(width: 30 * imageSize, height: 35 * imageSize)
                                    }
                                    Spacer(minLength: 0)
                                    
                                    Rectangle()
                                        .fill(Color.white)
                                        .frame(width: 100 * imageSize, height: 40 * imageSize)
                                        .cornerRadius(5)
                                        .overlay(
                                            Text(generatedcode)
                                                .foregroundColor(.black)
                                        )
                                    Spacer(minLength: 20)
                                    
                                    NavigationLink(destination: ThemeView()) {
                                        Image(systemName: "arrow.right")
                                            .resizable()
                                            .foregroundColor(.white)
                                            .frame(width: 30 * imageSize, height: 30 * imageSize)
                                            .padding(.leading, 10)
                                    }
                                    Spacer()
                                }
                            }
                            // Sliding share window
                                            if showShareWindow {
                                                VStack {
                                                    Spacer()
                                                    HStack {
                                                        Spacer()
                                                        VStack(alignment: .leading, spacing: 20) {
                                                            ShareOptionButton(iconName: "doc.on.doc", text: "Copy text")
                                                            ShareOptionButton(iconName: "square.and.arrow.up", text: "Share code")
                                                            ShareOptionButton(iconName: "message", text: "Forward via WhatsApp")
                                                            ShareOptionButton(iconName: "envelope", text: "Forward by mail")
                                                        }
                                                        Spacer()
                                                    }
                                                    Spacer()
                                                }
                                                .frame(maxWidth: 1000, maxHeight: 2000)
                                                .background(Color.white)
                                                .transition(.move(edge: .bottom))
                                                .edgesIgnoringSafeArea(.all)
                                                .onTapGesture {
                                                    // Dismiss share window when tapped outside
                                                    withAnimation {
                                                        showShareWindow.toggle()
                                                    }
                                                }
                                            }
                            
                            NavigationLink(
                                           destination: destinationView,
                                           isActive: $privateShouldNavigateToLoadingGameRoom,
                                           label: { EmptyView() }
                                       )
                            
                        }.onReceive(DataSocketManager.shared.$shouldNavigateToLoadingGameRoom) { shouldNavigate in
                            if shouldNavigate {
                                privateShouldNavigateToLoadingGameRoom = true
                            }
                        }
                    }
            } .navigationBarBackButtonHidden(true)
        } .navigationBarBackButtonHidden(true)
          .onAppear {
              print("waiting room")
              print(AppData.shared.roomID)
              DataSocketManager.shared.establishSocketConnection()
              if(comingfrom=="create_room"){
                  generatedcode = generateUniqueCode()
                  // Call the callAPI function inside the closure
                  callAPI(endpoint: "/create_room", method: "POST", formData: ["creator_id": "123", "room_id": generatedcode]) { responseString in
                      if let responseString = responseString, let data = responseString.data(using: .utf8) {
                          do {
                              if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                                 let session = json["session"] as? [String: Any],
                                 let roomID = session["room_id"] as? String {
                                  AppData.shared.roomID = roomID
                                  AppData.shared.roomID = generatedcode
                                  AppData.shared.mychance = 1
                                  print("Response: \(responseString)")
                              } else {
                                  print("Error: Unable to parse JSON or extract room ID")
                              }
                          } catch {
                              print("Error: \(error)")
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

struct ShareOptionButton: View {
    var iconName: String
    var text: String
    
    var body: some View {
        Button(action: {
            // Action for share option button
        }) {
            HStack(spacing: 10) {
                Image(systemName: iconName)
                    .foregroundColor(.blue)
                Text(text)
                    .foregroundColor(.blue)
            }
        }
    }
}

struct NewPageView: View {
    var body: some View {
        ZStack {
            Image("themebk")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
