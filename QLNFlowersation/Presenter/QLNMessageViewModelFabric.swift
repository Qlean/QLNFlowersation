//
//  QLNMessageViewModelFabric.swift
//  QLNFlowersation
//
//  Created by Andrey Konstantinov on 11/06/2017.
//  Copyright © 2017 Qlean. All rights reserved.
//

import UIKit

final class QLNMessageViewModelFabric {

  let typingMessageId = "loading"

  func messageViewModel(from message: QLNMessage) -> QLNMessageViewModel {
    let isOutgoing = message.direction == .Outgoing
    let textColor = isOutgoing ? QLNMessagesSettings.outgoingBubbleTextColor : QLNMessagesSettings.incomingBubbleTextColor
    let backgroundColor = QLNMessagesBubbleFactory.bubbleColor(isOutgoing)
    let bubbleImage = isOutgoing ? QLNMessagesBubbleFactory.outgoingBubbleImage : QLNMessagesBubbleFactory.incomingBubbleImage
    let text = NSAttributedString.attributed(from: message.text, font: QLNMessagesSettings.normalTextFont, color: textColor)
    let isForeverTyping = message.id == typingMessageId
    let viewModel = QLNMessageViewModel(
      text: text,
      backgroundColor: backgroundColor,
      bubbleImage: bubbleImage,
      isOutgoing: isOutgoing,
      image: message.image,
      typingCell: message.typingMessage,
      animated: true,
      foreverTyping: isForeverTyping
    )
    return viewModel
  }

  func loadingMessageViewModel() -> QLNMessageViewModel {
    let message = QLNMessage.init(id: "loading", text: "   ", direction: QLNMessage.Direction.Incoming.rawValue, typingMessage: true, last: false)
    return messageViewModel(from: message)
  }

}
