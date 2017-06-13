//
//  QLNMessageViewModel.swift
//  QLNFlowersation
//
//  Created by Andrey Konstantinov on 11/06/2017.
//  Copyright © 2017 Qlean. All rights reserved.
//

import UIKit

final class QLNMessageViewModel {

  let text: NSAttributedString
  let backgroundColor: UIColor
  let bubbleImage: UIImage
  let isOutgoing: Bool
  let image: QLNMessageImage?
  let typingCell: Bool
  var animated: Bool
  let foreverTyping: Bool

  init(text: NSAttributedString, backgroundColor: UIColor, bubbleImage: UIImage, isOutgoing: Bool, image: QLNMessageImage?, typingCell: Bool, animated: Bool, foreverTyping: Bool) {
    self.text = text
    self.backgroundColor = backgroundColor
    self.bubbleImage = bubbleImage
    self.isOutgoing = isOutgoing
    self.image = image
    self.typingCell = typingCell
    self.animated = animated
    self.foreverTyping = foreverTyping
  }

}
