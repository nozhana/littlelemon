//
//  Fonts.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 6/14/24.
//

import SwiftUI

extension Font {
    static var displayLarge: Font {
        .custom("MarkaziText-Medium", size: 64, relativeTo: .largeTitle)
    }
    
    static var subtitle: Font {
        .custom("MarkaziText-Regular", size: 40)
    }
    
    static var leadText: Font {
        .custom("Karla-Medium", size: 18)
    }
    
    static var sectionTitle: Font {
        .custom("Karla-ExtraBold", size: 20).smallCaps()
    }
    
    static var sectionContent: Font {
        .custom("Karla-ExtraBold", size: 16)
    }
    
    static var cardTitle: Font {
        .custom("Karla-Bold", size: 18)
    }
    
    static var body: Font {
        .custom("Karla-Regular", size: 16)
    }
    
    static var highlight: Font {
        .custom("Karla-Medium", size: 16)
    }
    
    static var tagline: Font {
        .custom("Karla-Medium", size: 14)
    }
}
