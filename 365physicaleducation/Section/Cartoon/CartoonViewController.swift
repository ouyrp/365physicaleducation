//
//  CartoonViewController.swift
//  365physicaleducation
//
//  Created by sunny on 2017/12/21.
//  Copyright © 2017年 ouyang. All rights reserved.
//

import UIKit
import MJRefresh
import RxSwift
import RxCocoa

class CartoonViewController: UIViewController {
    
    let bag = DisposeBag()
    
    init(_ type: CartoonType) {
        self.viewModel = CartoonViewModel(type)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: CartoonViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configInterface()
        setupBindings()
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


extension CartoonViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(for: indexPath, cellType: JokeTableViewCell.self)
    }
}
