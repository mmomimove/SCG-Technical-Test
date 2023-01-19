//
//  FirstPageViewController.swift
//  scg do test
//
//  Created by MmoMiMove on 19/1/2566 BE.
//

import UIKit
import IQKeyboardManagerSwift

class FirstPageViewController: UIViewController {
    
    // MARK: - New Instance
    class func newInstance() -> FirstPageViewController {
        let viewController = FirstPageViewController(nibName: "FirstPageViewController",
                                         bundle: nil)
        
        let viewModel = FirstPageViewModel(delegate: viewController)
        viewController.viewModel = viewModel
        
        return viewController
    }
    
    // MARK: - IBOutlet
    @IBOutlet weak var tfSearch: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblSearchNotFound: UILabel!
    
    // MARK: - Parameters
    private var viewModel: FirstPageViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupView()
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
        // MARK: - Default Data
        self.viewModel?.getSearchData(searchText: "apple")
        self.viewModel?.textSearch = "apple"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        IQKeyboardManager.shared.enable = false
    }
    
    // MARK: - Function
    func setupView() {
        self.lblSearchNotFound.isHidden = true
        
        self.tfSearch.delegate = self
        self.tfSearch.attributedPlaceholder = NSAttributedString(
            string: "Search",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        )
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(UINib(nibName: "FirstPageTableViewCell", bundle: nil),
                                forCellReuseIdentifier: "FirstPageTableViewCell")
        
    }
    


}

extension FirstPageViewController: UITableViewDataSource,
                                    UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.viewModel?.data.count == 0 {
            return 0
        } else {
            return self.viewModel?.data.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FirstPageTableViewCell.self), for: indexPath) as? FirstPageTableViewCell {
            cell.selectionStyle = .none
            cell.setData(data: self.viewModel?.data[indexPath.row])
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = SecondPageViewController.newInstance(data: self.viewModel?.data[indexPath.row])
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }

}

extension FirstPageViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let text = textField.text ?? ""
        
        if !text.isEmpty {
            self.viewModel?.getSearchData(searchText: text)
        }
        
        self.viewModel?.textSearch = text
        
        view.endEditing(true)
        
        return true
    }
        
}

extension FirstPageViewController: FirstPageViewModelDelegate {
    func reloadData() {
        if self.viewModel?.data.count == 0 {
            self.lblSearchNotFound.isHidden = false
        } else {
            self.lblSearchNotFound.isHidden = true
        }
        
        self.tableView.reloadData()
    }
    
}
