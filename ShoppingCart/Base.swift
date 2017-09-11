//
//  Base.swift
//  ShoppingCart
//
//  Created by kumaresh on 11/09/17.
//  Copyright © 2017 Sedin Technologies. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {

  // MARK: - Life cycle -
  override func awakeFromNib() {
    super.awakeFromNib()
    selectionStyle = .none
  }
  
}
