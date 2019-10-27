//
//  NewsFeedViewController.swift
//  VKNews
//
//  Created by Глеб on 13.10.2019.
//  Copyright (c) 2019 Глеб. All rights reserved.
//

import UIKit

protocol NewsFeedDisplayLogic: class {
  func displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData)
}

class NewsFeedViewController: UIViewController, NewsFeedDisplayLogic, NewsFeedCodeCellDelegate {

  var interactor: NewsFeedBusinessLogic?
  var router: (NSObjectProtocol & NewsFeedRoutingLogic)?
    
    private var feedViewModel = FeedViewModel.init(cells: [], footerTitle: nil)
    private var titleView = TitleView()
    private lazy var footerView = FooterView()
    
    private var refreshControl : UIRefreshControl = {
       let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return refreshControl
    }()
    
    
    
    @IBOutlet weak var table: UITableView!
    
  // MARK: Setup
  
  private func setup() {
    let viewController        = self
    let interactor            = NewsFeedInteractor()
    let presenter             = NewsFeedPresenter()
    let router                = NewsFeedRouter()
    viewController.interactor = interactor
    viewController.router     = router
    interactor.presenter      = presenter
    presenter.viewController  = viewController
    router.viewController     = viewController
  }
  
  // MARK: Routing
  

  
  // MARK: View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setup()
    setupTable()
    setupTopBars()
 
    interactor?.makeRequest(request: NewsFeed.Model.Request.RequestType.getNewsFeed)
    interactor?.makeRequest(request: NewsFeed.Model.Request.RequestType.getUser)
    setupTopBars()
  }
    
    private func setupTable() {
        let topInset : CGFloat = 8
        table.contentInset.top = topInset
        
        table.register(UINib(nibName: "NewsFeedCell", bundle: nil), forCellReuseIdentifier: NewsFeedCell.reuseID)
        table.register(NewsFeedCodeCell.self, forCellReuseIdentifier: "NewsFeedCodeCell")
        
        table.separatorStyle = .none
        table.backgroundColor = .clear
        
        table.addSubview(refreshControl)
        table.tableFooterView = footerView
        
    }
    
    private func setupTopBars() {
        let topBar = UIView(frame: UIApplication.shared.statusBarFrame)
        topBar.backgroundColor = UIColor(named: "backgroundColor")
        topBar.layer.shadowColor = UIColor.black.cgColor
        topBar.layer.shadowOpacity = 0.3
        topBar.layer.shadowOffset = CGSize.zero
        topBar.layer.shadowRadius = 8
        self.view.addSubview(topBar)
        
        self.navigationController?.hidesBarsOnSwipe = true
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationItem.titleView = titleView
    }
    
    @objc private func refresh() {
        interactor?.makeRequest(request: NewsFeed.Model.Request.RequestType.getNewsFeed)
    }
  
  func displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData) {
    switch viewModel {

    case .displayNewsFeed(let feedViewModel):
        self.feedViewModel = feedViewModel
        footerView.setTitle(feedViewModel.footerTitle)
        table.reloadData()
        refreshControl.endRefreshing()
    case .displayUser(let userViewModel):
        titleView.set(userViewModel: userViewModel)
    case .displayFooterLoader:
        footerView.showLoader()
    }
  }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.y > scrollView.contentSize.height / 1.1 {
            interactor?.makeRequest(request: NewsFeed.Model.Request.RequestType.getNextBatch)
        }
    }
    
    func revealPost(for cell: NewsFeedCodeCell) {
        print("54321")
        guard let indexPath = table.indexPath(for: cell) else { return }
        
        let cellViewModel = feedViewModel.cells[indexPath.row]
        
        interactor?.makeRequest(request: .revealPostIds(postID: cellViewModel.postId))
    }
}

extension NewsFeedViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedViewModel.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        /* Вариант ячейки через XIB файл */
        /*let cell = tableView.dequeueReusableCell(withIdentifier: NewsFeedCell.reuseID, for: indexPath) as! NewsFeedCell
        let cellViewModel = feedViewModel.cells[indexPath.row]
        cell.set(viewModel: cellViewModel)*/
        
        /* Вариант ячейчи полностью через код */
        
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsFeedCodeCell.reuseID, for: indexPath) as! NewsFeedCodeCell
        let cellViewModel = feedViewModel.cells[indexPath.row]
        cell.set(viewModel: cellViewModel)
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellViewModel = feedViewModel.cells[indexPath.row]
        return cellViewModel.sizes.totalHeight
//        return 212
        
    }    
}
