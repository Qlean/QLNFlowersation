//
//  UIColor extensions
//  QLNFlowersation
//
//  Created by Andrey Konstantinov on 09/06/2017.
//  Copyright © 2017 Qlean. All rights reserved.
//

import UIKit

extension UIColor {

  convenience init(red: Int, green: Int, blue: Int) {
    assert(red >= 0 && red <= 255, "Invalid red component")
    assert(green >= 0 && green <= 255, "Invalid green component")
    assert(blue >= 0 && blue <= 255, "Invalid blue component")

    self.init(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: 1)
  }

  convenience init(netHex: Int) {
    self.init(red: (netHex >> 16) & 0xff, green: (netHex >> 8) & 0xff, blue: netHex & 0xff)
  }

}
