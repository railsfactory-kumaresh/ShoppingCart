//
//  ProductListController.swift
//  ShoppingCart
//
//  Created by kumaresh on 11/09/17.
//  Copyright © 2017 Sedin Technologies. All rights reserved.
//

import UIKit

class ProductListController: UIViewController {

  @IBOutlet weak var lblTotalSpend: UILabel!

  @IBOutlet weak var btnCartCount: UIButton!

  @IBOutlet weak var tblView: UITableView!

  var productsArrayList = [Products]()

    override func viewDidLoad() {
      super.viewDidLoad()


      self.tblView.delegate = self
      self.tblView.dataSource = self
      self.registerTableCell()
        // Do any additional setup after loading the view.
    }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    if DataManager.sharedInstance.carts.count == 0 {
      self.lblTotalSpend.text = "Total spend $0"
      self.btnCartCount.setTitle("0", for: .normal)
    }

    self.tblView.reloadData()
  }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  func registerTableCell() {
    let nib = UINib(nibName: "ProductCell", bundle: nil)
    self.tblView.register(nib, forCellReuseIdentifier: "productcell")
  }

  //MARK: - ACTION

  @IBAction func btnCartCountClicked(_ sender: Any) {

    let cartVC = self.storyboard?.instantiateViewController(withIdentifier: "ShoppingCartController") as? ShoppingCartController
    self.present(cartVC!, animated: true, completion: nil)
  }


  //MARK: - ADD TO CART

  func addProductToCartList(_ sender: UIButton){
    DataManager.sharedInstance.addProductToCartList(productToAdd: DataManager.sharedInstance.products[sender.tag], atPosition: sender.tag)
    self.tblView.reloadData()
    self.lblTotalSpend.text = "Total spend $\(DataManager.sharedInstance.calculateTotalSpend())"
  
    self.btnCartCount.setTitle(String(DataManager.sharedInstance.carts.count), for: .normal)
  }

}

//MARK: - UITableViewDataSource
extension ProductListController : UITableViewDataSource {

  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return DataManager.sharedInstance.products.count
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let cell : ProductCell = (tableView.dequeueReusableCell(withIdentifier: "productcell", for: indexPath as IndexPath) as? ProductCell)!
    cell.configValues(product: DataManager.sharedInstance.products[indexPath.row])
    cell.btnBuyOrRemove.tag = indexPath.row
    cell.btnBuyOrRemove.setTitle("BUY", for: .normal)
    cell.btnBuyOrRemove.backgroundColor = UIColor.init(red: 0, green: 168/255, blue: 159/255, alpha: 1)
    cell.btnBuyOrRemove.addTarget(self, action: #selector(self.addProductToCartList(_:)), for: .touchUpInside)

    return cell

  }

}


//MARK: - UITableViewDelegate
extension ProductListController : UITableViewDelegate {

  
}
