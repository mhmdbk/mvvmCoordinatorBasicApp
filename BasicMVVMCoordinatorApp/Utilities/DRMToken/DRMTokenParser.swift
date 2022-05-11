//
//  DRMTokenParser.swift
//  SportsMax
//
//  Created by Hussein Jaber on 16/02/2021.
//

import Foundation


final class DRMTokenParser {
    struct DRMToken: Codable {
        let sub: String?
        let roles: [String]?
        let name: String?
        let customerId: Int?
        let exp: Double?
        let type: String?
        let userId: Int?
    }
    
    var token: DRMToken?
    private let jsonDecoder = JSONDecoder()
    
    init(drmToken: String) {
        let decodedDrmString = decodeJWTToken(jwtToken: drmToken)
        let data = decodedDrmString.data(using: .utf8)
        let token = try? jsonDecoder.decode(DRMToken.self, from: data!)
        self.token = token
    }
    
    private func decodeJWTToken(jwtToken: String) -> String {
        let segments = jwtToken.components(separatedBy: ".")
        if segments.count > 1 {
            var base64String = segments[1]
            print("\(base64String)")
            let requiredLength = Int(4 * ceil(Float(base64String.count) / 4.0))
            let nbrPaddings = requiredLength - base64String.count
            if nbrPaddings > 0 {
                let padding = String().padding(toLength: nbrPaddings, withPad: "=", startingAt: 0)
                base64String = base64String.appending(padding)
            }
            base64String = base64String.replacingOccurrences(of: "-", with: "+")
            base64String = base64String.replacingOccurrences(of: "_", with: "/")
            let decodedData = Data(base64Encoded: base64String, options: Data.Base64DecodingOptions(rawValue: UInt(0)))
            let base64DecodedString = String(data: decodedData!, encoding: .utf8)
            return base64DecodedString!
        }
        return ""


    }
}
