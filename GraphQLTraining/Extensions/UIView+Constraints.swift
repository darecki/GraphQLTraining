//
//  UIView+Constraints.swift
//  GraphQLTraining
//
//  Created by Dariusz Ciesla on 14/07/2021.
//

import UIKit

extension UIView {
    func addConstraints(to other: UIView) {
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: other.leadingAnchor),
            topAnchor.constraint(equalTo: other.topAnchor),
            trailingAnchor.constraint(equalTo: other.trailingAnchor),
            bottomAnchor.constraint(equalTo: other.bottomAnchor)
        ])
    }
}
