//
//  CalendarCollectionCell.swift
//  Custom_Calendar
//
//  Created by Duy Tran N. on 5/10/19.
//  Copyright © 2019 MBA0204. All rights reserved.
//

import UIKit

final class CalendarCollectionCell: UICollectionViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var dayLabel: UILabel!

    // MARK: - Properties
    var viewModel = CalendarCollectionCellViewModel()

    // MARK: - Public
    func updateView(with viewModel: CalendarCollectionCellViewModel) {
        dayLabel.text = viewModel.displayName
    }
}
