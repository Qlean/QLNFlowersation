//
//  ViewController.swift
//  TestProject
//
//  Created by Andrey Konstantinov on 09/06/2017.
//  Copyright © 2017 Qlean. All rights reserved.
//

import UIKit
import QLNFlowersation

class ViewController: UIViewController {

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    let messagesProvider = MessagesProvider()
    let flowersation = QLNFlowersation.init(messagesProvider: messagesProvider)
    flowersation.presentConversation(from: self, animated: true)
  }

}

