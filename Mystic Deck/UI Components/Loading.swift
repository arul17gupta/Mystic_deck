import SwiftUI


struct BlinkingText: View {
    let text: String
    @Binding var isBlinking: Bool

    init(_ text: String, isBlinking: Binding<Bool>) {
        self.text = text
        self._isBlinking = isBlinking
    }

    var body: some View {
        Text(text)
            .fontWeight(.ultraLight)
            .padding(.vertical , 5.0)
            .italic()
            .font(Font.custom("Hoefler Text", size: 30))
            .foregroundColor(.black)
            .opacity(isBlinking ? 0.0 : 1.0)
    }
}

struct Loading: View {

    @State private var opacity: Double = 0.0
    var ThemeHeading: String
    @State private var isBlinking = false
    
    var body: some View {
        ZStack {
            Image("gameroombg")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            VStack {
                       BlinkingText("Loading the themes", isBlinking: $isBlinking)
                       BlinkingText("of", isBlinking: $isBlinking)
                       BlinkingText("States and Cities", isBlinking: $isBlinking)
                   }
                   .onAppear {
                       withAnimation(Animation.easeInOut(duration: 1.0).repeatForever()) {
                           self.isBlinking.toggle()
                       }
                   }
        }
    }
}

struct Loadings: PreviewProvider {
    static var previews: some View {
        Loading(ThemeHeading: "Hello")
    }
}
