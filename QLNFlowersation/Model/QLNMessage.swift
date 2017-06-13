//
//  QLNMessage.swift
//  QLNFlowersation
//
//  Created by Andrey Konstantinov on 06/04/16.
//  Copyright © 2016 Qlean. All rights reserved.
//

import UIKit

public final class QLNMessage {

  public enum Direction: String {
    case Incoming = "incoming"
    case Outgoing = "outgoing"
  }

  public var reactions = [QLNMessageReaction]()
  public var next: QLNMessage?
  public var showed: Bool = false

  private(set) var id: String = ""
  private(set) var text: String = ""
  private(set) var direction: Direction
  private(set) var typingMessage = false
  public let nextId: String?
  private(set) var image: QLNMessageImage?

  /// Last message - should dismiss controller or something when we find it
  private(set) var last: Bool = false

  public required init(id: String, text: String, direction: String = Direction.Incoming.rawValue, nextId: String? = nil, image: QLNMessageImage? = nil, typingMessage: Bool, last: Bool?) {
    self.id = id
    self.text = text
    self.direction = direction == Direction.Outgoing.rawValue ? Direction.Outgoing : Direction.Incoming
    self.nextId = nextId
    self.image = image
    self.typingMessage = typingMessage
    if let last = last {
      self.last = last
    }
  }

}
