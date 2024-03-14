import SwiftUI

struct LoadingView: View {
    @State private var code: String = ""
    @State private var navigateToWaitingRoom: Bool = false

    var body: some View {
        NavigationView {
            GeometryReader { geo in
                ZStack {
                    // 1) Background Image
                    Image("themebk")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                        .frame(width: geo.size.width, height: geo.size.height)

                    // 2) Join Room Text
                    VStack {
                        Text("Join Room")
                            .font(.system(size: 26, weight: .bold, design: .rounded))
                            .fontWeight(.bold)
                            .foregroundColor(Color(hue: 0.728, saturation: 0.953, brightness: 0.741))
                            .multilineTextAlignment(.center)
                            .lineLimit(0)
                            .padding(.top, -310)

                        // 3) Text Field for "Enter the code"
                        TextField("Enter the code", text: $code)
                            .padding()
                            .foregroundColor(.black)
                            .background(
                                LinearGradient(gradient: Gradient(colors: [Color(red: 75/255, green: 0/255, blue: 130/255).opacity(0.3), Color(red: 75/255, green: 0/255, blue: 130/255).opacity(0.2)]), startPoint: .leading, endPoint: .trailing)
                            )
                            .cornerRadius(10)
                            .frame(width: 300, height: 40)
                            .cornerRadius(10)

//                        // 4) Join Button
//                        Button(action: {
//                            // Handle the join action here if needed
//                            navigateToWaitingRoom = true
//                        }) {
//                            Text("Join")
//                                .fontWeight(.semibold)
//                                .foregroundColor(.white)
//                                .padding()
//                                .frame(width: 100.0)
//                                .background(
//                                    LinearGradient(gradient: Gradient(colors: [Color(hue: 0.628, saturation: 0.553, brightness: 0.841), Color(red: 75/255, green: 0/255, blue: 130/255)]), startPoint: .leading, endPoint: .trailing)
//                                )
//                                .cornerRadius(10)
//                        }
                        
                        NavigationLink(
                            destination: WaitingRoomView(comingfrom: "join_room"),
                            isActive: $navigateToWaitingRoom,
                            label: {
                                Text("Join")
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 24.0)
                                    .padding(.vertical, 14.0)
                                    .background(
                                        LinearGradient(gradient: Gradient(colors: [Color(hue: 0.628, saturation: 0.553, brightness: 0.841), Color(red: 75/255, green: 0/255, blue: 130/255)]), startPoint: .leading, endPoint: .trailing)
                                    )
                                    .cornerRadius(10)
                                    .onTapGesture {
                            
            //                            // Handle the join action here if needed
                                        if (code != "") {
                                            AppData.shared.roomID = "\(code)"
                                            print(AppData.shared.roomID)
                                            navigateToWaitingRoom = true
                                        }
                                    }
                            }
                        )
                    }
                }
            }
        }.navigationBarBackButtonHidden(true)
    }
}


struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
