//
//  QuoteTableViewCell.swift
//  Technical-test
//
//  Created by Mykyta Kiriushyn on 11.04.2023.
//

import UIKit

class QuoteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var variationLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var readableLastLabel: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!
    var quote: Quote?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func configure(with quote: Quote) {
        self.quote = quote
        nameLabel.text = quote.name
        variationLabel.text = quote.last
        currencyLabel.text = quote.currency
        readableLastLabel.text = quote.formattedLastChangePercent
        readableLastLabel.textColor = UIColor(named: quote.variationColor ?? "")
        favouriteButton.setTitle("", for: .normal)
        if quote.isFavourite {
            favouriteButton.setImage(UIImage(named: "favorite"), for: .normal)
        } else {
            favouriteButton.setImage(UIImage(named: "no-favorite"), for: .normal)
        }
    }
    
    
    @IBAction func toggleFavourite(_ sender: Any) {
        self.quote?.isFavourite.toggle()
    }
}
