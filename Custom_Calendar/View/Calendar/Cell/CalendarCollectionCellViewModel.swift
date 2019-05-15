//
//  CalendarCollectionCellViewModel.swift
//  Custom_Calendar
//
//  Created by Duy Tran N. on 5/10/19.
//  Copyright © 2019 MBA0204. All rights reserved.
//

import Foundation

final class CalendarCollectionCellViewModel {

    // MARK: - Properties
    let displayName: String

    // MARK: - Life cycle
    init(displayName: String = "") {
        self.displayName = displayName
    }
}
