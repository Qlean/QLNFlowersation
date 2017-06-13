//
//  Parser.swift
//  TestProject
//
//  Created by Andrey Konstantinov on 11/06/2017.
//  Copyright © 2017 Qlean. All rights reserved.
//

import Foundation
import QLNFlowersation

final class Parser {

  func parseMessenges(from dictionary: [String: Any]) -> [QLNMessage] {
    guard let messagesJsonArray = dictionary["messages"] as? [AnyObject] else {
      return []
    }
    var messages = [QLNMessage]()
    // Store
    var messagesForNextPointers = [String: QLNMessage]()

    // Map messages
    for messageJson in messagesJsonArray {
      guard let messageId = messageJson["id"] as? String,
        let messageText = messageJson["text"] as? String else {
        continue
      }
      let nextId = messageJson["next_id"] as? String
      let image = self.parseMessageImage(messageJson["image"] as? [String: AnyObject])
      let last = messageJson["last"] as? Bool

      let message = QLNMessage.init(id: messageId, text: messageText, nextId: nextId, image: image, typingMessage: false, last: last)

      if let reactionsJsonArray = messageJson["reactions"] as? [[String: AnyObject]] {
        for reactionJson in reactionsJsonArray {
          let reaction = self.parseMessageReaction(reactionJson)
          message.reactions.append(reaction)
        }
      }
      messages.append(message)
      messagesForNextPointers[messageId] = message
    }

    // Connect messages with each other
    for message in messages {
      for reaction in message.reactions {
        if let reactionNextId = reaction.nextId {
          if let nextMessageFromReaction = messagesForNextPointers[reactionNextId] {
            reaction.next = nextMessageFromReaction
          }
        }
      }
      if let nextId = message.nextId {
        if let nextMessage = messagesForNextPointers[nextId] {
          message.next = nextMessage
        }
      }
    }

    messagesForNextPointers = [:]
    return messages
  }

  private func parseMessageReaction(_ reactionDictionary: [String: AnyObject]?) -> QLNMessageReaction {
    let title = reactionDictionary?["title"] as? String
    let nextId = reactionDictionary?["next_id"] as? String
    let reaction = QLNMessageReaction(title: title, nextId: nextId, reaction: nil)
    return reaction
  }

  private func parseMessageImage(_ imageDictionary: [String: AnyObject]?) -> QLNMessageImage? {
    guard let imageDictionary = imageDictionary,
      let imageUrlString = imageDictionary["image_url"] as? String,
      let imageUrl = URL.init(string: imageUrlString),
      let imageWidth = imageDictionary["width"] as? CGFloat,
      let imageHeight = imageDictionary["height"] as? CGFloat
      else {
        return nil
    }
    return QLNMessageImage(url: imageUrl, width: CGFloat(imageWidth), height: CGFloat(imageHeight))
  }

}
