//
//  QLNFlowersationIntercator.swift
//  QLNFlowersation
//
//  Created by Andrey Konstantinov on 11/06/2017.
//  Copyright © 2017 Qlean. All rights reserved.
//

final class QLNFlowersationIntercator {

  weak var output: QLNFlowersationInteractorOutput?
  private let service: QLNMessagesProviderDelegate!

  init(output: QLNFlowersationInteractorOutput, service: QLNMessagesProviderDelegate) {
    self.output = output
    self.service = service
  }

  fileprivate func startLoadingMessages(_ firstTime: Bool) {
    if firstTime {
      output?.addFirstLoadingCell()
    }
    service.getOnboardingMessages(
      onSuccess: {
        [weak self]
        messages in
        if let firstMessage = messages.first {
          self?.output?.didLoadMessages(firstMessage: firstMessage)
        }
      },
      onError: nil
    )
  }

}

extension QLNFlowersationIntercator: QLNFlowersationInteractorInput {

  func loadMessages() {
    startLoadingMessages(true)
  }

}
