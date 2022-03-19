//
//  Dictionary + Extensions.swift
//  BasicMVVMCoordinatorApp
//
//  Created by MohammadBarek on 2022-03-07.
//

import Foundation

extension Dictionary {
    var toString: String {
        if let theJSONData = try? JSONSerialization.data(withJSONObject: self,
                                                         options: .sortedKeys),
            let jsonText = String(data: theJSONData,
                                  encoding: .utf8) {
            return jsonText
        }
        return ""
    }

    var data: Data? {
        guard let theJSONData = try? JSONSerialization.data(withJSONObject: self,
                                                            options: .sortedKeys) else {
            return nil
        }
        return theJSONData
    } 
}
