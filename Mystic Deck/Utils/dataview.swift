import SwiftyJSON
import Foundation

func shuffleCards(for theme: String, topic: String) -> JSON? {
    guard let url = Bundle.main.url(forResource: "everydata", withExtension: "json") else {
        print("Error: JSON file not found.")
        return nil
    }
    
    do {
        let data = try Data(contentsOf: url)
        let json = try JSON(data: data)
        
        // Get the cards data for the specified theme and topic
        guard let cardsData = json[theme][topic]["Cards"].dictionaryObject else {
            print("Error: Unable to extract cards data.")
            return nil
        }
        guard let startColor = json[theme][topic]["Startcolor"].string else {
            print("Error: Unable to extract start color.")
            return nil
        }
        guard let endColor = json[theme][topic]["Endcolor"].string else {
            print("Error: Unable to extract end color.")
            return nil
        }
        
        // Shuffle the cards randomly while keeping the sequence of numbering intact
        var shuffledCards: [String: [String: Any]] = [:]
        let shuffledKeys = cardsData.keys.shuffled()

        // Select only 3 keys randomly
        let selectedKeys = shuffledKeys.prefix(2)

        var index = 1
        for key in selectedKeys {
            if let cardData = cardsData[key] as? [String: Any] {
                shuffledCards[String(index)] = cardData
                index += 1
            }
        }

        
        // Create a new JSON object containing the shuffled cards and colors
        var newJSON: [String: Any] = [:]
        
        // Initialize the nested dictionaries before accessing them
        if newJSON[theme] == nil {
            newJSON[theme] = [:]
        }
        
        if var themeDictionary = newJSON[theme] as? [String: Any] {
            if themeDictionary[topic] == nil {
                themeDictionary[topic] = [:]
            }
            
            if var topicDictionary = themeDictionary[topic] as? [String: Any] {
                // Now you can access and assign values to the nested dictionaries
                topicDictionary["Cards"] = shuffledCards
                topicDictionary["Startcolor"] = startColor
                topicDictionary["Endcolor"] = endColor
                
                // Assign the modified dictionary back to the original JSON
                themeDictionary[topic] = topicDictionary
                newJSON[theme] = themeDictionary
            } else {
                print("Error: Failed to initialize topic dictionary")
                return nil
            }
        } else {
            print("Error: Failed to initialize theme dictionary")
            return nil
        }
        print(newJSON)
        return JSON(newJSON)
    } catch {
        print("Error loading JSON file: \(error.localizedDescription)")
        return nil
    }
}



class JSONDataManager {
    static let shared = JSONDataManager()

    var jsonData: JSON?

    // Private init to prevent external initialization
    private init() {}
}
