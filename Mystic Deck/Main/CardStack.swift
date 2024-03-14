import Foundation
import SwiftyJSON
import SwiftUI

struct CardStack: View {
    var jsonData: JSON
    let theme: String
    let topic: String
    
    var body: some View {
        
        let cardData = jsonData[theme][topic]["Cards"]
        let numberOfCards = cardData.dictionary?.count ?? 0

        if numberOfCards > 0 {
            ZStack(alignment: .top){
                ForEach(1...numberOfCards, id: \.self) { cardNumber in

                    if let cardData = jsonData[theme][topic]["Cards"]["\(cardNumber)"].dictionary,
                       let name = cardData["name"]?.string,
                       let image = cardData["image"]?.string,
                       let area = cardData["AREA"]?.string,
                       let population = cardData["POPULATION"]?.string,
                       let mpi = cardData["MPI"]?.string,
                       let pollution = cardData["POLLUTION"]?.string,
                       let literacyRate = cardData["LITERACY RATE"]?.string,
                       let gdp = cardData["GDP"]?.string,
                       let startColor = jsonData["Geography"]["states and cities"]["Startcolor"].string,
                       let endColor = jsonData["Geography"]["states and cities"]["Endcolor"].string{
                        
                        GameCard(
                            imageName: image,
                            cardHeading: name,
                            rectangles: [
                                ("AREA", area, startColor, endColor),
                                ("POPULATION", population, startColor, endColor),
                                ("MPI", mpi, startColor, endColor),
                                ("POLLUTION", pollution, startColor, endColor),
                                ("LITERACY RATE", literacyRate, startColor, endColor),
                                ("GDP", gdp, startColor, endColor),
                            ]
                        )
                        .offset(x: -CGFloat(min(cardNumber * cardNumber, 30)))
                    }
                }
            }
        } else {
            Text("No data to show")
                .frame(height: 200)
        }
    }
}


//let jsonData: JSON? = shuffleCards(for: AppData.shared.themeselected, topic: AppData.shared.topicselected)

struct CardStackView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeView()
    }
}
