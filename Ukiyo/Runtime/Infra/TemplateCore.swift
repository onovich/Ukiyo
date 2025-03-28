import Foundation
import SwiftUI

class TemplateCore {
    static let shared = TemplateCore()
    private init() {}
    
    private var allColor: [ColorModel] = []
    
    func loadAll(){
        loadAllColor()
    }
    
    struct ColorResponse: Codable {
        let colors: [ColorModel]
    }
    
    func loadAllColor() {
        allColor.removeAll()
            let jsonFiles = ["black", "blue", "red", "green"] // 你的文件名列表
            
            for fileName in jsonFiles {
                guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
                    print("⚠️ 文件不存在: \(fileName).json")
                    continue
                }
                
                do {
                    let data = try Data(contentsOf: url)
                    let response = try JSONDecoder().decode(ColorResponse.self, from: data)
                    allColor.append(contentsOf: response.colors)
                    print("✅ 成功加载 \(fileName).json (\(response.colors.count) 条数据)")
                } catch {
                    print("❌ 解析 \(fileName).json 失败: \(error.localizedDescription)")
                }
            }
            print("🎉 总共加载 \(allColor.count) 条数据")
    }

    
    // 随机获取一条数据
    func getRandomColor() -> ColorModel? {
        return  allColor.randomElement()
    }
    
    // 获取所有数据（如果需要）
    func getAllColor() -> [ColorModel] {
        return allColor
    }
}
