//
//  Voyage.swift
//  VoyageVoyages
//
//  Created by arthur jamelot on 05/02/2016.
//  Copyright © 2016 arthur jamelot et charles bordier. All rights reserved.
//

import Foundation



class Voyage {
    
    // MARK: - Private properties
    
    private var name: String?
    
    //MARK: - Public properties
    
    var nom: String? {
        get {return self.name}
        set {
            guard let unnom=newValue where !unnom.isEmpty else {
                self.name=nil
                return
            }
            self.name=newValue
            }
    }
    var lieux: LieuSet = LieuSet()
    
    // MARK: - Methods
    
    init(nom: String?) {
        self.nom = nom
    }
    
    
    /// Cette méthode ajoute un lieu dans le voyage et trie la liste des lieux selon la date de visite
    /// - Parameter endroit:Le lieu que l'on souhaite ajouter
    /// - Returns: Ne renvoie rien
    /// - Throws: EmptyLieu: Renvoie cette erreur si le lieu est vide ; LieuAlreadyPresent: Renvoie cette erreur si le lieu est déjà dans le voyage
    func ajouterLieu(endroit: Lieu) throws {
        do {
            try self.lieux.ajouterLieu(endroit)
            return
        } catch ErrorLieuSet.EmptyLieu {
            throw ErrorLieuSet.EmptyLieu
        }
        throw ErrorLieuSet.LieuAlreadyPresent
    }
    
    /// Cette méthode permet de retrouver l'index d'un lieu dans le voyage
    /// - Parameter endroit: Le lieu dont on cherche l'index
    /// - Returns: Entier, l'index du lieu
    /// - Throws: EmptyLieu si le lieu est vide, LieuNotInLieuSet si le lieu n'est pas dans le voyage
    func indexLieu(endroit: Lieu?) throws -> Int {
        var i : Int
        do {
            try i=self.lieux.indexLieu(endroit)
            return i
        } catch ErrorLieuSet.EmptyLieu {
            throw ErrorLieuSet.EmptyLieu
        } catch ErrorLieuSet.LieuNotInLieuSet {
            throw ErrorLieuSet.LieuNotInLieuSet
        }
        
    }
    
    func enleverLieuSelonLieu(endroit: Lieu?) {
        self.lieux.enleverLieuSelonLieu(endroit)
    }
    
    func enleverLieuSelonNom(nom: String?){
        self.lieux.enleverLieuSelonNom(nom)
    }
    
    func enleverLieuSelonDate(date: String?){
        self.lieux.enleverLieuSelonDate(date)
    }
}