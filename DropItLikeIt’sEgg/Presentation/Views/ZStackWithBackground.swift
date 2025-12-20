import SwiftUI

struct ZStackWithBackground<Content: View>: View {
    private enum Background {
        case image(Image)
        case color(Color)
    }
    
    private let background: Background
    @ViewBuilder let content: () -> Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.background = .image(Image(.backgroundMain))
        self.content = content
    }
    
    init(_ asset: ImageResource, @ViewBuilder content: @escaping () -> Content) {
        self.background = .image(Image(asset))
        self.content = content
    }
    
    init(color: Color, @ViewBuilder content: @escaping () -> Content) {
        self.background = .color(color)
        self.content = content
    }
    
    var body: some View {
        ZStack {
            switch background {
            case .image(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
            case .color(let color):
                color
                    .ignoresSafeArea()
            }
            content()
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    VStack {
        ZStackWithBackground {
            Text("Hello Default")
                .foregroundColor(.white)
        }
        
        ZStackWithBackground(.backgroundGame) {
            Text("Hello Image")
                .foregroundColor(.white)
        }
        
        ZStackWithBackground(color: .black.opacity(0.8)) {
            Text("Hello Color")
                .foregroundColor(.white)
        }
    }
    .padding()
}
