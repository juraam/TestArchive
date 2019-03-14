//
//  ViewController.swift
//  TestArchive
//
//  Created by Jura Moshkov on 14/03/2019.
//  Copyright © 2019 Jura Moshkov. All rights reserved.
//

import UIKit
import PKHUD

class ViewController: UIViewController {
    
    struct ReuseIdentifier {
        static let cell = "cell"
    }
    
    var items: [Archive] = []

    @IBOutlet weak var tableView: UITableView!
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        tableView.addSubview(refreshControl)
        refresh()
    }
    
    @objc func refresh() {
        HUD.show(.progress)
        ArchiveService.shared.loadItems(completion: { [unowned self] (arr) in
            HUD.hide()
            self.refreshControl.endRefreshing()
            self.items = arr
            self.tableView.reloadData()
            }, failure: { [unowned self] error in
                HUD.hide()
                self.refreshControl.endRefreshing()
                self.showError(error)
        })
    }
    
    fileprivate func showError(_ error: String) {
        let alert = UIAlertController(title: nil, message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.cell)
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: ReuseIdentifier.cell)
        }
        let archive = items[indexPath.row]
        cell?.textLabel?.text = "\(archive.size ?? 0)"
        cell?.detailTextLabel?.text = "\(archive.version ?? 0)"
        return cell
    }
}

