//
//  Color.swift
//  Custom_Calendar
//
//  Created by Duy Tran N. on 5/10/19.
//  Copyright © 2019 MBA0204. All rights reserved.
//

import UIKit

struct App {
    static let ratio: CGFloat = UIScreen.main.bounds.width / 375
}

struct Color {
    static let orange = RGB(red: 241, green: 128, blue: 107)
    static let saturdayTextBlue = RGB(red: 90, green: 188, blue: 222)
    static let cellRangeBlue = RGB(red: 188, green: 227, blue: 227)
    static let cellSelectedCornerBlue = RGB(red: 87, green: 186, blue: 186)
    static let black = RGB(red: 51, green: 51, blue: 51)
    static let pink = RGB(red: 238, green: 99, blue: 158)
    static let brown = RGB(red: 122, green: 114, blue: 117)
    static let calendarClearBackground = RGB(red: 247, green: 247, blue: 247)
}

extension Color {
    static func RGB(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha)
    }
}
