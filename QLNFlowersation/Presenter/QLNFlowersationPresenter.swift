//
//  QLNFlowersationPresenter.swift
//  Pods
//
//  Created by Andrey Konstantinov on 11/06/2017.
//
//

import UIKit
import PureLayout

final class QLNFlowersationPresenter: NSObject {

  weak var userInterface: QLNFlowersationViewInput?
  var interactor: QLNFlowersationInteractorInput!
  fileprivate var items = [QLNMessageViewModel]()
  // Sizing
  // this is the cell height cache; obviously you don't want a static size array in production
  var itemHeights = [CGFloat](repeating: UITableViewAutomaticDimension, count: 1000)
  fileprivate var bottomReactionContainerView: UIView!
  fileprivate var reactionContainerHeightConstraint: NSLayoutConstraint!
  // Temp storage for constraint value
  fileprivate var reactionContainerHeightConstraintStorage: CGFloat = 0

  /// Flag - can or can't store/cache cell heights to prevent their recalculation
  fileprivate var canStoreCellHeights = false
  fileprivate let viewModelFabric = QLNMessageViewModelFabric()

  // MARK: - Actions

  @objc private func reactionButtonTapped(_ sender: QLNMessageReactionButton) {
    sender.setBackgroundImage(generateBubbleImage(true), for: UIControlState())
    dealWithMessageSend(sender)
  }

  private func dealWithMessageSend(_ qlnReactionBtn: QLNMessageReactionButton) {
    if let currentMessageOk = qlnReactionBtn.currentMessage {
      add(message: currentMessageOk)
    }

    // Autoinsert next message
    addNextMessageWithDelay(qlnReactionBtn.nextMessage)
  }

  private func addNextMessageWithDelay(_ nextMessage: QLNMessage?) {
    guard let nextMessageOk = nextMessage else { return }
    delay(2) {
      self.add(message: nextMessageOk)
      if nextMessageOk.last {
        delay(2) {
          self.sendDismissMessage()
        }
      }
    }
  }

  fileprivate func removeFirstLoadingCell() {
    items.removeFirst()
    let typingIndexPath = IndexPath(row: 0, section: 0)
    if let typingCell = userInterface?.typingCell(for: typingIndexPath) {
      typingCell.cancelTyping()
    }
    itemHeights[0] = UITableViewAutomaticDimension
  }

  private func reactionBubble(_ reaction: QLNMessageReaction) -> QLNMessageReactionButton {
    let messageAnswer = QLNMessage.init(id: "", text: reaction.title, direction: QLNMessage.Direction.Outgoing.rawValue, typingMessage: false, last: false)
    let button = QLNMessageReactionButton(currentMessage: messageAnswer, nextMessage: reaction.next, reactionObject: reaction)

    button.setBackgroundImage(generateBubbleImage(false), for: .normal)
    button.setBackgroundImage(generateBubbleImage(true), for: .highlighted)
    button.addTarget(self, action: #selector(reactionButtonTapped), for: .touchUpInside)

    return button
  }

  fileprivate func add(message: QLNMessage) {
    items.append(viewModelFabric.messageViewModel(from: message))
    let newIndexPath = IndexPath(row: (items.count - 1), section: 0)

    // Size for image message
    if let image = message.image {
      itemHeights[newIndexPath.row] = imageCellHeight(image)
    }
    userInterface?.insertCell(at: newIndexPath, scroll: true)

    removeReactionButtons()

    if let nextMessage = message.next {
      addNextMessageWithDelay(nextMessage)
    } else {
      delay(1) {
        self.addReactions(message)
      }
    }
  }

  private func addReactions(_ message: QLNMessage) {

    if message.reactions.count == 0 {
      return
    }

    var previousButtonOrView: UIView = bottomReactionContainerView
    var constantsToAnimate = [NSLayoutConstraint]()

    var reactionButtonsArray = [QLNMessageReactionButton]()

    for (index, reaction) in message.reactions.enumerated() {
      let reactionButton = reactionBubble(reaction)

      self.bottomReactionContainerView.addSubview(reactionButton)

      reactionButton.bottomConstraint = reactionButton.autoPinEdge(.bottom, to: .bottom, of: bottomReactionContainerView, withOffset: (50 + 28))

      let edgeForLeftConstraint: ALEdge = (reactionButton.isDescendant(of: previousButtonOrView)) ? .leading : .trailing
      let leftOffSet: CGFloat = reactionButton.isDescendant(of: previousButtonOrView) ? 0 : 8
      reactionButton.autoPinEdge(.leading, to: edgeForLeftConstraint, of: previousButtonOrView, withOffset: leftOffSet)
      previousButtonOrView = reactionButton

      // Attach trailing Edge only for the last view
      // For all other (previous) views trailing edge will be attached on the next step
      // Also check there wasn't TOP
      if (index == message.reactions.count - 1) {
        // Bottom
        reactionButton.autoPinEdge(.trailing, to: .trailing, of: reactionButton.superview!)
      }

      constantsToAnimate.append(reactionButton.bottomConstraint!)

      reactionButtonsArray.append(reactionButton)
    }
    self.bottomReactionContainerView.layoutIfNeeded()

    for constraint in constantsToAnimate {
      constraint.constant = 0
    }

    UIView.animate(
      withDuration: 0.3,
      delay: 1,
      options: [],
      animations: {
        self.bottomReactionContainerView.layoutIfNeeded()
    },
      completion: nil
    )
  }

  private func removeReactionButtons() {
    let oneCycleTime: Double = 0.3

    for button in (bottomReactionContainerView.subviews as! [QLNMessageReactionButton]) {
      button.bottomConstraint?.constant = (button.bounds.size.height + 24)
      delay(oneCycleTime) {
        button.removeFromSuperview()
      }
    }

    reactionContainerHeightConstraint.constant = reactionContainerHeightConstraintStorage

    UIView.animate(
      withDuration: oneCycleTime,
      delay: 0,
      options: [],
      animations: {
        self.bottomReactionContainerView.layoutIfNeeded()
    },
      completion: nil
    )
  }

  fileprivate func generateBubbleImage(_ highlighted: Bool) -> UIImage {
    let bundle = Bundle.init(for: QLNFlowersationPresenter.self)
    var bubbleImage = UIImage(named: "Bubble", in: bundle, compatibleWith: nil)
    bubbleImage = UIImage.imageMaskedWithColor(bubbleImage!, color: reactionColor(highlighted))
    bubbleImage = bubbleImage!.resizableImage(withCapInsets: UIEdgeInsetsMake(QLNMessagesSettings.bubbleImageInset, QLNMessagesSettings.bubbleImageInset, QLNMessagesSettings.bubbleImageInset, QLNMessagesSettings.bubbleImageInset), resizingMode: .stretch)

    return bubbleImage!
  }

  fileprivate func reactionColor(_ highlighted: Bool) -> UIColor {
    return highlighted ? QLNMessagesSettings.reactionButtonHighlightedStateColor : QLNMessagesSettings.reactionButtonNormalStateColor
  }

  fileprivate func sendDismissMessage(_ afterRegistration: Bool = false) {
    delay(1) {
      self.userInterface?.dismiss()
    }
  }

  fileprivate func imageCellHeight(_ image: QLNMessageImage) -> CGFloat {
    var heightToReturn: CGFloat = 4 // top (2) + bottom (2) = 4
    var imageNewWidth = image.width
    let maxImageWidth = (userInterface?.getWidth() ?? 0) - 16 - 48 // 48 - bad
    if maxImageWidth < imageNewWidth {
      imageNewWidth = maxImageWidth
    }
    heightToReturn = heightToReturn + imageNewWidth * image.height / image.width

    return round(heightToReturn)
  }

}

extension QLNFlowersationPresenter: QLNFlowersationInteractorOutput {

  func didLoadMessages(firstMessage: QLNMessage) {
    removeFirstLoadingCell()
    delay(1) {
      self.userInterface?.reloadData()
      self.canStoreCellHeights = true
      self.add(message: firstMessage)
    }

  }

  func addFirstLoadingCell() {
    items.append(viewModelFabric.loadingMessageViewModel())
    let newIndexPath = IndexPath(row: (items.count - 1), section: 0)
    userInterface?.insertCell(at: newIndexPath, scroll: false)
  }

}

extension QLNFlowersationPresenter: QLNFlowersationViewOutput {

  func loadMessages() {
    interactor?.loadMessages()
  }

  func setup(bottomReactionContainerView: UIView, reactionContainerHeightConstraint: NSLayoutConstraint) {
    self.bottomReactionContainerView = bottomReactionContainerView
    self.reactionContainerHeightConstraint = reactionContainerHeightConstraint
    reactionContainerHeightConstraintStorage = reactionContainerHeightConstraint.constant
  }

}

// MARK: - UITableViewDelegate & UITableViewDataSource

extension QLNFlowersationPresenter: UITableViewDelegate, UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }

  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    if itemHeights[indexPath.row] == UITableViewAutomaticDimension && canStoreCellHeights{
      itemHeights[indexPath.row] = cell.bounds.height
    }
  }

  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    return itemHeights[indexPath.row]
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return itemHeights[indexPath.row]
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var cell = tableView.dequeueReusableCell(withIdentifier: String(describing: QLNMessageTextCell.self), for: indexPath)
    guard (indexPath.row < items.count) else {
      return cell
    }
    if let messageImage = items[indexPath.row].image {
      cell = tableView.dequeueReusableCell(withIdentifier: String(describing: QLNMessageImageCell.self), for: indexPath)
      configImageCell(cell, messageImage: messageImage, animated: items[indexPath.row].animated)
      items[indexPath.row].animated = false
    } else {
      conficCell(cell, indexPath: indexPath)
    }
    return cell
  }

  private func conficCell(_ cell: UITableViewCell, indexPath: IndexPath) {
    if let specificCell = cell as? QLNMessageTextCell {
      if (indexPath as NSIndexPath).row < items.count {
        let message = items[indexPath.row]
        specificCell.prepareCell(message: message)
        message.animated = false
      }
    }
  }

  private func configImageCell(_ cell: UITableViewCell, messageImage: QLNMessageImage, animated: Bool) {
    if let specificCell = cell as? QLNMessageImageCell {
      specificCell.prepareCell(messageImage.url, animated: animated)
    }
  }
  
}
