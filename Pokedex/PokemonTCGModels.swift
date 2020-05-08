//
//  PokemonTCGModels.swift
//  Pokedex
//
//  Created by Jarrod Parkes on 5/8/20.
//  Copyright © 2020 Spur. All rights reserved.
//

import Foundation

// MARK: - CardsResponse
struct CardsResponse: Codable {
    let cards: [Card]
}

// MARK: - Card
struct Card: Codable {
    let id, name: String
//    let nationalPokedexNumber: Int?
//    let imageURL, imageURLHiRes: String
//    let types: [RetreatCost]
//    let supertype: Supertype
//    let subtype: String
//    let hp: String?
//    let retreatCost: [RetreatCost]?
//    let convertedRetreatCost: Int?
//    let number: String
//    let artist: String?
//    let rarity: Rarity?
//    let series: Series
//    let cardSet, setCode: String
//    let attacks: [Attack]?
//    let weaknesses: [Resistance]?
//    let evolvesFrom: String?
//    let ability: Ability?
//    let text: [String]?
//    let resistances: [Resistance]?
//    let ancientTrait: AncientTrait?

    enum CodingKeys: String, CodingKey {
        case id, name
        // case nationalPokedexNumber
//        case imageURL = "imageUrl"
//        case imageURLHiRes = "imageUrlHiRes"
//        case types, supertype, subtype, hp, retreatCost, convertedRetreatCost, number, artist, rarity, series
//        case cardSet = "set"
//        case setCode, attacks, weaknesses, evolvesFrom, ability, text, resistances, ancientTrait
    }
}

enum Series: String, Codable {
    case base = "Base"
    case blackWhite = "Black & White"
    case diamondPearl = "Diamond & Pearl"
    case ex = "EX"
    case gym = "Gym"
    case heartGoldSoulSilver = "HeartGold & SoulSilver"
    case sunMoon = "Sun & Moon"
    case swordShield = "Sword & Shield"
    case xy = "XY"
    case platinum = "Platinum"
    case bw = "BW"
    case eCard = "E-Card"
    case pop = "POP"
}

// MARK: - Ability
struct Ability: Codable {
    let name, text: String
    let type: TypeEnum
}

enum TypeEnum: String, Codable {
    case ability = "Ability"
    case pokéBody = "Poké-Body"
    case pokéPower = "Poké-Power"
}

// MARK: - AncientTrait
struct AncientTrait: Codable {
    let name, text: String
}

// MARK: - Attack
struct Attack: Codable {
    let cost: [RetreatCost]
    let name, text, damage: String
    let convertedEnergyCost: Int
}

enum RetreatCost: String, Codable {
    case colorless = "Colorless"
    case fighting = "Fighting"
    case fire = "Fire"
    case free = "Free"
    case lightning = "Lightning"
    case metal = "Metal"
    case psychic = "Psychic"
    case water = "Water"
    case grass = "Grass"
}

enum Rarity: String, Codable {
    case common = "Common"
    case legend = "LEGEND"
    case rare = "Rare"
    case rareHolo = "Rare Holo"
    case rareHoloEX = "Rare Holo EX"
    case rareHoloLVX = "Rare Holo Lv.X"
    case rareSecret = "Rare Secret"
    case rareUltra = "Rare Ultra"
    case uncommon = "Uncommon"
    case rareHoloGX = "Rare Holo GX"
    case empty = ""
}

// MARK: - Resistance
struct Resistance: Codable {
    let type: PokemonType
    let value: String
}

enum PokemonType: String, Codable {
    case colorless = "Colorless"
    case fighting = "Fighting"
    case fire = "Fire"
    case free = "Free"
    case lightning = "Lightning"
    case metal = "Metal"
    case psychic = "Psychic"
    case water = "Water"
    case grass = "Grass"
}

enum Supertype: String, Codable {
    case pokémon = "Pokémon"
}
