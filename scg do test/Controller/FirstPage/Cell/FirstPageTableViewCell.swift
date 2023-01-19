//
//  FirstPageTableViewCell.swift
//  scg do test
//
//  Created by MmoMiMove on 19/1/2566 BE.
//

import UIKit

class FirstPageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.imgView.contentMode = .scaleToFill
        self.imgView.layer.cornerRadius = 10
        self.imgView.clipsToBounds = true
    }

    func setData(data: NewsModel?) {
        self.lblTitle.text = data?.title
        self.lblDescription.text = data?.description
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "MMM d, HH:mm"
        self.lblDate.text = "Updated: \(dateFormatterGet.string(from: data?.publishedAt ?? Date()))"
        
        guard let url = data?.urlToImage else { return }
        DispatchQueue.main.async {
            if let data = try? Data(contentsOf: url) {
                let image: UIImage = UIImage(data: data)!
                self.imgView.image = image
            }
        }
    }
    
}
