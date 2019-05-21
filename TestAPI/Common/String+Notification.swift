//
//  String.swift
//  TestAPI
//
//  Created by Никита on 21/05/2019.
//  Copyright © 2019 Никита. All rights reserved.
//

import Foundation


extension UserDefaults {
    static let session = standard.value(forKey: "session") as? String

}

extension String {
    subscript(_ range: CountableRange<Int>) -> String {
        let idx1 = index(startIndex, offsetBy: max(0, range.lowerBound))
        let idx2 = index(startIndex, offsetBy: min(self.count, range.upperBound))
        return String(self[idx1..<idx2])
    }
}
