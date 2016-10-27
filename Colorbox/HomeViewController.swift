//
//  HomeViewController.swift
//  Colorbox
//
//  Created by Cliff Harris on 10/26/16.
//  Copyright © 2016 Clifford Harris. All rights reserved.
//

import UIKit

private let kColorCellIdentifier = "colorCell"

final class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var previewView: UIView!
    private var colorDetails: [ColorDetails] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ColorBoxAPI.fetchSortedColors(completion: { [weak self] result in
            DispatchQueue.main.async {
                self?.colorDetails = result
                self?.tableView.reloadData()
            }
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colorDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kColorCellIdentifier) as! ColorCell
        
        let details = colorDetails[indexPath.row]
        cell.colorView.backgroundColor = details.getUIColor()
        cell.titleLabel.text = details.name
        cell.descriptionLabel.text = details.description
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let details = colorDetails[indexPath.row]
        previewView.backgroundColor = details.getUIColor()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}

