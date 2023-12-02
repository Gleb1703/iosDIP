//
//  PostModel.swift
//  Navigation
//
//  Created by Created by gleb on 05/10/2023.
//

import UIKit

struct PostModel {
    
    var author: String
    var description: String
    var image: UIImage
    var likes: Int
    var views: Int
    
}

extension PostModel {
    
    static func own() -> [PostModel] {
        [
            PostModel(
                author: "Apple Inc.",
                description: "The iPhone (retrospectively referred to unofficially as the iPhone 2G, iPhone 1 or original iPhone) is the first iPhone model and the first smartphone designed and marketed by Apple Inc. After years of rumors and speculation, it was officially announced on January 9, 2007, and it was released in the United States on June 29, 2007.",
                image: UIImage(named: "iphone2g") ?? UIImage(),
                likes: 12,
                views: 44
            ),
            PostModel(
                author: "Apple Inc.",
                description: "The iPhone 3G (also known as iPhone 2) is a smartphone designed and marketed by Apple Inc.; it is the second generation of iPhone, successor to the original iPhone, and was introduced on June 9, 2008, at the WWDC 2008 at the Moscone Center in San Francisco, United States.",
                image: UIImage(named: "iphone3") ?? UIImage(),
                likes: 18,
                views: 128
            ),
            PostModel(
                author: "Apple Inc.",
                description: "The iPhone 4 is a smartphone that was designed and marketed by Apple Inc. It is the fourth generation of the iPhone lineup, succeeding the iPhone 3GS and preceding the 4S. Following a number of notable leaks, the iPhone 4 was first unveiled on June 7, 2010, at Apple's Worldwide Developers Conference in San Francisco, and was released on June 24, 2010, in the United States, United Kingdom, France, Germany, and Japan. The iPhone 4 introduced a new hardware design to the iPhone family, which Apple's CEO Steve Jobs touted as the thinnest smartphone in the world at the time; it consisted of a stainless steel frame which doubled as an antenna, with internal components situated between two panels of aluminosilicate glass.",
                image: UIImage(named: "iphone4") ?? UIImage(),
                likes: 33,
                views: 216
            ),
            PostModel(
                author: "Apple Inc.",
                description: "Steve Jobs introduced the MacBook Air during Apple's keynote address at the 2008 Macworld conference on January 15, 2008. The first generation MacBook Air was a 13.3 model, initially promoted as the world's thinnest notebook at 1.9 cm.",
                image: UIImage(named: "macbookair") ?? UIImage(),
                likes: 99,
                views: 514
                     )
        ]
    }
    
    static func all() -> [PostModel] {
        var posts: [PostModel] = [
            PostModel(
                author: "Nick",
                description: "In the forest deep and green, Where sunlight rarely has been seen, Leaves whisper tales of old,Under canopies of emerald gold. Roots entwine like lovers' hands,In this silent, sacred land, Each tree a sentinel of time, In this tranquil, verdant clime.",
                image: UIImage(named: "04") ?? UIImage(),
                likes: 125,
                views: 5345
            ),
            PostModel(
                author: "Nick",
                description: "Peaks that kiss the azure sky, Where eagles dare and spirits fly, Cloaked in snow, so pure, so bright, Bathed in the moon's soft silver light. Granite giants, ancient, wise, Standing tall where the falcon flies, In their shadows, secrets dwell, In each crevice, each rocky dell.",
                image: UIImage(named: "03") ?? UIImage(),
                likes: 3525,
                views: 52123
            ),
            PostModel(
                author: "William",
                description: "Endless blue, horizon wide, Where dreams sail and seagulls glide, Waves whisper to the sandy shore, In a rhythm of ancient lore. The ocean's heart, deep and vast, In each tide, echoes of the past, Its depths a mystery untold, Beneath the surface, wonders bold.",
                image: UIImage(named: "10") ?? UIImage(),
                likes: 233,
                views: 1234
            )
        ]
        posts.append(contentsOf: PostModel.own())
        return posts
    }
}
