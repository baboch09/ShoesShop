//
// Shoes.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public struct Shoes: Codable, JSONEncodable, Hashable {

    public var id: Int64?
    public var name: String?
    public var desc: String?
    public var img: String?
    public var size: Int64?
    public var price: Double?
    public var brand: String?
    public var rating: String?

    public init(id: Int64? = nil, name: String? = nil, desc: String? = nil, img: String? = nil, size: Int64? = nil, price: Double? = nil, brand: String? = nil, rating: String? = nil) {
        self.id = id
        self.name = name
        self.desc = desc
        self.img = img
        self.size = size
        self.price = price
        self.brand = brand
        self.rating = rating
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case id
        case name
        case desc
        case img
        case size
        case price
        case brand
        case rating
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(desc, forKey: .desc)
        try container.encodeIfPresent(img, forKey: .img)
        try container.encodeIfPresent(size, forKey: .size)
        try container.encodeIfPresent(price, forKey: .price)
        try container.encodeIfPresent(brand, forKey: .brand)
        try container.encodeIfPresent(rating, forKey: .rating)
    }
}

