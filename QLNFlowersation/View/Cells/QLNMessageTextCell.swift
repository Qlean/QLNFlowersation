//
//  QLNMessageCollectionViewCell.swift
//  QLNFlowersation
//
//  Created by Andrey Konstantinov on 05/04/16.
//  Copyright © 2016 Qlean. All rights reserved.
//

import UIKit

final class QLNMessageTextCell: UITableViewCell {

  private var outgoing = false

  @IBOutlet private var bubbleView: UIView!
  @IBOutlet private var bubbleImageView: UIImageView!

  @IBOutlet private var messageLabel: UILabel!

  // 'Final' constraints
  @IBOutlet private var messageLeftStrictPaddingConstraint: NSLayoutConstraint!
  @IBOutlet private var messageRightStrictPaddingConstraint: NSLayoutConstraint!

  @IBOutlet private var messageLeftMaybePaddingConstraint: NSLayoutConstraint!
  @IBOutlet private var messageRightMaybePaddingConstraint: NSLayoutConstraint!

  // Top
  @IBOutlet private var bubbleTopLittlePaddingConstraint: NSLayoutConstraint!
  @IBOutlet private var bubbleTopBigPaddingConstraint: NSLayoutConstraint!

  // Bottom
  @IBOutlet private var bubbleBottomLittlePaddingConstraint: NSLayoutConstraint!
  @IBOutlet private var bubbleBottomBigPaddingConstraint: NSLayoutConstraint!

  // 'Behind screen' constraints
  @IBOutlet private var incomingBackgroundConstraint: NSLayoutConstraint!
  @IBOutlet private var outgoingBackgroundConstraint: NSLayoutConstraint!

  // Typing views
  @IBOutlet private var typingContainer: UIView!
  @IBOutlet private var typingContainerBackgroundImageView: UIImageView! {
    didSet {
      typingContainerBackgroundImageView.image = QLNMessagesBubbleFactory.incomingBubbleImage
    }
  }
  @IBOutlet private var typingImageView: UIImageView! {
    didSet {
      typingImageView.image = QLNMessagesSettings.typingImage
    }
  }

  // Typing constraints
  @IBOutlet private var leadingTypingConstraint: NSLayoutConstraint!
  @IBOutlet private var trailingTypingConstraint: NSLayoutConstraint!

  override func awakeFromNib() {
    super.awakeFromNib()
    cellToInitialState()
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    cellToInitialState()
  }

  func prepareCell(message: QLNMessageViewModel) {
    self.outgoing = message.isOutgoing

    messageLabel.backgroundColor = message.backgroundColor

    bubbleImageView.image = message.bubbleImage

    bubbleTopLittlePaddingConstraint.priority = !outgoing ? UILayoutPriorityDefaultHigh : UILayoutPriorityDefaultLow
    bubbleBottomLittlePaddingConstraint.priority = !outgoing ? UILayoutPriorityDefaultHigh : UILayoutPriorityDefaultLow

    bubbleTopBigPaddingConstraint.priority = outgoing ? UILayoutPriorityDefaultHigh : UILayoutPriorityDefaultLow
    bubbleBottomBigPaddingConstraint.priority = outgoing ? UILayoutPriorityDefaultHigh : UILayoutPriorityDefaultLow

    constraintsToNormalState(outgoing)

    messageLabel.attributedText = message.text
    messageLabel.sizeToFit()

    layoutIfNeeded()

    if !outgoing && message.animated {
      typingNewState(true, delay: 0, foreverTyping: message.foreverTyping)
    } else {
      showMessage(message.animated)
    }
  }

  func cancelTyping() {
    typingNewState(false, delay: 0, foreverTyping: true)
  }

  // MARK : - Private

  /// Fow show / hide typing block
  private func typingNewState(_ show: Bool, delay: TimeInterval, foreverTyping: Bool) {
    layoutIfNeeded()
    leadingTypingConstraint.priority = show ? UILayoutPriorityDefaultHigh : UILayoutPriorityDefaultLow
    trailingTypingConstraint.priority = !show ? UILayoutPriorityDefaultHigh : UILayoutPriorityDefaultLow

    UIView.animate(
      withDuration: QLNMessagesSettings.chatMessageAnimationStepInterval,
      delay: delay,
      options: QLNMessagesSettings.cellAnimationOption,
      animations: { self.layoutIfNeeded() },
      completion: {
        completed in
        // skip all other animations
        if foreverTyping {
          self.layer.removeAllAnimations()
          return
        }
        if show {
          self.typingNewState(false, delay: 0.5, foreverTyping: false)
        } else {
          self.showMessage(completed)
        }
      }
    )
  }

  /// Fow show / hide message block
  private func showMessage(_ animated: Bool) {
    // To pre-animated state
    if animated {
      messageRightStrictPaddingConstraint.priority = UILayoutPriorityDefaultLow
      messageLeftMaybePaddingConstraint.priority = UILayoutPriorityDefaultLow

      messageLeftStrictPaddingConstraint.priority = UILayoutPriorityDefaultLow
      messageRightMaybePaddingConstraint.priority = UILayoutPriorityDefaultLow

      // background
      incomingBackgroundConstraint.priority = UILayoutPriorityDefaultLow
      outgoingBackgroundConstraint.priority = UILayoutPriorityDefaultLow

      if self.outgoing {
        outgoingBackgroundConstraint.priority = UILayoutPriorityDefaultHigh
      } else {
        incomingBackgroundConstraint.priority = UILayoutPriorityDefaultHigh
      }
    }

    layoutIfNeeded()

    bubbleView.layer.opacity = 1

    constraintsToNormalState(outgoing)

    let timeForAnimation: TimeInterval = animated ? QLNMessagesSettings.chatMessageAnimationStepInterval : 0

    UIView.animate(
      withDuration: timeForAnimation,
      delay: 0,
      options: QLNMessagesSettings.cellAnimationOption,
      animations: { self.layoutIfNeeded() },
      completion: nil
    )
  }

  // To normal state
  private func constraintsToNormalState(_ outgoing: Bool) {
    messageRightStrictPaddingConstraint.priority = outgoing ? UILayoutPriorityDefaultHigh : UILayoutPriorityDefaultLow
    messageLeftMaybePaddingConstraint.priority = outgoing ? UILayoutPriorityDefaultHigh : UILayoutPriorityDefaultLow

    messageLeftStrictPaddingConstraint.priority = !outgoing ? UILayoutPriorityDefaultHigh : UILayoutPriorityDefaultLow
    messageRightMaybePaddingConstraint.priority = !outgoing ? UILayoutPriorityDefaultHigh : UILayoutPriorityDefaultLow

    outgoingBackgroundConstraint.priority = UILayoutPriorityDefaultLow
    incomingBackgroundConstraint.priority = UILayoutPriorityDefaultLow
  }

  private func cellToInitialState() {
    bubbleView.layer.opacity = 0
    messageLabel.attributedText = NSAttributedString(string: " ")
    leadingTypingConstraint.priority = UILayoutPriorityDefaultLow
    trailingTypingConstraint.priority = UILayoutPriorityDefaultHigh
  }
}
