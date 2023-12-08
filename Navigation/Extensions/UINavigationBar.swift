import UIKit

extension UINavigationBar {
    static func configure() {
        let appearance = UINavigationBar.appearance()
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont(name: "Gilroy-Bold", size: 20) ?? UIFont()
        ]
        appearance.tintColor = UIColor.accentPrimary
    }
}
