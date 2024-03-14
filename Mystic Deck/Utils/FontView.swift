import SwiftUI

struct FontListView: View {
    let fontNames: [String]

    init() {
        // Get all available font names
        self.fontNames = UIFont.familyNames
            .flatMap { UIFont.fontNames(forFamilyName: $0) }
            .sorted()
    }

    var body: some View {
        List(fontNames, id: \.self) { fontName in
            Text(fontName)
                .font(.custom(fontName, size: 20))
        }
        .navigationBarTitle("Custom Fonts", displayMode: .inline)
    }
}

struct FontListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FontListView()
        }
    }
}
