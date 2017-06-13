//
//  QLNMessageReactionButton.swift
//  QLNFlowersation
//
//  Created by Andrey Konstantinov on 07/04/16.
//  Copyright © 2016 Qlean. All rights reserved.
//

import UIKit

final class QLNMessageReactionButton: UIButton {

  var bottomConstraint: NSLayoutConstraint?

  private(set) var reaction: ((QLNMessage?) -> ())?
  private(set) var reactionObject: QLNMessageReaction?
  private(set) var currentMessage: QLNMessage?
  private(set) var nextMessage: QLNMessage?

  private var currentInputSymbols = ""

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
  }

  convenience init(currentMessage: QLNMessage?, nextMessage: QLNMessage?, reactionObject: QLNMessageReaction?) {
    self.init(frame: CGRect.zero)
    self.currentMessage = currentMessage
    self.nextMessage = nextMessage
    self.reactionObject = reactionObject
    self.reaction = reactionObject?.reaction

    contentEdgeInsets = UIEdgeInsetsMake(14, 20, 14, 20)
    setTitle(currentMessage?.text, for: .normal)
    setTitleColor(UIColor.white, for: .normal)
    titleLabel?.font = QLNMessagesSettings.normalTextFont
  }

}
