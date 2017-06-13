//
//  UIImage extensions
//  QLNFlowersation
//
//  Created by Andrey Konstantinov on 09/06/2017.
//  Copyright © 2017 Qlean. All rights reserved.
//

import UIKit

extension UIImage {

  class func fromColor(_ color: UIColor) -> UIImage {
    return fromColor(color, width: 1, height: 1)
  }

  class func fromColor(_ color: UIColor, width: CGFloat, height: CGFloat, opaque: Bool = true) -> UIImage {
    let rect = CGRect(x: 0, y: 0, width: width, height: height)
    UIGraphicsBeginImageContextWithOptions(rect.size, opaque, UIScreen.main.scale)
    let context = UIGraphicsGetCurrentContext()
    context!.setFillColor(color.cgColor)
    context!.fill(rect)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image!
  }

  class func imageMaskedWithColor(_ originalImage: UIImage, color: UIColor, newWidth: CGFloat? = nil, newHeight: CGFloat? = nil) -> UIImage {
    var newImageWidth = originalImage.size.width
    var newImageHeight = originalImage.size.height

    if let newWidthOk = newWidth {
      newImageWidth = newWidthOk
    }

    if let newHeighthOk = newHeight {
      newImageHeight = newHeighthOk
    }

    let imageRect = CGRect(x: 0, y: 0, width: newImageWidth, height: newImageHeight)

    UIGraphicsBeginImageContextWithOptions(imageRect.size, false, originalImage.scale)
    let context = UIGraphicsGetCurrentContext()
    context!.scaleBy(x: 1, y: -1)
    context!.translateBy(x: 0, y: -imageRect.size.height)
    context!.clip(to: imageRect, mask: originalImage.cgImage!)
    context!.setFillColor(color.cgColor)
    context!.fill(imageRect)

    let imageToReturn = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()

    return imageToReturn!
  }

}
