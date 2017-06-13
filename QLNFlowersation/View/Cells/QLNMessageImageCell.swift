//
//  QLNMessageImageCell.swift
//  QLNFlowersation
//
//  Created by Andrey Konstantinov on 12/04/16.
//  Copyright © 2016 Qlean. All rights reserved.
//

import UIKit
import AlamofireImage

final class QLNMessageImageCell: UITableViewCell {

  @IBOutlet private var contentImageView: UIImageView! {
    didSet {
      contentImageView.layer.cornerRadius = QLNMessagesSettings.bubbleImageInset
      contentImageView.clipsToBounds = true
    }
  }

  // Real constraints
  @IBOutlet private var containerLeadingConstraint: NSLayoutConstraint!
  @IBOutlet private var containerTrailingConstraint: NSLayoutConstraint!
  @IBOutlet private var widthConstraint: NSLayoutConstraint!

  // 'Behind screen' constraints
  @IBOutlet private var incomingBackgroundConstraint: NSLayoutConstraint!

  override func awakeFromNib() {
    super.awakeFromNib()
    widthConstraint.constant = UIScreen.main.bounds.width - containerLeadingConstraint.constant - containerTrailingConstraint.constant
    layoutIfNeeded()
    cellToInitialState()
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    cellToInitialState()
  }

  func prepareCell(_ imageUrl: URL, animated: Bool) {
    contentImageView.af_setImage(withURL: imageUrl, placeholderImage: QLNMessagesSettings.placeholderImage, filter: nil, progress: nil, progressQueue: DispatchQueue.main, imageTransition: .noTransition, runImageTransitionIfCached: false, completion: nil)
    showImageContent(animated)
  }

  // MARK: - Private

  private func showImageContent(_ animated: Bool) {
    let duration: TimeInterval = animated ? QLNMessagesSettings.chatMessageAnimationStepInterval : 0

    if animated {
      incomingBackgroundConstraint.priority = UILayoutPriorityDefaultHigh
      containerLeadingConstraint.priority = UILayoutPriorityDefaultLow
      containerTrailingConstraint.priority = UILayoutPriorityDefaultLow
      layoutIfNeeded()
    }

    constraintToNormalState()

    UIView.animate(
      withDuration: duration,
      delay: 0,
      options: QLNMessagesSettings.cellAnimationOption,
      animations: { self.layoutIfNeeded() },
      completion: nil
    )
  }

  private func cellToInitialState() {
    contentImageView.image = QLNMessagesSettings.placeholderImage
    constraintToNormalState()
  }

  private func constraintToNormalState() {
    incomingBackgroundConstraint.priority = UILayoutPriorityDefaultLow
    containerLeadingConstraint.priority = UILayoutPriorityDefaultHigh
    containerTrailingConstraint.priority = UILayoutPriorityDefaultHigh
  }
}
