//
//  Quote.swift
//  Technical-test
//
//  Created by Patrice MIAKASSISSA on 29.04.21.
//

import Foundation

struct Quote: Codable, Equatable {
    var symbol: String?
    var name: String?
    var currency: String?
    var readableLastChangePercent: String?
    var last: String?
    var variationColor: String?
    var isFavourite: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case symbol
        case name
        case currency
        case readableLastChangePercent = "readable_last_change_percent"
        case last
        case variationColor = "variation_color"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.symbol = try container.decodeIfPresent(String.self, forKey: .symbol) ?? ""
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        self.currency = try container.decodeIfPresent(String.self, forKey: .currency) ?? ""
        self.readableLastChangePercent = try container.decodeIfPresent(String.self, forKey: .readableLastChangePercent) ?? ""
        self.last = try container.decodeIfPresent(String.self, forKey: .last) ?? ""
        self.variationColor = try container.decodeIfPresent(String.self, forKey: .variationColor) ?? ""
    }
    
    var formattedLastChangePercent: String {
            if let percent = readableLastChangePercent{
                let formattedPercent = String(format: "%.2f", Double(percent) ?? 0.0)
                return "\(formattedPercent)%"
            } else {
                return ""
            }
        }
}
