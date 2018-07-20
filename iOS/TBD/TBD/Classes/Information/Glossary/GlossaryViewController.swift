//
//  GlossaryViewController.swift
//  TBD
//
//  Created by Stefan Olaru on 20/07/2018.
//  Copyright © 2018 Shivering Singletons. All rights reserved.
//

import UIKit
struct GlossaryModel {
    var name: String
    var vvalue: String
    
    init(name: String, vvalue: String) {
        self.name = name
        self.vvalue = vvalue
    }
    
    init?(dictionary: [String: String]) {
        guard let name = dictionary["Name"], let vvalue = dictionary["Value"] else {
            return nil
        }
        self.init(name: name, vvalue: vvalue)
    }
    
    static func getArrayOfGlossary() -> [String] {
        var entries = [String]()
        let dicts = allEntries()
        entries = dicts.map({return $0.name})
        return entries
    }
    
    static func allEntries() -> [GlossaryModel] {
        var entries = [GlossaryModel]()
        guard let URL = Bundle.main.url(forResource: "Glossary", withExtension: "plist"),
            let entriesFromPlist = NSArray(contentsOf: URL) as? [[String:String]] else {
                return entries
        }
        for dictionary in entriesFromPlist {
            if let entry = GlossaryModel(dictionary: dictionary) {
                entries.append(entry)
            }
        }
        return entries
    }
}
    
class GlossaryViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var wordsDictionary = [String: [String]]()
    var wordsSectionTitles = [String]()
    var words = [String]()
    var wordsG = [GlossaryModel]()
    let transition = CircularTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        words = GlossaryModel.getArrayOfGlossary()
        wordsG = GlossaryModel.allEntries()
        
        for word in words {
            let wordKey = String(word.prefix(1))
            if var wordValues = wordsDictionary[wordKey] {
                wordValues.append(word)
                wordsDictionary[wordKey] = wordValues
            } else {
                wordsDictionary[wordKey] = [word]
            }
        }
        
        wordsSectionTitles = [String](wordsDictionary.keys)
        wordsSectionTitles = wordsSectionTitles.sorted(by: { $0 < $1 })
        title = "Glossary"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


extension GlossaryViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return wordsSectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let carKey = wordsSectionTitles[section]
        if let carValues = wordsDictionary[carKey] {
            return carValues.count
        }
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GlossaryCell", for: indexPath)
        // Configure the cell...
        let carKey = wordsSectionTitles[indexPath.section]
        if let carValues = wordsDictionary[carKey] {
            cell.textLabel?.text = carValues[indexPath.row]
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        for word in wordsG {
            let carKey = wordsSectionTitles[indexPath.section]
            if let carValues = wordsDictionary[carKey] {
                if word.name == carValues[indexPath.row] {
                    print(word.vvalue)
                    // Show the meaning of this
                    let modalVC = storyboard?.instantiateViewController(withIdentifier: String.init(describing: WebViewController.self)) as! WebViewController
                    
                    modalVC.transitioningDelegate = self
                    modalVC.modalPresentationStyle = .custom
                    //modalVC.youtubeURL = "XGcX5wopq3M"
                    modalVC.textHTML = word.vvalue
                    
                    self.present(modalVC, animated: true, completion: nil)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return wordsSectionTitles[section]
    }
    
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return wordsSectionTitles
    }
    
}

extension GlossaryViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = CGPoint.init(x: 0, y: self.view.frame.height)
        transition.circleColor = UIColor.white
        
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint =  CGPoint.init(x: 0, y: self.view.frame.height)
        transition.circleColor = UIColor.white
        
        return transition
    }
}
