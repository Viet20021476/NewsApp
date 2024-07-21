//
//  FiltersViewcontroller.swift
//  NewsApp
//
//  Created by Nguyễn Duy Việt on 20/7/24.
//

import UIKit

class FiltersViewcontroller: UIViewController {
    
    @IBOutlet weak var keywordTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var languageTextField: UITextField!
    @IBOutlet weak var fromDateTextField: UITextField!
    @IBOutlet weak var toDateTextField: UITextField!
    @IBOutlet weak var sortTextField: UITextField!
    @IBOutlet weak var addCategoryButton: UIButton!
    @IBOutlet weak var addCountryButton: UIButton!
    @IBOutlet weak var addLanguageButton: UIButton!
    @IBOutlet weak var addSortButton: UIButton!
    
    var fromDatePicker = UIDatePicker()
    var toDatePicker = UIDatePicker()
    
    var viewModel = FiltersViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupView()
        bindViewModel()
    }
    
    private func setupView() {
        let categoryMenuHandler = { [weak self] (action: UIAction) in
            guard let wSelf = self else { return }
            wSelf.viewModel.category.value = action.title
        }
        
        let countryMenuHandler = { [weak self] (action: UIAction) in
            guard let wSelf = self else { return }
            wSelf.viewModel.country.value = action.title
        }
        
        let languageMenuHandler = { [weak self] (action: UIAction) in
            guard let wSelf = self else { return }
            wSelf.viewModel.language.value = action.title
        }
        
        let sortMenuHandler = { [weak self] (action: UIAction) in
            guard let wSelf = self else { return }
            wSelf.viewModel.sort.value = action.title
        }
        
        addCategoryButton.menu = UIMenu(children: viewModel.categories.map { category in
            UIAction(title: category, handler: categoryMenuHandler)
        })
        
        addCountryButton.menu = UIMenu(children: viewModel.countries.map { country in
            UIAction(title: country.key, handler: countryMenuHandler)
        })
        
        addLanguageButton.menu = UIMenu(children: viewModel.languages.map { lang in
            UIAction(title: lang.key, handler: languageMenuHandler)
        })
        
        addSortButton.menu = UIMenu(children: viewModel.sorts.map { sort in
            UIAction(title: sort, handler: sortMenuHandler)
        })
        
        
        fromDatePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 200))
        fromDatePicker.addTarget(self, action: #selector(self.fromDateChanged), for: .allEvents)
        fromDatePicker.preferredDatePickerStyle = .wheels
        fromDatePicker.maximumDate = Date()
        
        toDatePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 200))
        toDatePicker.addTarget(self, action: #selector(self.toDateChanged), for: .valueChanged)
        toDatePicker.preferredDatePickerStyle = .wheels
        toDatePicker.maximumDate = Date()
        
        fromDateTextField.inputView = fromDatePicker
        toDateTextField.inputView = toDatePicker
        
        let doneButton = UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(self.datePickerDone))
        let toolBar = UIToolbar.init(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 44))
        toolBar.setItems([UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil), doneButton], animated: true)
        
        fromDateTextField.inputAccessoryView = toolBar
        toDateTextField.inputAccessoryView = toolBar
        
        
        hideKeyboard()
    }
    
    private func bindViewModel() {
        viewModel.category.bind { [weak self] in self?.categoryTextField.text = $0 }
        viewModel.country.bind { [weak self] in self?.countryTextField.text = $0 }
        viewModel.language.bind { [weak self] in self?.languageTextField.text = $0 }
        viewModel.fromDate.bind { [weak self] in self?.fromDateTextField.text = $0 }
        viewModel.toDate.bind { [weak self] in self?.toDateTextField.text = $0 }
        viewModel.sort.bind { [weak self] in self?.sortTextField.text = $0 }
    }
    
    @objc func datePickerDone() {
        fromDateTextField.resignFirstResponder()
        toDateTextField.resignFirstResponder()
    }
    
    @objc func fromDateChanged() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        fromDateTextField.text = dateFormatter.string(from: fromDatePicker.date)
    }
    
    @objc func toDateChanged() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        toDateTextField.text = dateFormatter.string(from: toDatePicker.date)
    }
    
    @IBAction func didTapOnSearch(_ sender: Any) {
        viewModel.keyword.value = self.keywordTextField.text ?? ""
        viewModel.category.value = self.categoryTextField.text ?? ""
        viewModel.country.value = self.countryTextField.text ?? ""
        viewModel.language.value = self.languageTextField.text ?? ""
        viewModel.fromDate.value = self.fromDateTextField.text ?? ""
        viewModel.toDate.value = self.toDateTextField.text ?? ""
        viewModel.sort.value = self.sortTextField.text ?? ""
        
        if viewModel.validateInputs() {
            let filters = NewsFilters(
                keyword: viewModel.keyword.value,
                category: viewModel.category.value,
                country: viewModel.countries["\(viewModel.country.value)"] ?? "",
                language: viewModel.languages["\(viewModel.language.value)"] ?? "",
                fromDate: viewModel.fromDate.value,
                toDate: viewModel.toDate.value,
                sort: viewModel.sort.value
            )
            
            let vc = NewsViewController()
            vc.filters = filters
            navigationController?.pushViewController(vc, animated: true)
        } else {
            UIAlertController.showQuickSystemAlert(message: "Some inputs are not valid")
        }
        
    }
}

