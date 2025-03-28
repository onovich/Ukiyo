import SwiftUI

struct ViewMain: View {
    @State private var colorName: String = "RED"
    @State private var colorHex: String = "#FFFFFF"
    @State private var bgColor: Color = Color.purple
    let animationDuration: Double = 0.2
    
    var body: some View {
        ZStack {
            bgColor
                .ignoresSafeArea()
                .animation(.linear(duration: animationDuration), value: bgColor)
            ZStack {
                VStack{
                    Text("日本の伝統色")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top, 0)
                    
                    Text("日本传统色")  // サブタイトル
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.8))
                        .padding(.top, 4)
                    Spacer()
                }
                
                VStack{
                    Text("\(colorName)")
                        .font(.system(size: 60))
                        .fontWeight(.light)
                        .padding()
                        .foregroundColor(.white)
                    
                    Text("\(colorHex)")
                        .font(.system(size: 30))
                        .fontWeight(.light)
                        .padding()
                        .foregroundColor(.white)
                }
            }
        }
        .contentShape(Rectangle()) // 确保整个区域可点击
        .onTapGesture { // 添加点击手势
            changeColor()
        }
    }
    
    private func changeColor(){
        let template = TemplateCore.shared
        if let color = template.getRandomColor() {
            colorName = color.kanji
            colorHex = color.hex
            bgColor = Color(hex: colorHex)
        }
    }
}

#Preview {
    ViewMain()
}
