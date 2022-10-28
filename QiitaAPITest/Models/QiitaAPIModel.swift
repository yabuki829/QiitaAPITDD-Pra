//
//  QiitaAPIModel.swift
//  QiitaAPITest
//
//  Created by 薮木翔大 on 2022/10/27.
//

import Foundation
import UIKit




protocol QiitaAPIProtocol {
    func fetch(completion: @escaping (([Article]?) -> Void))
}



class QiitaAPIListModel:QiitaAPIProtocol{
    func fetch(completion: @escaping (([Article]?) -> Void)) {
        
        guard let url = URL(string: "https://qiita.com/api/v2/items") else {
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            let articleList = try? JSONDecoder().decode([Article].self, from: data)
            DispatchQueue.main.async {
                completion(articleList)
            }
        }.resume()
    }
}
