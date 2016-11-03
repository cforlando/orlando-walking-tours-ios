//
//  LocationDetailVC.swift
//  Orlando Walking Tours
//
//  Created by Keli'i Martin on 6/4/16.
//  Copyright © 2016 Code for Orlando. All rights reserved.
//

import UIKit

class LocationDetailVC: UIViewController
{
    ////////////////////////////////////////////////////////////
    // MARK: - IBOutlets
    ////////////////////////////////////////////////////////////

    @IBOutlet weak var locationTitleLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var localDateLabel: UILabel!
    @IBOutlet weak var nationalDateLabel: UILabel!
    @IBOutlet weak var locationDescriptionLabel: UILabel!

    ////////////////////////////////////////////////////////////
    // MARK: - Properties
    ////////////////////////////////////////////////////////////

    var location: HistoricLocation?

    ////////////////////////////////////////////////////////////
    // MARK: - View Controller Life Cycle
    ////////////////////////////////////////////////////////////

    override func viewDidLoad()
    {
        super.viewDidLoad()

        localDateLabel.isHidden = false
        nationalDateLabel.isHidden = false
    }

    ////////////////////////////////////////////////////////////

    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)

        guard let location = location else
        {
            fatalError()
        }

        locationTitleLabel.text = location.locationTitle ?? ""
        addressLabel.text = location.address ?? ""
        locationDescriptionLabel.text = location.locationDescription ?? ""

        let formatter = DateFormatter()
        formatter.dateStyle = .long

        if let localDate = location.localRegistryDate
        {
            localDateLabel.text = "Added to Orlando Historic Registry on \(formatter.string(from: localDate as Date))"
        }
        else
        {
            self.localDateLabel.isHidden = true
        }

        if let nationalDate = location.nrhpDate
        {
            nationalDateLabel.text = "Added to National Historic Registry on \(formatter.string(from: nationalDate as Date))"
        }
        else
        {
            nationalDateLabel.isHidden = true
        }
    }
    ////////////////////////////////////////////////////////////
    // MARK: - IBActions
    ////////////////////////////////////////////////////////////

    @IBAction func backButtonTapped(sender: AnyObject)
    {
        dismiss(animated: true, completion: nil)
    }
}
