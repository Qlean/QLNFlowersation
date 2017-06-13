//
//  MessagesProvider.swift
//  TestProject
//
//  Created by Andrey Konstantinov on 10/06/2017.
//  Copyright © 2017 Qlean. All rights reserved.
//

import Foundation
import QLNFlowersation

final class MessagesProvider {

  fileprivate let data: [String: Any]!
  fileprivate let parser = Parser()

  init() {
    self.data = MessagesProvider.getData()
  }

  private static func getData() -> [String: Any]! {
    let dataUrl: String? = Bundle(for: MessagesProvider.self).path(forResource: "messages", ofType: "json")
    let jsonData: Data
    let jsonAny: Any?
    do {
      jsonData = try Data(contentsOf: URL.init(fileURLWithPath: dataUrl!), options: .mappedIfSafe)
      jsonAny = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers)
    } catch {
      assertionFailure("Broken data")
      jsonAny = nil
    }
    guard let jsonDictionary = jsonAny as? [String: Any] else {
      assertionFailure("Broken data")
      return nil
    }
    return jsonDictionary
  }

}

extension MessagesProvider: QLNMessagesProviderDelegate {

  func getOnboardingMessages(onSuccess: @escaping ([QLNMessage]) -> (), onError: (([String:Any])->())?) {
    onSuccess(parser.parseMessenges(from: data))
  }

}
