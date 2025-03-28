import SwiftUI

@main
struct AppMain: App {
    private let template = TemplateCore.shared
    init() {
        template.loadAll()
    }
    
    var body: some Scene {
        WindowGroup {
            ViewMain()
        }
    }
}
