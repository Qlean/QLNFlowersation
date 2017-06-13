//
//  QLNFlowersation.swift
//  QLNFlowersation
//
//  Created by Andrey Konstantinov on 10/06/2017.
//  Copyright © 2017 Qlean. All rights reserved.
//

import UIKit.UIViewController

public final class QLNFlowersation {

  private let userInterface: UIViewController!

  public init(messagesProvider: QLNMessagesProviderDelegate) {
    let bundle = Bundle.init(for: QLNMessagesViewController.self)
    let viewController = QLNMessagesViewController(nibName: String.init("\(QLNMessagesViewController.self)"), bundle: bundle)
    self.userInterface = viewController
    let presenter = QLNFlowersationPresenter()
    presenter.userInterface = viewController
    let interactor = QLNFlowersationIntercator(output: presenter, service: messagesProvider)
    presenter.interactor = interactor
    viewController.output = presenter
  }

  private init() {
    self.userInterface = nil
  }

  public func presentConversation(from viewController: UIViewController, animated flag: Bool, completion: (() -> Swift.Void)? = nil) {
    viewController.present(self.userInterface, animated: flag, completion: completion)
  }

}
