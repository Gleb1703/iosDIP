//
//  FeedViewModel.swift
//  Navigation
//
//  Created by Created by gleb on 05/10/2023.
//

import Foundation
import UIKit

class FeedViewModel: UIViewController {
    var stories = StoriesModel.stories
    var posts = PostModel.all()
}
