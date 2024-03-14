import SwiftUI

enum Theme: String, Identifiable, CaseIterable {
    case history = "History"
    case geography = "Geography"
    case science = "Science"
    case ecosystem = "Ecosystem"
    
    var id: String { self.rawValue }
}

struct ThemeView: View {
    @State private var selectedTheme: String = Theme.history.rawValue
    @State private var isNavigationActive = false
    
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                ZStack {
                    Color.clear
                        .background(
                            Image("themebk")
                                .scaledToFill()
                                .edgesIgnoringSafeArea(.all)
                                .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                        )
                    
                    VStack(spacing: 30) {
                        Text("Explore Themes")
                            .font(.system(size: 26, weight: .bold, design: .rounded))
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color(hue: 0.728, saturation: 0.953, brightness: 0.741))
                            .multilineTextAlignment(.center)
                            .lineLimit(0)
                            .padding(.top, 0)
                        
                        themeButtons
                        
                        ScrollView {
                            if selectedTheme != "" {
                                generateImages(for: selectedTheme)
                            }
                        }
                        .padding(.bottom, -34.5)
                    }
                }
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
        } .navigationBarBackButtonHidden(true)
    }
    
    private var themeButtons: some View {
        HStack(spacing: 6) {
            ForEach(Theme.allCases) { theme in
                Button(action: {
                    selectedTheme = theme.rawValue
                }) {
                    Text(theme.rawValue)
                        .padding(.horizontal, 9)
                        .padding(.vertical, 7)
                        .background(
                            selectedTheme == theme.rawValue ?
                            LinearGradient(gradient: Gradient(colors: [Color(hue: 0.628, saturation: 0.553, brightness: 0.841), Color(red: 75/255, green: 0/255, blue: 130/255)]), startPoint: .leading, endPoint: .trailing) :
                                LinearGradient(gradient: Gradient(colors: [Color(red: 75/255, green: 0/255, blue: 130/255).opacity(0.3), Color(red: 75/255, green: 0/255, blue: 130/255).opacity(0.2)]), startPoint: .leading, endPoint: .trailing)
                        )
                        .foregroundColor(selectedTheme == theme.rawValue ? .white : Color(hue: 0.728, saturation: 0.953, brightness: 0.741))
                        .cornerRadius(20)
                }
                .padding(.bottom, 8)
            }
        }
    }
    
//    private func generateImages(for theme: String) -> some View {
//        let imageNames: [String]
//        switch theme {
//        case "History":
//            imageNames = ["H1", "H2", "H3", "H4"]
//        case "Geography":
//            imageNames = ["states and cities", "G2", "G3", "G4"]
//        case "Science":
//            imageNames = ["S1", "S2", "S3", "S4"]
//        case "Ecosystem":
//            imageNames = ["E1", "E2", "E3", "E4"]
//        default:
//            print("default theme")
//        }
//        
//        return VStack(spacing: 20) {
//            ForEach(imageNames, id: \.self) { imageName in
////                NavigationLink(
////                    destination: LoadingGameRoomView(theme: AppData.shared.themeselected!, imageName: AppData.shared.topicselected),
////                    isActive: Binding<Bool>(
////                        get: { DataSocketManager.shared.shouldNavigateToLoadingGameRoom },
////                        set: { DataSocketManager.shared.shouldNavigateToLoadingGameRoom = $0 }
////                    ),
////                    label: {
////                        EmptyView()
////                    }
////                )
////                .hidden()
//                
//                Button(
//                    action: {},
//                    label: {
//                        Image(imageName)
//                            .resizable()
//                            .aspectRatio(contentMode: .fill)
//                            .frame(width: 350, height: 240)
//                            .onTapGesture {
//                                AppData.shared.themeselected = selectedTheme
//                                AppData.shared.topicselected = imageName
//                                print(type(of: AppData.shared.themeselected))
//                                print(AppData.shared.topicselected)
//                                DataSocketManager.shared.theme_selection()
//                                print(type(of: AppData.shared.themeselected))
////                                LoadingGameRoomView(theme: AppData.shared.themeselected!, imageName: AppData.shared.topicselected)
//                            }
//                    })
//                Spacer()
//            }
//        }
//    }
    
    @ViewBuilder
    var destinationView: some View {
        if isNavigationActive {
            LoadingGameRoomView(theme: AppData.shared.themeselected, imageName: AppData.shared.topicselected)
        } else {
            EmptyView()
        }
    }
    
    private func generateImages(for theme: String) -> some View {
        var imageNames: [String] = []

        switch theme {
        case "History":
            imageNames = ["H1", "H2", "H3", "H4"]
        case "Geography":
            imageNames = ["states and cities", "G2", "G3", "G4"]
        case "Science":
            imageNames = ["S1", "S2", "S3", "S4"]
        case "Ecosystem":
            imageNames = ["E1", "E2", "E3", "E4"]
        default:
            print("default theme")
        }

        return VStack(spacing: 20) {
            ForEach(imageNames, id: \.self) { imageName in
                
                NavigationLink(
                    destination: destinationView,
                    isActive: $isNavigationActive,
                    label: {
                        EmptyView()
                    }
                )
           

                Button(
                    action: {
                        // Handle both navigation and button actions here
                        AppData.shared.themeselected = selectedTheme
                        AppData.shared.topicselected = imageName
                        DataSocketManager.shared.theme_selection() // Trigger navigation
                        isNavigationActive = DataSocketManager.shared.shouldNavigateToLoadingGameRoom
                        print(isNavigationActive)
                        print(AppData.shared.themeselected)
                    },
                    label: {
                        Image(imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 350, height: 240)
                    })
                Spacer()
            }

        }
    }

    
    
}

struct ThemeView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeView()
    }
}
