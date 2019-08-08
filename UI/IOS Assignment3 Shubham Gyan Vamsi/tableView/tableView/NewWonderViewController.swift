//
//  NewWonderViewController.swift
//  tableView
//
//  Created by MCDA on 2019-07-20.
//  Copyright © 2019 MCDA. All rights reserved.
//

import UIKit

class NewWonderViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var wonders: [Wonders] = []
    var imageNames: [String] = []
    //override func
    let reuseIdentifier = String(describing: WondersTableViewCell.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageNames = ["pyramids","statue","flowers","lighthouse","tomb","statue","temple"]
        
        loadJsonFile()
    }
    
    // MARK: - Table view data source
    func loadJsonFile(){
        guard let jsonFile = Bundle.main.path(forResource: "wonders", ofType: "json") else { return }
        let optionalData = try? Data(contentsOf: URL(fileURLWithPath: jsonFile))
        guard
            let data = optionalData,
            let json = try? JSONSerialization.jsonObject(with: data),
            let dictionary = json as? [String:Any],
            let wondersDisctionary = dictionary["features"] as? [[String: Any]] else {return}
        let validWonders = wondersDisctionary.compactMap { Wonders(wonder: $0)}
        wonders.append(contentsOf:validWonders)
    }
   
    

}
extension NewWonderViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wonders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? WondersTableViewCell else { return UITableViewCell() }
        //cell.icon_label.text = wondersOfTheWorld[indexPath.row]
        cell.icon_label.text = wonders[indexPath.row].name
        //cell.icon.image = UIImage(named: imageNames[indexPath.row])
        //cell.icon.image = UIImage(named: wonders[indexPath.row].imageURL)
        downloaded(from: URL(string:wonders[indexPath.row].imageURL!)!,cellicon: cell.icon)
        return cell
    }
    
    func downloaded(from url: URL, cellicon: UIImageView, mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        //contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                cellicon.image = image
            }
            }.resume()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let obj = storyboard?.instantiateViewController(withIdentifier: "DetailedViewController") as? DetailedViewController
        obj?._description = wonders[indexPath.row].description ?? ""
        obj?._name = wonders[indexPath.row].name
        obj?._rating = wonders[indexPath.row].userRating ?? 0.0
        obj?._image = wonders[indexPath.row].imageURL!
        
        self.navigationController?.pushViewController(obj!, animated: true)
    }
}
