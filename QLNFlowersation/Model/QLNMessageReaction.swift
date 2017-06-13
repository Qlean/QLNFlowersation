//
//  QLNMessageReaction.swift
//  QLNFlowersation
//
//  Created by Andrey Konstantinov on 07/04/16.
//  Copyright © 2016 Qlean. All rights reserved.
//

public final class QLNMessageReaction {

  public let nextId: String?
  public var next: QLNMessage?
  public var reaction: ((QLNMessage?) -> ())?
  private(set) var title = ""

  public required init(title: String?, nextId: String?, reaction: ((QLNMessage?) -> ())?) {
    if let titleOk = title {
      self.title = titleOk
    }
    self.nextId = nextId
    self.reaction = reaction
  }

}
