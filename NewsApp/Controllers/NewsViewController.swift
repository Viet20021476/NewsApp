//
//  NewsViewController.swift
//  NewsApp
//
//  Created by Nguyễn Duy Việt on 19/7/24.
//

import UIKit

class NewsViewController: UIViewController {
    
    @IBOutlet private weak var newsTableView: UITableView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var noNewsLabel: UILabel!
    private let newsViewModel = NewsViewModel()
    
    var filters: NewsFilters?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindViewModel()
        setupData()
        
    }
    
    private func setupView() {
        newsTableView.delegate = self
        newsTableView.dataSource = self
        newsTableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "NewsCell")
    }
    
    private func setupData() {
        Task {
            await fetchNews()
        }
    }
    
    private func bindViewModel() {
        newsViewModel.news.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.newsTableView.reloadData()
                self?.updateNoNewsLabelVisibility()
            }
        }
        
        newsViewModel.isLoading.bind { [weak self] isLoading in
            DispatchQueue.main.async {
                if isLoading {
                    self?.activityIndicator.startAnimating()
                    self?.activityIndicator.isHidden = false
                } else {
                    self?.activityIndicator.stopAnimating()
                    self?.activityIndicator.isHidden = true
                }
            }
        }
        
    }
    
    private func fetchNews() async {
        do {
            try await newsViewModel.fetchNews(
                categories: filters?.category,
                countries: filters?.country,
                languages: filters?.language,
                keywords: filters?.keyword,
                date: newsViewModel.createDateParams(fromDate: filters?.fromDate ?? "", toDate: filters?.toDate ?? ""),
                sort: filters?.sort
            )
        } catch {
            DispatchQueue.main.async {
                UIAlertController.showQuickSystemAlert(message: error.localizedDescription)
            }
        }
    }
    
    private func updateNoNewsLabelVisibility() {
        noNewsLabel.isHidden = !newsViewModel.news.value.isEmpty
    }
    
}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsViewModel.news.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as? NewsCell else {
            return UITableViewCell()
        }
        
        let news = newsViewModel.news.value[indexPath.row]
        cell.setupData(news: news)
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let news = newsViewModel.news.value[indexPath.row]
        guard let url = URL(string: news.url) else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == newsViewModel.news.value.count - 1 {
            guard !newsViewModel.isLoading.value else { return }
            Task {
                do {
                    try await newsViewModel.fetchNews(
                        categories: filters?.category,
                        countries: filters?.country,
                        languages: filters?.language,
                        keywords: filters?.keyword,
                        date: newsViewModel.createDateParams(fromDate: filters?.fromDate ?? "", toDate: filters?.toDate ?? ""),
                        sort: filters?.sort,
                        isPagination: true
                    )
                } catch {
                    DispatchQueue.main.async {
                        UIAlertController.showQuickSystemAlert(message: error.localizedDescription)
                    }
                }
            }
        }
    }
    
}
