//
//  ViewController.swift
//  QiitaAPITest
//
//  Created by 薮木翔大 on 2022/10/27.
//

import UIKit

struct Article: Codable {
    let title: String
}

class ViewController: UIViewController {
    var model:QiitaAPIProtocol? = nil
    var items : [Article] = []
    let tableView:UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.register(ListCell.self, forCellReuseIdentifier: ListCell.identifier)
        return tableview
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        self.title = "Qiita"
            
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        
        tableView.dataSource = self
        tableView.delegate = self
        
        model?.fetch { article in
            guard let article = article,article.count > 0 else { return }
        
            self.items = article
            print(self.items)
            self.tableView.reloadData()
        }
    }

}


extension ViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(items.count)
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListCell.identifier, for: indexPath) as! ListCell
        cell.configure(title: items[indexPath.row].title)
        return cell
    }
    
    
}




