
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if let url = DatabaseHelper.shared.getDatabaseURL() {
            print("Database URL", url)
        }
        
        return true
    }


}

