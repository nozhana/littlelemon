//
//  Color+Extension.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 6/18/24.
//

import SwiftUI

extension Color {
    init?(hex: String, opacityPercent: CGFloat = 100) {
        var code = hex
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .trimmingCharacters(in: ["#"])
        guard [2,3,6].contains(code.count) else { return nil }
        
        switch code.count {
        case 3:
            var result = ""
            for character in code {
                result.append(String(repeating: character, count: 2))
            }
            code = result
        case 2:
            code = String(repeating: code, count: 3)
        default:
            break
        }
        
        var rgbValues: [CGFloat] = []
        while !code.isEmpty {
            guard let int1 = resolveHexCharacter(code.removeFirst()),
                  let int2 = resolveHexCharacter(code.removeFirst()) else { return nil }
            rgbValues.append(CGFloat(int1 * 16 + int2) / 255)
        }
        
        let opacity = opacityPercent / 100
        
        self.init(red: rgbValues[0], green: rgbValues[1], blue: rgbValues[2], opacity: opacity)
    }
    
}

fileprivate func resolveHexCharacter(_ character: Character) -> Int? {
    if let intValue = Int(String(character)) {
        return intValue
    } else if let hexDigit = HexDigit(hex: character) {
        return hexDigit.rawValue
    } else {
        return nil
    }
}

fileprivate enum HexDigit: Int, CustomStringConvertible, CaseIterable {
    case A = 10
    case B, C, D, E, F
    
    var description: String {
        switch self {
        case .A:
            return "A"
        case .B:
            return "B"
        case .C:
            return "C"
        case .D:
            return "D"
        case .E:
            return "E"
        case .F:
            return "F"
        }
    }
    
    init?(hex: Character) {
        for digit in Self.allCases {
            if hex.uppercased() == digit.description {
                self = digit
                return
            }
        }
        return nil
    }
}
