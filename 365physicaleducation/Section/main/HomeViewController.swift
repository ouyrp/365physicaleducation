//
//  ViewController.swift
//  365physicaleducation
//
//  Created by ouyang on 2017/12/14.
//  Copyright © 2017年 ouyang. All rights reserved.
//

import UIKit
import RxSwift
import SnapKit
import MJRefresh

let LPDBDistributorTableViewCellID = "LPDBDistributorTableViewCellID"

extension ViewController:UITableViewDelegate, UITableViewDataSource {
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor =  UIColor.white
        tableView.tableFooterView = UIView()
        tableView.register(OUYangTableViewCell.classForCoder(), forCellReuseIdentifier: LPDBDistributorTableViewCellID)
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            [weak self] in
            if let strongSelf = self {
                strongSelf.pageid = 0;
                strongSelf.loadData()
            }
        })
        tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock:{
            [weak self] in
            if let strongSelf = self {
                strongSelf.loadData()
            }
        })
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.top).offset(30)  
            make.left.right.bottom.equalTo(self.view)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = OUYWebViewController()
        controller.gankURL = arrdata[indexPath.row].url
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newslist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LPDBDistributorTableViewCellID, for: indexPath) as! OUYangTableViewCell
        if newslist.count > 0 {
            let model = newslist[indexPath.row]
            cell.setData(newData: model as! TestEntity)
        }
        return cell
    }
}

class ViewController: UIViewController {
    let tableView = UITableView()
    var arrdata:[TestEntity] = []
    var newslist:NSMutableArray = NSMutableArray.init()
    var pageid: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "365体育资讯"
        self.loadData();
        setupTableView()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let disposeBag = DisposeBag()
    
    fileprivate func loadData(){
        HTTP.request(TestApi(with:pageid))
            .asObservable()
            .mapArray(TestEntity.self, path: "showapi_res_body.newslist")
            .subscribe(onNext: {
                [weak self] in
                if let strongSelf = self {
                    strongSelf.arrdata = $0
                    if strongSelf.pageid == 0{
                        strongSelf.newslist.removeAllObjects()
                    }
                    strongSelf.newslist.addObjects(from: $0)
                    
                    if strongSelf.newslist.count % 15 == 0 {
                        strongSelf.pageid += 1
                    } else {
                        strongSelf.tableView.mj_footer.isHidden = true
                        strongSelf.tableView.mj_footer.endRefreshingWithNoMoreData()
                    }
                    strongSelf.tableView.reloadData()
                    strongSelf.tableView.mj_header.endRefreshing()
                    strongSelf.tableView.mj_footer.endRefreshing()
                }
            }, onError: {
                [weak self] in
                if let strongSelf = self {
                    strongSelf.tableView.mj_header.endRefreshing()
                    strongSelf.tableView.mj_footer.endRefreshing()
                }
                print($0)
            }).disposed(by: disposeBag)
    }
    
    
    
}

