//
//  NavigationTab.swift
//  Mystic Deck
//
//  Created by user1 on 10/01/24.
//

import Foundation

import SwiftUI

struct NavigationBarView: View {
    @State private var selectedTab: Int = 0
    
    var body: some View {
        NavigationView {
            
            VStack {
                switch selectedTab {
                case 0:
                    HomeView()
                case 1:
                    AchievementsView()
                case 2:
                    GuideView()
                case 3:
                    SettingsView()
                default:
                    EmptyView()
                }
                
                Spacer()
                
                HStack {
                    TabBarButton(imageName: "house.fill", title: "Home", tabIndex: 0, selectedTab: $selectedTab)
                        .dynamicTypeSize(.xxLarge)
                    Spacer()
                    TabBarButton(imageName: "rosette", title: "Achievements", tabIndex: 1, selectedTab: $selectedTab)
                        .dynamicTypeSize(.xxLarge)
                    Spacer()
                    TabBarButton(imageName: "book.fill", title: "Guide", tabIndex: 2, selectedTab: $selectedTab)
                        .dynamicTypeSize(.xxxLarge)
                    Spacer()
                    TabBarButton(imageName: "gearshape.fill", title: "Settings", tabIndex: 3, selectedTab: $selectedTab)
                        .dynamicTypeSize(.xxxLarge)
                }
                .padding(.horizontal,40)
                .padding(.top,10)
                .padding(.bottom,-16)
                .background(Color.white.opacity(0.6))
             
            }
            .background(
                ZStack {
                    Image("themebk")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                    
//                    LinearGradient(gradient: Gradient(colors: [Color(hue: 0.328, saturation: 0.513, brightness: 0.201), Color.clear]), startPoint: .top, endPoint: .bottom).opacity(0.7)
//                        .edgesIgnoringSafeArea(.all)
                }
            )

            .navigationBarItems(leading: Heading(), trailing: ProfileButton())

        }
        .navigationBarBackButtonHidden(true)
    }
}



struct TabBarButton: View {
    let imageName: String
    let title: String
    let tabIndex: Int
    @Binding var selectedTab: Int
    
    func onClick() {
           print("Button clicked! Additional actions can be performed here.")
        selectedTab = tabIndex
       }
    
    var body: some View {
//        Button(
//            Image(systemName: imageName)
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .frame(width: 28, height: 28)
//        .padding(.bottom, -30.0)
//            
//        .foregroundColor(selectedTab == tabIndex ? .blue : .gray)) {onClick()
//        }
//        Button(action: onClick) {
//            Image(systemName: imageName)
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .frame(width: 28, height: 28)
//        .padding(.bottom, -30.0)
//            
//        }
        VStack{
            Button("", systemImage: imageName, action: onClick)    .labelStyle(.iconOnly)
                .foregroundColor(selectedTab == tabIndex ? .blue : .gray)
            
            Text("\(title)")
                .font(Font.custom("Hoefler Text", size: 13))
                .padding(.top,1.0)
                .foregroundColor(selectedTab == tabIndex ? .blue : .gray)
        }

//    label: {VStack {
//        Image(systemName: imageName)
//            .resizable()
//            .aspectRatio(contentMode: .fit)
//            .frame(width: 28, height: 28)
//    }
//    .padding(.bottom, -30.0)
//        
//    .foregroundColor(selectedTab == tabIndex ? .blue : .gray)
//    }
//        .onAppear {
//                    // You can print selectedTab here
//                    print(selectedTab)
//                    print(tabIndex)
//                }
    }
}

struct AchievementsView: View {
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                List {
                    AchievementRow(title: "Beginner", description: "")

                    AchievementRow(title: "Collector", description: "Collect 10 different badges")

                    AchievementRow(title: "Master", description: "Unlock all the badges")
                    // Add more achievement rows as needed
                }
                .scrollContentBackground(.hidden) // Hide the standard background of the List

            }
            .background(
                Image("themebk")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
            )

            .navigationBarTitle("Achievements")
        }
    }
    
    struct AchievementRow: View {
        var title: String
        var description: String
        
        var body: some View {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                    .padding()
                    .background(Color.white.opacity(0.8)) // Background color for title
                    .cornerRadius(10) // Rounded corners for the title background
                Image("win")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100,height: 100)
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding()
                    .background(Color.white.opacity(0.8)) // Background color for description
                    .cornerRadius(10) // Rounded corners for the description background
            }
        }
    }
}


struct GuideView: View {
    let points = [
                "1. User login to the app.",
                "2. If the user is the leader, they create a room and share the code with friends.",
                "3. Friends click on 'Join Room' and enter the unique code in the text field.",
                "4. The leader selects a theme for the game; only the leader can select the theme.",
                "5. The game starts, and Player 1 selects a parameter on their card that they think is best.",
                "6. Player 1 clicks 'Play', and other players select the same type of parameter.",
                "7. All card parameters are compared, and the highest one wins the round."
    ]
    
    @State private var currentIndex = 0
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 45) {
                    ForEach(points.indices, id: \.self) { index in
                        Text(points[index])
                            .font(.headline)
                            .padding()
                            .frame(width: geometry.size.width - 40) // Adjust width
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                            .opacity(currentIndex == index ? 1.0 : 0.5)
                    }
                }
                .frame(width: geometry.size.width * CGFloat(points.count), height: 650) // Adjust height
                .padding()
                .offset(x: -CGFloat(currentIndex) * geometry.size.width - 17)
                .animation(.easeInOut(duration: 1.0))
            }
            .onAppear {
                Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { timer in
                    withAnimation {
                        currentIndex = (currentIndex + 1) % points.count
                    }
                }
            }
        }
        Spacer()
        .navigationBarTitle("Guide:")
    }
}

struct SettingsView: View {
    @State private var isSoundEnabled = true
    @State private var isNotificationEnabled = true
    @State private var isHintsEnabled = true
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            Toggle("Sound", isOn: $isSoundEnabled)
                .font(.title) // Increase text size
                .toggleStyle(SwitchToggleStyle(tint: .secondary))
            
            Spacer()
            Toggle("Notification", isOn: $isNotificationEnabled)
                .font(.title) // Increase text size
                .toggleStyle(SwitchToggleStyle(tint: .secondary))
            Spacer()
            Toggle("Hints", isOn: $isHintsEnabled)
                .font(.title) // Increase text size
                .toggleStyle(SwitchToggleStyle(tint: .secondary))
            Spacer()
            Button(action: {
                // Action for Connect with Social Media
            }) {
                Text("Connect with Social Media to Send Gifts to Friends")
                    .font(.headline) // Increase button text size
                    .foregroundColor(.white)
            }
            .padding(.horizontal, 24.0)
            .padding(.vertical, 14.0)
            .frame(maxWidth: .infinity)
            .background(LinearGradient(gradient: Gradient(colors: [Color(hue: 0.628, saturation: 0.553, brightness: 0.841), Color(red: 75/255, green: 0/255, blue: 130/255)]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(10)
            
            Button(action: {
                // Action for Contact Us
            }) {
                Text("Contact Us")
                    .font(.headline) // Increase button text size
                    .foregroundColor(.white)
            }
            .padding(.horizontal, 24.0)
            .padding(.vertical, 14.0)
            .frame(maxWidth: .infinity)
            .background(LinearGradient(gradient: Gradient(colors: [Color(hue: 0.628, saturation: 0.553, brightness: 0.841), Color(red: 75/255, green: 0/255, blue: 130/255)]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(10)
//            Spacer()
            
            Button(action: {
                // Action for Restore
            }) {
                Text("Restore")
                    .font(.headline) // Increase button text size
                    .foregroundColor(.white)
            }
            .padding(.horizontal, 24.0)
            .padding(.vertical, 14.0)
            .frame(maxWidth: .infinity)
            .background(LinearGradient(gradient: Gradient(colors: [Color(hue: 0.628, saturation: 0.553, brightness: 0.841), Color(red: 75/255, green: 0/255, blue: 130/255)]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(10)
            
//            Spacer()
        }
        .padding()
        .navigationBarTitle("Settings")
    }
}

struct MenuButton: View {
    var body: some View {
        Button(action: {
            // Handle menu action
        }) {
            Image(systemName: "list.dash")
                .imageScale(.large)
                .foregroundColor(Color(hue: 0.728, saturation: 0.953, brightness: 0.741))
                .padding()
        }
    }
}

struct Heading: View {
    var body: some View {
        HStack(spacing: 0) {
            Text("Mystic")
                .font(Font.custom("Hoefler Text", size: 40))
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .foregroundColor(.white)
                .padding(.leading)

            Text("Deck")
                .font(Font.custom("Hoefler Text", size: 27))
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .foregroundColor(.white)
                .offset(x:4, y: 12)
        }
    }
}

struct ProfileButton: View {
    var body: some View {
        Button(action: {
            // Handle profile action
        }) {
            Image("832")
                .resizable()
                .frame(width: 60, height: 60.0)
                .clipShape(Circle())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBarView()
    }
}

extension Color {
    static let themebk = Color(red: 0.2, green: 0.4, blue: 0.6)
}
