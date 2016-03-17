//
//  Voyages.swift
//  VoyageVoyages
//
//  Created by arthur jamelot on 05/02/2016.
//  Copyright © 2016 arthur jamelot et charles bordier. All rights reserved.
//

import Foundation

enum ErrorVoyages: ErrorType {
    case EmptyVoyage
    case VoyageAlreadyPresent
    case NotExistsVoyage
    case VoyageNotInVoyages
    case IndexOutOfBonds
}

class Voyages {
    var tableau = [Voyage]()
    
    init() {
    }
    
    func ajouter(voyage: Voyage?) throws {
        do {
            try index(voyage)
        } catch ErrorVoyages.EmptyVoyage {
            throw ErrorVoyages.EmptyVoyage
        } catch ErrorVoyages.VoyageNotInVoyages {
            self.tableau.append(voyage!)
            self.tableau.sortInPlace({
                (v1: Voyage, v2: Voyage) -> Bool in
                return v1.nom < v2.nom
            })
            return
        }
        throw ErrorVoyages.VoyageAlreadyPresent
    }

    func index(voyage: Voyage?) throws -> Int {
        guard let vo=voyage else {
            throw ErrorVoyages.EmptyVoyage
        }
        for (i, v) in self.tableau.enumerate() {
            if (v.nom == vo.nom) {
                return i
            }
        }
        throw ErrorVoyages.VoyageNotInVoyages
    }
    
    func position(pos: Int) throws -> Voyage {
        if (pos < tableau.endIndex && pos>=0) {
            return self.tableau[pos]
        } else {
            throw ErrorVoyages.IndexOutOfBonds
        }
    }
    
    
}