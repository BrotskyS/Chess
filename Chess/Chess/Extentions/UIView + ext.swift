//
//  UIView + ext.swift
//  Chess
//
//  Created by Sergiy Brotsky on 20.04.2023.
//

import Foundation
import UIKit

extension UIView {
    func asCircle() {
        print("frame\(self.frame)")
        self.layer.cornerRadius = self.frame.width / 2
        self.layer.masksToBounds = true
    }
}
