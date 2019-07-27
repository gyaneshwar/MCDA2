//
//  DetailedViewController.swift
//  tableView
//
//  Created by MCDA on 2019-07-26.
//  Copyright © 2019 MCDA. All rights reserved.
//

import UIKit

class DetailedViewController: UIViewController {

    @IBOutlet weak var descriptionlbl: UILabel!
    @IBOutlet weak var namelbl: UILabel!
    @IBOutlet weak var userRating: UILabel!
    @IBOutlet weak var viewImage: UIImageView!
    
    var _image = ""
    var _rating = 0.0
    var _name = ""
    var _description = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        namelbl.text = _name
        userRating.text = String(_rating)
        descriptionlbl.text = _description
        downloaded(from:URL(string:_image)!)
        // Do any additional setup after loading the view.
    }
    
    func downloaded(from url: URL, mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        //contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.viewImage.image = image
            }
            }.resume()
    }

}
