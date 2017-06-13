//
//  QLNMessagesSettings.swift
//  QLNFlowersation
//
//  Created by Andrey Konstantinov on 20/04/16.
//  Copyright © 2016 Qlean. All rights reserved.
//

import UIKit

public final class QLNMessagesSettings {

  public static var backgroundColor = UIColor(netHex: 0xEFEFEF)
  public static var statusBarBackgroundColor = UIColor.white
  public static var incomingBubbleColor = UIColor.white
  public static var outgoingBubbleColor = UIColor(netHex: 0xFFFFFF)
  public static var incomingBubbleTextColor = UIColor.black
  public static var outgoingBubbleTextColor = UIColor.black
  public static var bubbleImageInset: CGFloat = 18
  public static var cellAnimationOption: UIViewAnimationOptions = UIViewAnimationOptions()
  public static var chatMessageAnimationStepInterval: TimeInterval = 0.25
  public static var placeholderImage = UIImage(named: "ChatMessageImagePlaceholder", in: Bundle(for: QLNMessagesSettings.self), compatibleWith: nil)
  public static var normalTextFont = UIFont.systemFont(ofSize: 16)
  public static var reactionButtonNormalStateColor = UIColor.black
  public static var reactionButtonHighlightedStateColor = UIColor(netHex: 0x6C6C6C)

  static var typingImage = UIImage(named: "Typing", in: Bundle(for: QLNMessagesSettings.self), compatibleWith: nil)

}
