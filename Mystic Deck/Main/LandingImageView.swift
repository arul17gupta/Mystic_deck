//
//  LandingImageView.swift
//  Mystic Deck
//
//  Created by user1 on 16/12/23.
//

import SwiftUI
import SwiftyJSON
struct LandingImageView: View {
    @State private var mysticOffset: CGFloat = -200
    @State private var deckOffset: CGFloat = 400
    @State private var opacity: Double = 0.0
    @State private var buttonopacity: Double = 0.0
    @State private var showLoginButtons: Bool = false
    @State private var showNewText: Bool = true
    @State private var showLandingView: Bool = false
    
    var body: some View {
        NavigationLink(
                destination: LandingPage(),
                isActive: $showLandingView
            ) {
                EmptyView()  // This is the label view for NavigationLink
            }
        ZStack {
            Image("mainbg")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            
//            Text("MYSTIC")
//                .fontWeight(.bold)
//                .font(.system(size: 60))
//                .offset(y: -220)
//                .foregroundColor(.white)
//                .opacity(opacity)
//                .onAppear {
//                    withAnimation(
//                        Animation.easeInOut(duration: 1.0)
//                            .delay(4.0)
//                    ) {
//                        self.opacity = 1.0
//                    }
//                }
//            
//            
//            Text("DECK")
//                .fontWeight(.bold)
//                .font(.system(size: 60))
//                .offset(y: -160)
//                .foregroundColor(.white)
//                .opacity(opacity)
//                .onAppear {
//                    withAnimation(
//                        Animation.easeInOut(duration: 1.0)
//                            .delay(4.0)
//                    ) {
//                        self.opacity = 1.0
//                    }
//                }
            
//            VStack {
//                
//                Button(action: {
//                    // Handle button action
//                }) {
//                    Rectangle()
//                        .foregroundColor(.white)
//                        .overlay(
//                            Text("Login with Google")
//                                .fontWeight(.bold)
//                                .foregroundColor(.black)
//                                .padding()
//                        )
//                        .frame(width: 200, height: 50)
//                        .cornerRadius(10)
//                }
//                
//                
//                Text("OR")
//                    .fontWeight(.bold)
//                    .font(.system(size: 30))
//                    .foregroundColor(.white)
//                
//                
//                Button(action: {
//                    // Handle button action
//                }) {
//                    Rectangle()
//                        .foregroundColor(.white)
//                        .overlay(
//                            Text("Login with Apple")
//                                .fontWeight(.bold)
//                                .foregroundColor(.black)
//                                .padding()
//                        )
//                        .frame(width: 200, height: 50)
//                        .cornerRadius(10)
//                }
//            }
//            .offset(y: 60)
//            .opacity(buttonopacity)
//            .onAppear {
//                withAnimation(
//                    Animation.easeInOut(duration: 1.0)
//                        .delay(6.0)
//                ) {
//                    self.buttonopacity = 1.0
//                }
//            }
            
            
            Text("MYSTIC")
                .fontWeight(.bold)
                .font(.system(size: 60))
                .foregroundColor(.white)
                .offset(x: mysticOffset)
                .opacity(mysticOffset == 0 ? 1 : 0)
                .onAppear {
                    withAnimation(.easeInOut(duration: 2.5) .delay(0.5)) {
                        mysticOffset = 0
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                        withAnimation(.easeInOut(duration: 1.0).delay(0.4)) {
                            mysticOffset = 0
                            showLandingView = true
                        }
                    }
                }
            
            
            Text("DECK")
                .fontWeight(.bold)
                .font(.system(size: 60))
                .padding(.top, 133.569)
                .foregroundColor(.white)
                .offset(x: deckOffset)
                .opacity(deckOffset == 0 ? 1 : 0)
                .onAppear {
                    withAnimation(.easeInOut(duration: 2.5) .delay(0.5)) {
                        deckOffset = 0
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                        withAnimation(.easeInOut(duration: 1.0).delay(0.4)) {
                            deckOffset = 0
                            showLandingView = true
                        }
                    }
                    
                }
        }
    }
}

#Preview {
    LandingImageView()
}

