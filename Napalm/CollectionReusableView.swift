//
//  CollectionReusableView.swift
//  Napalm
//
//  Created by Mattia Picariello on 10/04/2017.
//  Copyright © 2017 NewppyTeam. All rights reserved.
//

import UIKit

protocol BuildsHeaderDelegate {
    func updateCollectionView(newList: [Employee])
}

class CollectionReusableView: UICollectionReusableView {
    @IBOutlet var sort: UISegmentedControl!
    @IBOutlet var searchBar: UISearchBar!
    
    let searchController = UISearchController(searchResultsController: nil)
    var filteredEmployee : [Employee]?
    
     var delegate: BuildsHeaderDelegate?
    var employeeList : [Employee]?
    
    @IBAction func sortDidPressed(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            employeeList?.sort(by: { $0.nId < $1.nId })
            self.delegate?.updateCollectionView(newList: employeeList!)
        } else if sender.selectedSegmentIndex == 1 {
            employeeList?.sort(by: { $0.role < $1.role })
            self.delegate?.updateCollectionView(newList: employeeList!)
        } else if sender.selectedSegmentIndex == 2 {
            employeeList?.sort(by: { $0.surname < $1.surname })
            self.delegate?.updateCollectionView(newList: employeeList!)
        }
    }

}
