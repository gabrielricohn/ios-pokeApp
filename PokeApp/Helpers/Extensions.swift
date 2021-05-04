//
//  Extensions.swift
//  PokeApp
//
//  Created by Gabriel Rico on 23/2/21.
//

import Foundation
import UIKit

extension UICollectionView {

    func deselectAllItems(animated: Bool) {
        guard let selectedItems = indexPathsForSelectedItems else { return }
        for indexPath in selectedItems { deselectItem(at: indexPath, animated: animated) }
    }
    
    func reloadDataWithAutoSizingCellWorkAround() {
        self.reloadData()
        self.setNeedsLayout()
        self.layoutIfNeeded()
        self.reloadData()
    }
}
