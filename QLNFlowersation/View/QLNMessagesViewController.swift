//
//  QLNMessagesViewController.swift
//  qlean
//
//  Created by Andrey Konstantinov on 05/04/16.
//  Copyright © 2016 qlean. All rights reserved.
//

import UIKit

final class QLNMessagesViewController: UIViewController {

  private struct LocalConstants {
    static let regularBottomInset: CGFloat = 150
  }

  var output: QLNFlowersationViewOutput!

  @IBOutlet fileprivate var tableView: UITableView!
  @IBOutlet private var statusBarBackgroundView: UIView!
  @IBOutlet private var bottomContainerView: UIView!
  @IBOutlet private var bottomReactionContainerView: UIView!
  @IBOutlet private var statusBarHeightConstraint: NSLayoutConstraint!
  @IBOutlet private var tableViewBottomToSuperViewConstraint: NSLayoutConstraint!
  @IBOutlet private var reactionContainerHeightConstraint: NSLayoutConstraint!

  override func viewDidLoad() {
    super.viewDidLoad()
    setupTableView()
    output.setup(bottomReactionContainerView: bottomReactionContainerView, reactionContainerHeightConstraint: reactionContainerHeightConstraint)
    // tableView.reloadData()
    statusBarBackgroundView.backgroundColor = QLNMessagesSettings.statusBarBackgroundColor
    statusBarHeightConstraint.constant = UIApplication.shared.statusBarFrame.size.height
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    tableView.setNeedsLayout()
    tableView.layoutIfNeeded()
    tableView.reloadData()
    output.loadMessages()
  }

  // MARK: - Private

  private func setupTableView() {
    tableView.backgroundColor = QLNMessagesSettings.backgroundColor
    setupTableViewinsets(LocalConstants.regularBottomInset)

    tableView.register(QLNMessageTextCell.self, forCellReuseIdentifier: String(describing: QLNMessageTextCell.self))
    let textCellNibBundle: Bundle = Bundle.init(for: QLNMessageTextCell.self)
    let cellNib = UINib(nibName: String(describing: QLNMessageTextCell.self), bundle: textCellNibBundle)
    tableView.register(cellNib, forCellReuseIdentifier: String(describing: QLNMessageTextCell.self))

    tableView.register(QLNMessageImageCell.self, forCellReuseIdentifier: String(describing: QLNMessageImageCell.self))
    let imageCellNibBundle: Bundle = Bundle.init(for: QLNMessageImageCell.self)
    let imageCellNib = UINib(nibName: String(describing: QLNMessageImageCell.self), bundle: imageCellNibBundle)
    tableView.register(imageCellNib, forCellReuseIdentifier: String(describing: QLNMessageImageCell.self))

    tableView.delegate = output as? UITableViewDelegate
    tableView.dataSource = output as? UITableViewDataSource

    tableView.estimatedRowHeight = 100
    tableView.rowHeight = UITableViewAutomaticDimension
  }

  private func setupTableViewinsets(_ bottomInset: CGFloat) {
    tableView.contentInset = UIEdgeInsetsMake(16, 0, bottomInset, 0)
    tableView.scrollIndicatorInsets = UIEdgeInsetsMake(16, 0, bottomInset, 0)
  }

}

// MARK: - QLNFlowersationViewInput

extension QLNMessagesViewController: QLNFlowersationViewInput {

  func reloadData() {
    tableView.reloadData()
  }

  func typingCell(for indexPath: IndexPath) -> QLNMessageTextCell? {
    guard let cell = tableView.cellForRow(at: indexPath) as? QLNMessageTextCell else { return nil }
    return cell
  }

  func insertCell(at indexPath: IndexPath, scroll: Bool) {
    tableView.beginUpdates()
    tableView.insertRows(at: [indexPath], with: .none)
    tableView.endUpdates()
    if scroll {
      tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
    }
  }

  func dismiss() {
    dismiss(animated: true, completion: nil)
  }

  func getWidth() -> CGFloat {
    return tableView.bounds.width
  }

}
