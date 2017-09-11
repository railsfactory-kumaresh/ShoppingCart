//
//  ProductCell.swift
//  ShoppingCart
//
//  Created by kumaresh on 11/09/17.
//  Copyright © 2017 Sedin Technologies. All rights reserved.
//

import UIKit

class ProductCell: BaseTableViewCell {

  @IBOutlet weak var lblProductName: UILabel!

  @IBOutlet weak var lblPrice: UILabel!
  
  @IBOutlet weak var lblStock: UILabel!

  @IBOutlet weak var btnBuyOrRemove: UIButton!


  // MARK: - Life cycle -
  override func awakeFromNib() {
    super.awakeFromNib()
  }

  @IBAction func btnBuyClicked(_ sender: Any) {
    //NotificationCenter.default.post(name: NSNotification.Name(rawValue: "buyclicked"), object:sender, userInfo: nil)
  }

  func configValues(product: Products){
    self.lblProductName.text = product.name
    self.lblPrice.text = "Price: \(String(product.price))"
    self.lblStock.text = "Stock: \(String(product.stock))"
  }

}





