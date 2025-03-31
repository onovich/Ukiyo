import SwiftUI
import Swiftween

struct ViewMain: View {
    @State private var colorName: String = "RED"
    @State private var colorHex: String = "#FFFFFF"
    @State private var bgColor: Color = Color.purple
    @State private var progress: Float = 0.0
    @State private var startColor: UIColor = UIColor(Color.purple) // 初始颜色
    @State private var targetColor: Color = Color.purple // 目标颜色
    let animationDuration: Double = 1.0
    
    var body: some View {
        ZStack {
            bgColor
                .ignoresSafeArea()
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
        .onReceive(Timer.publish(every: 1.0 / 60.0, on: .main, in: .common).autoconnect()) { _ in
            updateAnimation()
        }
    }

    private func changeColor() {
        let template = TemplateCore.shared
        if let color = template.getRandomColor() {
            colorName = color.kanji
            colorHex = color.hex
            
            startColor = UIColor(bgColor)
            targetColor = Color(hex: color.hex)
            progress = 0.0
        }
    }

    private func updateAnimation() {
        guard progress < 1.0 else { return }
        
        progress += Float(1.0 / (60.0 * animationDuration))
        progress = min(progress, 1.0)
        
        // 这里使用正确的 easingCGColor 方法
        let easedColor = EasingHelper.easingCGColor(
            start: startColor.cgColor,
            end: UIColor(targetColor).cgColor,
            current: progress,
            duration: 1.0,  // 这里填 1.0，因为 `progress` 已经是 0~1
            type: .sine,     // 使用 Sine 缓动（你可以换成别的）
            mode: .easeIn      // 默认模式
        )
        
        bgColor = Color(easedColor)
    }
}

#Preview {
    ViewMain()
}
