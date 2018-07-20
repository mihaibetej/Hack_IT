//
//  ContactsDataSource.swift
//  TBD
//
//  Created by Emanuel Jarnea on 20/07/2018.
//  Copyright © 2018 Shivering Singletons. All rights reserved.
//

import Foundation

class ContactsDataSource {
    private(set) var allContacts: [String: [Contact]] = [:]
    private(set) var nearbyContacts: [(contact: Contact, distance: Int)] = []
    
    static let instance = ContactsDataSource()
    
    private init() {
        
        let names = [
            "Luke Hill",
            "Alicia Valdez",
            "Ashley Sanders",
            "Stacy Guerrero",
            "Hubert Cortez",
            "Virgil Harvey",
            "Ruth Reese",
            "Michelle Nichols",
            "Kerry Myers",
            "Candice Scott",
            "Lucas Banks",
            "Rochelle Steele",
            "Terrance Newton",
            "Glenda Dixon",
            "Alexander Hammond",
            "Traci Horton",
            "Doreen Cooper",
            "Loren Knight",
            "Albert Mccoy",
            "Candace Hines",
            "Heidi Wagner",
            "Cornelius Moreno",
            "Lydia Fox",
            "Jerome Wilson",
            "Lorena Medina",
            "Alejandro Stanley",
            "April Hart",
            "Susie Ryan",
            "Carla Munoz",
            "Woodrow Guzman",
            "Marlene Foster",
            "Rudolph Tate",
            "Cary Sutton",
            "Ian Reid",
            "Sabrina Salazar",
            "Leland Gilbert",
            "Jean Flores",
            "Jennifer Patrick",
            "Bonnie Powers",
            "Marianne Dennis",
            "Jean Vasquez",
            "Lela Dean",
            "Jackie Moody",
            "Charlie Rodriquez",
            "Carolyn Abbott",
            "Blake Becker",
            "Erica Kelley",
            "Nettie Wong",
            "Kim Drake",
            "Alexandra West",
            ]
        
        let contacts = names.sorted().map {Contact(name: $0)}
        nearbyContacts = nearby(contacts: contacts, farLimit: 10_000)
        
        allContacts =  contacts.reduce([String: [Contact]]()) { (dict, contact) -> [String: [Contact]] in
            var dict = dict
            let letter = String(contact.fullname.prefix(1))
            var existing = dict[letter] ?? []
            existing.append(contact)
            dict[letter] = existing
            return dict
        }

    }
    
    private func nearby(contacts: [Contact], farLimit: Int) -> [(contact: Contact, distance: Int)] {
        var paired = contacts.map { (contact: $0, distance: Int(arc4random_uniform(50000) + 50)) }
        paired[0] = (contact: paired[0].contact, distance: 5000) //make sure there's always at least one contact
        let filtered = paired.filter {$0.distance < farLimit}
        let sorted = filtered.sorted {$0.distance < $1.distance}
        return sorted
    }
}
