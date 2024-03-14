//
//  Buttons.swift
//  Mystic Deck
//
//  Created by user1 on 24/12/23.
//

import SwiftUI


struct CustomButton: View {
    var buttonText: String
    var onClick: () -> Void
    
    var body: some View {
        Button(action: {
            onClick()
        }) {
            Text(buttonText)
                .frame(width: 130, height: 35)
                .padding(.horizontal, 30.0)
                .padding(.vertical, 10.0)
                .bold()
                .foregroundColor(.white)
                .background(LinearGradient(gradient: Gradient(colors: [Color(hex: "#2F61DF"), Color(hex: "#AA1ADC")]), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(28)
                .font(.system(size: 28))
        }
    }
}

//#Preview {
//    GameRoomView()
//}
