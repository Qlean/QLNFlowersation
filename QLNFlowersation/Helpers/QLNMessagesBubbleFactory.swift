//
//  QLNMessagesBubbleFactory.swift
//  QLNFlowersation
//
//  Created by Andrey Konstantinov on 28/04/16.
//  Copyright © 2016 Qlean. All rights reserved.
//

import UIKit

final class QLNMessagesBubbleFactory {

  static let incomingBubbleImage = QLNMessagesBubbleFactory.backgroundBubbleImage(false)
  static var outgoingBubbleImage = QLNMessagesBubbleFactory.backgroundBubbleImage(true)

  /// Cell bubble image
  private class func backgroundBubbleImage(_ outgoing: Bool) -> UIImage {
    let bundle = Bundle.init(for: QLNMessagesBubbleFactory.self)
    var bubbleImage = UIImage.init(named: "Bubble", in: bundle, compatibleWith: nil)
    bubbleImage = UIImage.imageMaskedWithColor(bubbleImage!, color: bubbleColor(outgoing))

    if let bubbleImageOk = bubbleImage {
      bubbleImage = makeOpaqueImage(bubbleImageOk).resizableImage(withCapInsets: UIEdgeInsetsMake(QLNMessagesSettings.bubbleImageInset, QLNMessagesSettings.bubbleImageInset, QLNMessagesSettings.bubbleImageInset, QLNMessagesSettings.bubbleImageInset), resizingMode: .stretch)
    }

    return bubbleImage!
  }

  /// Cell bubble image color
  class func bubbleColor(_ outgoing: Bool) -> UIColor {
    return outgoing ? QLNMessagesSettings.outgoingBubbleColor : QLNMessagesSettings.incomingBubbleColor
  }

  /// Create opaque image from transparent one
  private class func makeOpaqueImage(_ image: UIImage) -> UIImage {
    let imageRect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
    UIGraphicsBeginImageContextWithOptions(imageRect.size, true, image.scale)
    let context = UIGraphicsGetCurrentContext()
    context!.setFillColor(QLNMessagesSettings.backgroundColor.cgColor)
    context!.fill(imageRect)
    context!.draw(image.cgImage!, in: imageRect)
    let imageToReturn = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()

    return imageToReturn!
  }
}
