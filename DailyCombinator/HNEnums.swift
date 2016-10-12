//
//  HNEnums
//  DailyCombinator
//
//  Created by Ben Murphy on 10/11/16.
//  Copyright © 2016 Constellation Software. All rights reserved.
//

import Foundation
import Firebase

enum HNStoryCollectionType: String {
    case top    = "topstories"
    case new    = "newstories"
    case best   = "beststories"
    case job    = "jobstories"
    case ask    = "askstories"
}

enum HNItemType {
    case job, story, comment, poll, pollopt
}
