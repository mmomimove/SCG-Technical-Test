//
//  SecondPageViewController.swift
//  scg do test
//
//  Created by MmoMiMove on 19/1/2566 BE.
//

import UIKit

class SecondPageViewController: UIViewController {
    
    // MARK: - New Instance
    class func newInstance(data: NewsModel?) -> SecondPageViewController {
        let viewController = SecondPageViewController(nibName: "SecondPageViewController",
                                         bundle: nil)
        
        let viewModel = SecondPageViewModel(delegate: viewController,
                                            data: data)
        viewController.viewModel = viewModel
        
        return viewController
    }
    
    // MARK: - IBOutlet
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblContent: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblLink: UILabel!
    
    // MARK: - Parameters
    private var viewModel: SecondPageViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupView()
        self.setupNavigationBar()
    }
    
    // MARK: - Function
    func setupView() {
        
        self.lblLink.text = "Read More Click"
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.onClicLabel(sender:)))
        self.lblLink.isUserInteractionEnabled = true
        self.lblLink.addGestureRecognizer(tap)
        
        self.imageView.contentMode = .scaleToFill
        self.lblTitle.text = self.viewModel?.data?.title
        self.lblContent.text = self.viewModel?.data?.content
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "MMM d, HH:mm"
        self.lblDate.text = "Updated: \(dateFormatterGet.string(from: self.viewModel?.data?.publishedAt ?? Date()))"
        
        guard let url = self.viewModel?.data?.urlToImage else { return }
        DispatchQueue.main.async {
            if let data = try? Data(contentsOf: url) {
                let image: UIImage = UIImage(data: data)!
                self.imageView.image = image
            }
        }
    }
    
    func setupNavigationBar() {
        let navItem = UINavigationItem()
        let leftBtn = UIBarButtonItem(title: "back",
                                       style: .done,
                                       target: self,
                                       action: #selector(dismissView))
        
        

        navItem.title = "Details"
        navItem.leftBarButtonItem = leftBtn
        self.navigationBar.setItems([navItem], animated: false)
    }

    @objc func dismissView() {
        self.dismiss(animated: true)
    }
    
    @objc func onClicLabel(sender:UITapGestureRecognizer) {
        let url = self.viewModel?.data?.url
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url!)
        }
    }

}

extension SecondPageViewController: SecondPageViewModelDelegate {
    
}
