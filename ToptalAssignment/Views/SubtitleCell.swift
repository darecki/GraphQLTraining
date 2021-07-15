//
//  SubtitleCell.swift
//  ToptalAssignment
//
//  Created by Dariusz Ciesla on 15/07/2021.
//

import UIKit

final class SubtitleCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
