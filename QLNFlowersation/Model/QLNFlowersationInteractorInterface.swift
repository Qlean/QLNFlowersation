//
//  QLNFlowersationInteractorInterface.swift
//  QLNFlowersation
//
//  Created by Andrey Konstantinov on 11/06/2017.
//  Copyright © 2017 Qlean. All rights reserved.
//

protocol QLNFlowersationInteractorInput: class {
  func loadMessages()
}

protocol QLNFlowersationInteractorOutput: class {
  func didLoadMessages(firstMessage: QLNMessage)
  func addFirstLoadingCell()
}
