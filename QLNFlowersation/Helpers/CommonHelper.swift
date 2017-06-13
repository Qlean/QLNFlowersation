//
//  CommonHelper.swift
//  QLNFlowersation
//
//  Created by Andrey Konstantinov on 09/06/2017.
//  Copyright © 2017 Qlean. All rights reserved.
//

import Foundation

func delay(_ delay: Double, closure: @escaping () -> ()) {
  DispatchQueue.main.asyncAfter(
    deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
}