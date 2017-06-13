//
//  QLNFlowersationViewInterface.swift
//  QLNFlowersation
//
//  Created by Andrey Konstantinov on 11/06/2017.
//  Copyright © 2017 Qlean. All rights reserved.
//

import UIKit

protocol QLNFlowersationViewInput: class {
  func reloadData()
  func typingCell(for indexPath: IndexPath) -> QLNMessageTextCell?
  func insertCell(at indexPath: IndexPath, scroll: Bool)
  func dismiss()
  func getWidth() -> CGFloat
}

protocol QLNFlowersationViewOutput: class {
  func setup(bottomReactionContainerView: UIView, reactionContainerHeightConstraint: NSLayoutConstraint)
  func loadMessages()
}
