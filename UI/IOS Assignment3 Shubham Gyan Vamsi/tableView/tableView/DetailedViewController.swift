//
//  DetailedViewController.swift
//  tableView
//
//  Created by MCDA on 2019-07-26.
//  Copyright © 2019 MCDA. All rights reserved.
//

import UIKit
import CoreLocation

class DetailedViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var descriptionlbl: UILabel!
    @IBOutlet weak var namelbl: UILabel!
    @IBOutlet weak var userRating: UILabel!
    @IBOutlet weak var viewImage: UIImageView!
    
    var _image = ""
    var _rating = 0.0
    var _name = ""
    var _description = ""
    var wonder: Wonders?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        namelbl.text = _name
        userRating.text = String(_rating)
        descriptionlbl.text = _description
        downloaded(from:URL(string:_image)!)
        let tap = UITapGestureRecognizer(target: self, action: #selector(DetailedViewController.tappedMe))
        viewImage.addGestureRecognizer(tap)
        viewImage.isUserInteractionEnabled = true
        // Do any additional setup after loading the view.
    }
    @objc func tappedMe()
    {
        showAlert()
    }
    
    func showAlert() {
        let copyURL = UIAlertAction(title: "Copy Img URL", style: .default) { (action:UIAlertAction!) in
            // Code in this block will trigger when OK button tapped.
            UIPasteboard.general.string = self._image
        }
        let alert = UIAlertController(title: "Info", message: "The URL of the Image is available for download.", preferredStyle: .alert)
        alert.addAction(copyURL)
        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func downloaded(from url: URL, mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        //contentMode = mode
        self.loadingView(shouldSpin: true)
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                
                else { return }
            DispatchQueue.main.async() {
                self.viewImage.image = image
                self.loadingView(shouldSpin: false)
            }
            }.resume()
    }
    
    
    
    func loadingView(shouldSpin status: Bool){
        if status == true {
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
        } else {
            
            activityIndicator.isHidden = true
            activityIndicator.startAnimating()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MapSegue" {
            let mapViewController = segue.destination as? MapViewController
            mapViewController?.wonderLocation = CLLocation(latitude: (wonder?.coordinate[1])! , longitude: (wonder?.coordinate[0])!)
            mapViewController?.wonderName = _name
            mapViewController?.wonderLocation2 = CLLocation(latitude: ((wonder?.coordinate[1])! - 0.01) , longitude: (wonder?.coordinate[0])!)
        }
    }

}
