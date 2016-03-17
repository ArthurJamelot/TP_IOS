//
//  LieuSet.swift
//  VoyageVoyages
//
//  Created by arthur jamelot on 29/02/2016.
//  Copyright © 2016 arthur jamelot et charles bordier. All rights reserved.
//

import Foundation

enum ErrorLieuSet: ErrorType {
    case EmptyLieu
    case LieuAlreadyPresent
    case LieuNotInLieuSet
}

class LieuSet {
    var lieux = [Lieu]()
    
    init() {}
    
    /// Cette méthode ajoute un lieu dans le voyage et trie la liste des lieux selon la date de visite
    /// - Parameter endroit:Le lieu que l'on souhaite ajouter
    /// - Returns: Ne renvoie rien
    /// - Throws: EmptyLieu: Renvoie cette erreur si le lieu est vide ; LieuAlreadyPresent: Renvoie cette erreur si le lieu est déjà dans le voyage
    func ajouterLieu(endroit: Lieu) throws {
        do {
            try indexLieu(endroit)
        } catch ErrorLieuSet.EmptyLieu {
            throw ErrorLieuSet.EmptyLieu
        } catch ErrorLieuSet.LieuNotInLieuSet {
            self.lieux.append(endroit)
            self.lieux.sortInPlace({
                (l1: Lieu, l2: Lieu) -> Bool in
                return l1.dateLieu > l2.dateLieu
            })
            return
        }
        throw ErrorLieuSet.LieuAlreadyPresent
    }
    
    /// Cette méthode permet de retrouver l'index d'un lieu dans le voyage
    /// - Parameter endroit: Le lieu dont on cherche l'index
    /// - Returns: Entier, l'index du lieu
    /// - Throws: EmptyLieu si le lieu est vide, LieuNotInLieuSet si le lieu n'est pas dans le voyage
    func indexLieu(endroit: Lieu?) throws -> Int {
        guard let li=endroit else {
            throw ErrorLieuSet.EmptyLieu
        }
        for (i, l) in self.lieux.enumerate() {
            if (l.nameLieu == li.nameLieu && l.dateLieu == li.dateLieu) {
                return i
            }
        }
        throw ErrorLieuSet.LieuNotInLieuSet
    }
    
    func enleverLieuSelonLieu(endroit: Lieu?) {
        guard let place = endroit else {
            return
        }
        var i: Int
        do {
            try i=self.indexLieu(place)
        } catch {
            return
        }
        lieux.removeAtIndex(i)
    }
    
    func enleverLieuSelonNom(nom: String?){
        guard let name = nom where !name.isEmpty else {
            return
        }
        var toRemove = [Int]()
        for (i, l) in self.lieux.enumerate() {
            if (l.nameLieu == name) {
                toRemove.append(i)
            }
        }
        while (!toRemove.isEmpty) {
            self.lieux.removeAtIndex(toRemove.removeAtIndex(toRemove.count-1))
        }
    }
    
    func enleverLieuSelonDate(date: String?){
        guard let time = date else {
            return
        }
        var toRemove = [Int]()
        for (i, l) in self.lieux.enumerate() {
            if (l.dateLieu == time) {
                toRemove.append(i)
            }
        }
        while (!toRemove.isEmpty) {
            self.lieux.removeAtIndex(toRemove.removeAtIndex(toRemove.count-1))
        }
    }

}