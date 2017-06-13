//
//  QLNMessageImage.swift
//  QLNFlowersation
//
//  Created by Andrey Konstantinov on 12/04/16.
//  Copyright © 2016 Qlean. All rights reserved.
//

public class QLNMessageImage {

  private(set) var url: URL
  private(set) var width: CGFloat
  private(set) var height: CGFloat

  public required init(url: URL, width: CGFloat, height: CGFloat) {
    self.url = url
    self.width = width
    self.height = height
  }

}
