//
//  QiitaAPITestTests.swift
//  QiitaAPITestTests
//
//  Created by 薮木翔大 on 2022/10/27.
//

import XCTest
import SafariServices
@testable import QiitaAPITest

class QiitaAPITestTests: XCTestCase {
    var vc :ViewController!
    
    override func setUp() {
        let article = Article(title: "タイトル", url: "https://qiita.com/")
        let model = FakeQiitaAPIModel(response: [article])
        vc = ViewController()
        vc.model = model
    }

  
    //タイトル: ユーザーは記事一覧の１番目のタイトルを見ることができる
    //詳細
    //  given: ユーザーは記事一覧画面にいる
    //  When : ユーザーはステイタスバーを見る
    //  Then : ユーザーはその下の記事一覧の１タイトルを見ることができる
    
    //複雑な実装であれば簡単な実装から始めるのもあり
    //1.タイトルを表示するされること
    //2.タイトルの一覧が表示されていること
    
    func test_タイトルの一覧が表示されていること(){
       
        let window = UIWindow()
        window.rootViewController = vc
        window.makeKeyAndVisible()
        
        guard let cell = vc.tableView.dataSource?.tableView(vc.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? ListCell
        else {
            XCTFail()
            return
        }
        XCTAssertEqual(cell.titleLabel.text, "タイトル")
    }
    
    //タイトル: 記事をタップすると詳細画面に遷移できること
    //詳細
    //  given: ユーザーは記事一覧画面にいる
    //  When : ユーザーは記事をタップする
    //  Then : ユーザーはそ 詳細画面に遷移することができる
    //MEMO
    // * 詳細画面はSFSafariViewControllerで表示する
    
    func test_記事をタップで詳細画面に遷移すること(){
      
        
        let window = UIWindow()
        window.rootViewController = vc
        window.makeKeyAndVisible()
        
        vc.tableView(vc.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        
        XCTAssertTrue(vc.presentedViewController is SFSafariViewController)
    }
}


class FakeQiitaAPIModel:QiitaAPIProtocol{
    
    let  response: [Article]
    
    init(response: [Article]){
        self.response = response
    }
    func fetch(completion: @escaping (([Article]?) -> Void)) {
        completion(response)
    }
    
}
