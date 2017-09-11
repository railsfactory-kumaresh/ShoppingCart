//
//  DataManager.swift
//  ShoppingCart
//
//  Created by kumaresh on 11/09/17.
//  Copyright © 2017 Sedin Technologies. All rights reserved.
//

import Foundation
import SwiftyJSON


class DataManager {

  static let sharedInstance = DataManager()

  var products = [Products]()
  var carts = [Products]()
  var totalSpend = 0.0
  var jsonData: Data!

  //MARK: - Get production from Json object

  public func initProductList() {

    guard let url = Bundle.main.url(forResource: "Ekartproducts", withExtension: "json") else {
      print("Error finding JSON File")
      return
    }


    //Getting JSON data from URL
    do {
      jsonData = try Data(contentsOf: url)
    } catch let error as NSError{
      print(error.debugDescription)
      fatalError("Failed to initiate JSON data from URL!")
    }

    //getting top level JSON dictionary i.e. "members"

    let jsonObject = JSON(data: jsonData)

    products.removeAll()
    let productArray = jsonObject.arrayValue
    for ekartProducts in productArray {
      let name = ekartProducts["name"].stringValue
      let price = ekartProducts["price"].doubleValue
      let stock = ekartProducts["stock"].intValue

      let productDetails = Products(productName: name, price: price, stock: stock)
      products.append(productDetails)
    }

  }


  //MARK: - add Product to cart

  func addProductToCartList(productToAdd: Products, atPosition: Int){

    var found = false
    if carts.count > 0{

      for p in carts{

        if p.name == productToAdd.name{

          p.stock = p.stock + 1
          found = true
        }
      }

      if !found{
        let p = Products(productName: productToAdd.name, price: productToAdd.price, stock: 1)
        self.carts.append(p)

      }
    }else{

      let p = Products(productName: productToAdd.name, price: productToAdd.price, stock: 1)
      self.carts.append(p)

    }

    for p in self.products{
      if p === productToAdd{
        productToAdd.stock = productToAdd.stock - 1
      }
    }

    if productToAdd.stock < 1{
      self.products.remove(at: atPosition)
    }
  }

  //MARK: - Remove product from cart

  func removeProductFromCartList(productToRemove: Products, atPosition: Int){
    var found = false
    for p in carts{
      if p === productToRemove{
        p.stock = p.stock - 1
      }
    }

    for p in products{
      if p.name == productToRemove.name{
        p.stock = p.stock + 1
        found = true
      }
    }

    if !found{
      let p = Products(productName: productToRemove.name, price: productToRemove.price, stock: 1)
      self.products.append(p)
    }

    if productToRemove.stock < 1{
      self.carts.remove(at: atPosition)
    }
  }


  //MARK: - Calculate Total Spend

  func calculateTotalSpend() -> Double{
    self.totalSpend = 0.0
    for p in self.carts{
      self.totalSpend += (p.price * Double(p.stock))
    }
    
    return totalSpend
  }
}
