//
//  Products.swift
//  ShoppingCart
//
//  Created by kumaresh on 11/09/17.
//  Copyright © 2017 Sedin Technologies. All rights reserved.
//

import Foundation

class Products {
  var productId: Int!
  var name: String!
  var price: Double!
  var stock: Int!


  //MARK: - Set Products

  init(productName: String, price: Double, stock: Int) {
    self.name = productName
    self.price = price
    self.stock = stock
  }
}

