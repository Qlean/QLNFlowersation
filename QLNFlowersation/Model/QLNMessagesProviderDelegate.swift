//
//  QLNMessagesProviderDelegate.swift
//  QLNFlowersation
//
//  Created by Andrey Konstantinov on 10/06/2017.
//  Copyright © 2017 Qlean. All rights reserved.
//

public protocol QLNMessagesProviderDelegate: class {
  func getOnboardingMessages(onSuccess: @escaping ([QLNMessage]) -> (), onError: (([String:Any])->())?)
}
