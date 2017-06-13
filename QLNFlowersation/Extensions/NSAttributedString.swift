//
//  NSAttributedString extensions
//  QLNFlowersation
//
//  Created by Andrey Konstantinov on 09/06/2017.
//  Copyright © 2017 Qlean. All rights reserved.
//

import UIKit

extension NSAttributedString {

  class func attributed(from text: String, font: UIFont, color: UIColor) -> NSAttributedString {
    let attributes = [
      NSFontAttributeName: font,
      NSForegroundColorAttributeName: color
    ]
    let attributedString = NSAttributedString(string: text, attributes: attributes)
    return attributedString
  }
  
}
