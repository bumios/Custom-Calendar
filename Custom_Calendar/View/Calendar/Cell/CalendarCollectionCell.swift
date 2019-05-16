//
//  CalendarCollectionCell.swift
//  Custom_Calendar
//
//  Created by Duy Tran N. on 5/10/19.
//  Copyright © 2019 MBA0204. All rights reserved.
//

import UIKit

final class CalendarCollectionCell: UICollectionViewCell {

    struct Config {
        static let borderWidth: CGFloat = 2
    }

    // MARK: - IBOutlets
    @IBOutlet private weak var dayLabel: UILabel!
    @IBOutlet private weak var dayBackgroundView: UIView!
    @IBOutlet private weak var highLightView: UIView!
    @IBOutlet private weak var eventDotView: UIView!
    @IBOutlet private weak var highLightViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet private weak var highLightViewTrailingConstraint: NSLayoutConstraint!

    // MARK: - Public
    func updateView(with viewModel: CalendarCollectionCellViewModel) {
        layoutIfNeeded()
        let eventDotViewBackgroundColor = viewModel.hasEvent ? Color.sundayTextOrange : .clear
        eventDotView.layer.cornerRadius = eventDotView.bounds.size.width / 2
        eventDotView.backgroundColor = eventDotViewBackgroundColor
        dayLabel.text = viewModel.displayName
        configureDefaultUI()

        /// Setup textColor
        switch viewModel.weekDay {
        case .saturday:
            dayLabel.textColor = Color.saturdayTextBlue
        case .sunday:
            dayLabel.textColor = Color.sundayTextOrange
        default:
            dayLabel.textColor = Color.normalTextColor
        }

        /// Setup layout
        switch viewModel.selectionStyle {
        case .beginSelectionOnly:
            dayBackgroundView.backgroundColor = .white
            commonLayoutForBeginAndEndSelection()
        case .beginSelection:
            highLightView.backgroundColor = Color.cellRangeBlue
            let spacingValue = 7 + (dayLabel.bounds.size.width / 2)
            highLightViewLeadingConstraint.constant = spacingValue
            dayBackgroundView.backgroundColor = .white
            commonLayoutForBeginAndEndSelection()
        case .inSelection:
            highLightView.backgroundColor = Color.cellRangeBlue
            if viewModel.weekDay == .saturday {
                highLightViewTrailingConstraint.constant = ceil(bounds.width - dayLabel.bounds.width)
            } else if viewModel.weekDay == .sunday {
                highLightViewLeadingConstraint.constant = ceil(bounds.width - dayLabel.bounds.width)
            }
        case .endSelection:
            highLightView.backgroundColor = Color.cellRangeBlue
            let spacingValue = 7 + (dayLabel.bounds.size.width / 2)
            highLightViewTrailingConstraint.constant = spacingValue
            dayBackgroundView.backgroundColor = .white
            commonLayoutForBeginAndEndSelection()
        default: break
        }
    }

    private func configureDefaultUI() {
        highLightView.backgroundColor = .clear
        highLightViewLeadingConstraint.constant = 0
        highLightViewTrailingConstraint.constant = 0
        dayBackgroundView.backgroundColor = .clear
        dayBackgroundView.layer.cornerRadius = 0
        dayLabel.layer.cornerRadius = 0
        dayLabel.layer.borderColor = UIColor.clear.cgColor
        dayLabel.layer.borderWidth = 0
    }

    private func commonLayoutForBeginAndEndSelection() {
        dayBackgroundView.layer.cornerRadius = dayLabel.bounds.size.width / 2
        dayLabel.layer.cornerRadius = dayLabel.bounds.size.width / 2
        dayLabel.layer.borderColor = Color.cellSelectedCornerBlue.cgColor
        dayLabel.layer.borderWidth = Config.borderWidth
    }
}
