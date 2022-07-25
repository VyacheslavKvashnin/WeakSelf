//
//  ViewController.swift
//  WeakSelf
//
//  Created by Вячеслав Квашнин on 25.07.2022.
//

import UIKit

class ViewController: UIViewController {
    
    let tableView = UITableView()
    
    @IBOutlet weak var label: UILabel!
    
    var service = NetworkManager()
    
    var posts: [Post] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        fetchData()
    }

    
    private func fetchData() {
        service.fetchData { result in
            switch result {
                
            case .success(let results):
                self.posts = results
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = posts[indexPath.row].title
        return cell
    }
}
