//
//  OppositePlayerProfile.swift
//  Mystic Deck
//
//  Created by user1 on 30/12/23.
//

import Foundation

import SwiftUI

struct OppositePlayerProfileView: View {
    var imageName: String
    var name: String
    var totalCards: Int
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 5)

            VStack {
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .frame(width: 70, height: 80)
                    .padding(.top, 3.0)

                Text(name)
                    .foregroundColor(.black)
                    .font(.system(size: 26))
                    .bold()

                Text("\(totalCards)")
                    .font(.system(size: 20))
                    .foregroundColor(.black)
                    .padding(.bottom, 3.0)
                    .bold()
            }
        }
        .padding()
        .frame(width: 160, height: 100)
    }
}

struct CardRectangleView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeView()
    }
}

