//
//  AppDelegate.swift
//  Pokedex
//
//  Created by Jarrod Parkes on 5/8/20.
//  Copyright © 2020 Spur. All rights reserved.
//

import UIKit

// MARK: - AppDelegate: UIResponder, UIApplicationDelegate

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: Properties
    
    var window: UIWindow?
    
    var navVC: UINavigationController?
    var types: [String] = [
        "Fire",
        "Water",
        "Grass"
    ]
    var cards: [Card] = []
    
    // MARK: UIApplicationDelegate
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
                        
        // create main window
        window = UIWindow(frame: UIScreen.main.bounds)
        guard let window = window else { return false }
               
        // setup tab controller
        let byNumberVC = UITableViewController()
        byNumberVC.tableView.tag = 0
        byNumberVC.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        byNumberVC.tableView.delegate = self
        byNumberVC.tableView.dataSource = self
        byNumberVC.title = "By Number"
        
        let byTypeVC = UITableViewController()
        byTypeVC.tableView.tag = 1
        byTypeVC.title = "By Type"
                
        let tabVC = UITabBarController()
        tabVC.title = "Pokedex"
        tabVC.setViewControllers([byNumberVC, byTypeVC], animated: true)
        
        // create root controller
        navVC = UINavigationController(rootViewController: tabVC)
        window.rootViewController = navVC
    
        window.makeKeyAndVisible()
        
        return true
    }
}

// MARK: - AppDelegate: UITableViewDelegate

extension AppDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableView.tag {
        case 0: handleTypesTableTap(tableView, didSelectRowAt: indexPath)
        default: return
        }
    }

    private func handleTypesTableTap(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // approach #1: make the request, get the data, THEN display the table VC (before transitioning, lock screen while request is in flight)
        // approach #2: display table VC, and when the table VC calls viewDidLoad, get the data (after transitioning, lock screen while request is in flight)
        
        let type = types[indexPath.row]
        
        let session = URLSession.shared
                
        if let url = URL(string: "https://api.pokemontcg.io/v1/cards?types=\(type)") {
            
            let task = session.dataTask(with: url) { (data, response, error) in
                DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
                
                if error == nil {
                    
                    let decoder = JSONDecoder()
                                                            
                    if let data = data {
                        do {
                            let cardsResponse = try decoder.decode(CardsResponse.self, from: data)
                            
                            self.cards = cardsResponse.cards
                            
                            DispatchQueue.main.async {
                                let cardsByTypeVC = UITableViewController()
                                cardsByTypeVC.tableView.tag = 2
                                cardsByTypeVC.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
                                cardsByTypeVC.tableView.delegate = self
                                cardsByTypeVC.tableView.dataSource = self
                                cardsByTypeVC.title = "Cards by Type"
                                
                                self.navVC?.pushViewController(cardsByTypeVC, animated: true)
                            }
                        } catch let decodingError {
                            print(decodingError)
                        }
                        
                    } else {
                        print("couldn't decode!")
                    }
                    
                } else {
                    print(error?.localizedDescription ?? "")
                }
            }
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            task.resume()
        }
    }
}

// MARK: - AppDelegate: UITableViewDataSource

extension AppDelegate: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView.tag {
        case 0: return types.count
        case 1: return 0
        default: return cards.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView.tag {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = types[indexPath.row]
            return cell
        case 1:
            return UITableViewCell()
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = cards[indexPath.row].name
            return cell
        }
        
    }
}
