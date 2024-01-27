//
//  ProductCell.swift
//  ProductProject
//
//  Created by Nidhi on 27/01/24.
//

import UIKit

class ProductCell: UITableViewCell {
    
    @IBOutlet weak var productBackgroundView: UIView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productCategory: UILabel!
    @IBOutlet weak var rateButton: UIButton!
    @IBOutlet weak var descriptionlbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    
    var product:Product? {
        
        didSet { //property Observer
            productDetailConfiguration()
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func productDetailConfiguration(){
        
        guard let product else { return }
        
        productTitle.text = product.title
        productCategory.text = product.category
        descriptionlbl.text = product.description
        priceLbl.text = "$\(product.price)"
        rateButton.setTitle("\(product.rating.rate)", for: .normal)
        productImage.setImage(with: product.image)
        
    }
    
}
