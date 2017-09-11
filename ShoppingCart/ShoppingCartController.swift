//
//  ShoppingCartController.swift
//  ShoppingCart
//
//  Created by kumaresh on 11/09/17.
//  Copyright © 2017 Sedin Technologies. All rights reserved.
//

import UIKit

class ShoppingCartController: UIViewController {

  @IBOutlet weak var tblView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

      self.tblView.delegate = self
      self.tblView.dataSource = self
      self.registerTableCell()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


  //MARK: - Register UITableViewCell

  func registerTableCell() {
    let nib = UINib(nibName: "ProductCell", bundle: nil)
    self.tblView.register(nib, forCellReuseIdentifier: "productcell")
  }


  //MARK: - Action

  @IBAction func btnClose(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
  }

  //MARK: - Remove Product From Cart

  func removeProductFromCart(_ sender: UIButton){
    DataManager.sharedInstance.removeProductFromCartList(productToRemove: DataManager.sharedInstance.carts[sender.tag], atPosition: sender.tag)
    self.tblView.reloadData()
  }

}

  //MARK: - UITableViewDataSource
extension ShoppingCartController : UITableViewDataSource {

  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return DataManager.sharedInstance.carts.count
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let cell : ProductCell = (tableView.dequeueReusableCell(withIdentifier: "productcell", for: indexPath as IndexPath) as? ProductCell)!
    cell.btnBuyOrRemove.setTitle("DELETE", for: .normal)
    cell.btnBuyOrRemove.backgroundColor = UIColor.red
    cell.btnBuyOrRemove.tag = indexPath.row
    cell.configValues(product: DataManager.sharedInstance.carts[indexPath.row])
    cell.btnBuyOrRemove.addTarget(self, action: #selector(self.removeProductFromCart(_:)), for: .touchUpInside)

    return cell

  }

}


  //MARK: - UITableViewDelegate
extension ShoppingCartController : UITableViewDelegate {
    
    
  }
