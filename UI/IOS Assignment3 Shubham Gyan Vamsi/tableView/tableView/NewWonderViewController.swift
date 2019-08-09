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
    var dataToSave = Data()
    //override func
    let reuseIdentifier = String(describing: WondersTableViewCell.self)
    
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchieveURL = DocumentsDirectory.appendingPathComponent("Wonders")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageNames = ["pyramids","statue","flowers","lighthouse","tomb","statue","temple"]
        loadJsonFile()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "SaveWondersSegue"){
            let savedWondersViewController = segue.destination as? SavedWondersViewController
            savedWondersViewController?.savedWonders = loadSavedData()
        }
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
        if wonders.count > 1 {
            saveToLocalStorage()
        }
    }
   
    func saveToLocalStorage(){
        do{
            dataToSave = try NSKeyedArchiver.archivedData(withRootObject: wonders, requiringSecureCoding: false)
            try dataToSave.write(to: NewWonderViewController.ArchieveURL)
        } catch {
            print("Could not write")
        }
    }
    
    func loadSavedData() -> [Wonders]{
        var saveWonders: [Wonders] = []
        do {
            if let loadedStrings = try
                NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(dataToSave) as? [Wonders] {
                saveWonders = loadedStrings
            }
        } catch{
            print("Could not read")
        }
        return saveWonders
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
        downloaded(from: URL(string:wonders[indexPath.row].imageURL)!,cellicon: cell.icon)
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
        obj?._description = wonders[indexPath.row].wonderDescription ?? ""
        obj?._name = wonders[indexPath.row].name
        obj?._rating = wonders[indexPath.row].userRating 
        obj?._image = wonders[indexPath.row].imageURL
        obj?.wonder = wonders[indexPath.row]
        self.navigationController?.pushViewController(obj!, animated: true)
    }
}
