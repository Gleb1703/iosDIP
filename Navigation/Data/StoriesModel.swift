import UIKit

struct StoriesModel {
    let author: String
    let image: UIImage

    static let stories: [StoriesModel] = [
        StoriesModel(author: "Sam", image: UIImage(named: "01")!),
        StoriesModel(author: "Alex", image: UIImage(named: "02")!),
        StoriesModel(author: "Jeremy", image: UIImage(named: "03")!),
        StoriesModel(author: "Nick", image: UIImage(named: "04")!),
        StoriesModel(author: "Sarah", image: UIImage(named: "05")!),
        StoriesModel(author: "Lilah", image: UIImage(named: "06")!),
        StoriesModel(author: "William", image: UIImage(named: "07")!),
    ]
}
