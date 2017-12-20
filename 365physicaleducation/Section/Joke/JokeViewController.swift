//
//  JokeViewController.swift
//  365physicaleducation
//
//  Created by sunny on 2017/12/20.
//  Copyright © 2017年 ouyang. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import MJRefresh

class JokeViewController: UIViewController {

    let viewModel: JokeViewModel = JokeViewModel()
    let bag = DisposeBag()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configInterface()
        setupBindings()
        viewModel.load()
        
    }
    
    // 设置UI
    func configInterface() {
        
        tableView.sunny.config {
            $0.backgroundColor = UIColor.white
            $0.register(cellType: JokeTableViewCell.self)
        }
        
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [unowned self] in
            self.viewModel.load(false)
        })
        tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock:{ [unowned self] in
            self.viewModel.load(true)
        })
        
    }
    
    // 设置 ViewModel
    func setupBindings() {
        
        viewModel.output
            .asObserver()
            .subscribe(onNext: { [weak self] in
                self?.tableView.mj_header.endRefreshing()
                self?.tableView.mj_footer.endRefreshing()
                if $0 {
                    self?.tableView.reloadData()
                } else {
                    // 错误处理, 看偶像准备怎么弄
                }
                
            }).disposed(by: bag)
    }
    
}

extension JokeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.jokeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: JokeTableViewCell.self)
        cell.joke = viewModel.jokeList[indexPath.row]
        return cell
    }
}
