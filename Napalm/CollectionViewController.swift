//
//  CollectionViewController.swift
//  Napalm
//
//  Created by Mattia Picariello on 10/04/2017.
//  Copyright © 2017 NewppyTeam. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"


class CollectionViewController: UICollectionViewController, BuildsHeaderDelegate, UISearchBarDelegate, EmployeeManagerDelegate {
    func dataManipulaqtionFinished(employees: [Employee]){
        self.employeeList = employees
        self.filterEmployeeList = employees
        self.collectionView?.reloadData()
        
    }
    
    func dataImageManipulaqtionFinished(id: Int, image: UIImage) {
        self.employeeList[id].setImage(aImage: image)
        if loaded == false {
            self.filterEmployeeList[id].setImage(aImage: image)
        }
        let index = IndexPath(row: id, section: 0)
        self.collectionView?.reloadItems(at: [index])
    }

    
    var filterEmployeeList = [Employee]()
    var employeeList = [Employee]()
    var reload:Bool = false
    var sort: String = "ID"
    var loaded: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView?.contentInset = UIEdgeInsets(top: -44, left: 0, bottom: 0, right: 0)
//        employeeList = Singleton.sharedInstance.employees
//        filterEmployeeList = employeeList
        
        if loaded == false {
            let getRequest = NetworkRequests()
            getRequest.getData(completion: { (myEmployeeList) in
                self.loaded = true
                DispatchQueue.global(qos: .userInteractive).async {
                    self.employeeList = myEmployeeList!
                    self.dataManipulaqtionFinished(employees: self.employeeList)
                    for employee in self.employeeList{
                        employee.loadImage(completion: { (employeeImage) in
                            DispatchQueue.main.async {
                                employee.setImage(aImage: employeeImage as! UIImage)
                                self.dataImageManipulaqtionFinished(id: employee.nId-209, image: employeeImage as! UIImage)
                            }
                        })
                    }
                }
            })
        }
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return filterEmployeeList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
        if filterEmployeeList[indexPath.row].image == nil{
            cell.imageEmployee.image = UIImage(named: "default-user-image")
            reload = true
        } else {
            cell.imageEmployee.image = filterEmployeeList[indexPath.row].image
        }
        cell.roleEmployee.image = filterEmployeeList[indexPath.row].roleIcon
        cell.surnameLabel.text = filterEmployeeList[indexPath.row].surname
        
        return cell
    }
    //willSelectRowAt
    

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let destination = storyboard?.instantiateViewController(withIdentifier: "EmployeeDetails") as! ViewControllerDetail
        
        let mySender = filterEmployeeList[indexPath.row]
        
        destination.employee.setID(aID: mySender.getID())
        destination.employee.setName(aName: mySender.getName())
        destination.employee.setSurname(aSurname: mySender.getSurname())
        destination.employee.setRole(aRole: mySender.getRole())
        destination.employee.setRoleIcon(aRole: mySender.getRole())
        destination.employee.setUrlImage(aUrl: mySender.getUrlImage())
        destination.employee.setImage(aImage: mySender.getImage())
        
        self.navigationController?.pushViewController(destination, animated: true)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SearchView", for: indexPath) as! CollectionReusableView
        headerView.delegate = self //as? BuildsHeaderDelegate
        headerView.employeeList = filterEmployeeList
        
        return headerView
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if(!(searchBar.text?.isEmpty)!){
            //reload your data source if necessary
            self.collectionView?.reloadData()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchText.isEmpty){
            //reload your data source if necessary
            filterEmployeeList = employeeList
            self.collectionView?.reloadData()
            //searchBar.becomeFirstResponder()
        } else {
            let previusNumber = filterEmployeeList.count-1
            filterEmployeeList = employeeList.filter{ employee in
                let name = employee.surname
                
                return(name.lowercased().contains(searchText.lowercased()))
            }
            if previusNumber != 0 && previusNumber > filterEmployeeList.count-1{
                var items = [IndexPath]()
                for i in 0...filterEmployeeList.count-1{
                    let newElement = IndexPath(row: i, section: 0)
                    items.append(newElement)
                }
                var oldItems = [IndexPath]()
                for j in filterEmployeeList.count...previusNumber{
                    let newElement = IndexPath(row: j, section: 0)
                    oldItems.append(newElement)
                }
                self.collectionView?.deleteItems(at: oldItems)
                self.collectionView?.reloadItems(at: items)
            } else if previusNumber < filterEmployeeList.count-1{
                var items = [IndexPath]()
                for i in 0...previusNumber{
                    let newElement = IndexPath(row: i, section: 0)
                    items.append(newElement)
                }
                var newItems = [IndexPath]()
                for j in previusNumber+1...filterEmployeeList.count-1{
                    let newElement = IndexPath(row: j, section: 0)
                    newItems.append(newElement)
                }
                self.collectionView?.insertItems(at: newItems)
                self.collectionView?.reloadItems(at: items)
            }
            
            //searchBar.becomeFirstResponder()

        }
    }
    
    func updateCollectionView (newList: [Employee]) {
        self.collectionView?.reloadData()
        self.filterEmployeeList = newList
    }
    
    
    override func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        self.collectionView?.contentInset = UIEdgeInsets(top: 64,left: 0,bottom: 0,right: 0)
    }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.collectionView?.contentInset = UIEdgeInsets(top: 64,left: 0,bottom: 0,right: 0)
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "listSegue"{
            let destination = segue.destination as! TableViewController
            destination.employeeList = employeeList
        }
    }
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    
    

}
