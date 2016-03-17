//
//  VoyageVoyagesTests.swift
//  VoyageVoyagesTests
//
//  Created by arthur jamelot on 05/02/2016.
//  Copyright © 2016 arthur jamelot et charles bordier. All rights reserved.
//

import XCTest
@testable import VoyageVoyages

class VoyageVoyagesTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testInitVoyage() {
        let voy: Voyage = Voyage(nom: "")
        XCTAssertNil(voy.nom, "Erreur, le voyage devrait etre vide !")
        voy.nom="a"
        XCTAssertNotNil(voy.nom, "Le nom devrait etre a")
        XCTAssertEqual(voy.nom, "a", "Le nom devrait etre a")
    }
    
    func testInitVoyages() {
        let _: Voyages = Voyages()
    }
    
    func testInitLieu() {
        let testLieu: Lieu
        testLieu = Lieu(nomLieu: "", date: "")
        XCTAssertNil(testLieu.dateLieu, "Erreur, la date devrait être vide")
        XCTAssertNil(testLieu.nameLieu, "Erreur, le nom devrait être vide")
        testLieu.nameLieu="a"
        testLieu.dateLieu="1995/04/30"
        XCTAssertNotNil(testLieu.nameLieu, "Erreur, il devrait y avoir un nom")
        XCTAssertNotNil(testLieu.dateLieu, "Erreur, il devrait y avoir une date")
        XCTAssertEqual(testLieu.nameLieu, "a", "Erreur, le nom devrait être a")
        XCTAssertEqual(testLieu.dateLieu, "1995/04/30", "Erreur, la date devrait être la veille du 1er mai")
    }
    
    func testAjouterVoyages() {
        var voys: Voyages = Voyages()
        let voy1: Voyage = Voyage(nom: "b")
        do {
            try voys.ajouter(voy1)
        } catch ErrorVoyages.EmptyVoyage {
            XCTFail("Le voyage ne devrait pas etre vide")
        } catch ErrorVoyages.VoyageAlreadyPresent {
            XCTFail("Le voyage ne devrait pas etre deja present")
        } catch let error {
            XCTFail("\(error)")
        }
        do {
            try voys.ajouter(voy1)
            XCTFail("Le voyage ne devrait pas pouvoir être ajouté voyons")
        } catch ErrorVoyages.EmptyVoyage {
            XCTFail("Le voyage ne devrait pas etre vide")
        } catch ErrorVoyages.VoyageAlreadyPresent {
        } catch let error {
            XCTFail("\(error)")
        }
    }
    
    func testIndexVoyages() {
        let voy1, voy3 : Voyage
        voy1 = Voyage(nom: "a")
        voy3 = Voyage(nom: "c")
        var x: Int;
        var voys: Voyages = Voyages()
        do {
            try voys.ajouter(voy1)
        } catch ErrorVoyages.EmptyVoyage {
            XCTFail("Le voyage ne devrait pas etre vide")
        } catch ErrorVoyages.VoyageAlreadyPresent {
            XCTFail("Le voyage ne devrait pas etre deja present")
        } catch let error {
            XCTFail("\(error)")
        }
        do {
            try x=voys.index(voy1)
            XCTAssertEqual(x, 0, "Erreur, l'index devrait etre 0")
        } catch ErrorVoyages.EmptyVoyage {
            XCTFail("Le voyage ne devrait pas etre vide")
        } catch ErrorVoyages.VoyageNotInVoyages {
            XCTFail("Le voyage devrait etre dans la liste")
        } catch let error {
            XCTFail("\(error)")
        }
        do {
            try x=voys.index(voy3)
            XCTFail("Comment fais-tu pour trouver un voyage qui n'est pas dans la liste des voyages ?")
        } catch ErrorVoyages.EmptyVoyage {
            XCTFail("Le voyage ne devrait pas etre vide")
        } catch ErrorVoyages.VoyageNotInVoyages {
        } catch let error {
            XCTFail("\(error)")
        }
        do {
            try x=voys.index(nil)
        } catch ErrorVoyages.EmptyVoyage {
        } catch let error {
            XCTFail("\(error)")
        }
    }
    
    func testPositionVoyages() {
        let voy2, voy3, voy4 : Voyage
        voy2 = Voyage(nom: "b")
        voy3 = Voyage(nom: "c")
        var voys: Voyages = Voyages()
        do {
            try voys.ajouter(voy2)
        } catch ErrorVoyages.EmptyVoyage {
            XCTFail("Le voyage ne devrait pas etre vide")
        } catch ErrorVoyages.VoyageAlreadyPresent {
            XCTFail("Le voyage ne devrait pas etre deja present")
        } catch let error {
            XCTFail("\(error)")
        }
        do {
            try voys.ajouter(voy3)
        } catch ErrorVoyages.EmptyVoyage {
            XCTFail("Le voyage ne devrait pas etre vide")
        } catch ErrorVoyages.VoyageAlreadyPresent {
            XCTFail("Le voyage ne devrait pas etre deja present")
        } catch let error {
            XCTFail("\(error)")
        }
        do {
            try voy4 = voys.position(0)
            XCTAssertEqual(voy4.nom, voy2.nom, "Erreur, les noms devraient etre egaux")
        } catch ErrorVoyages.IndexOutOfBonds {
            XCTFail("Erreur, l'index devrait etre dans le tableau")
        } catch let error {
            XCTFail("\(error)")
        }
    }
    
    func testAjouterLieuLieuSet() {
        let lieux = LieuSet()
        let end1 = Lieu(nomLieu: "a", date: "2016/02/04")
        do {
            try lieux.ajouterLieu(end1)
        } catch ErrorLieuSet.LieuAlreadyPresent {
            XCTFail("Le LieuSet était vide, normalement")
        } catch ErrorLieuSet.EmptyLieu {
            XCTFail("Le lieu n'est pas vide, pourtant")
        } catch {
            XCTFail("\(error)")
        }
        do {
            try lieux.ajouterLieu(end1)
            XCTFail("Le lieu était pourtant déjà présent")
        } catch ErrorLieuSet.LieuAlreadyPresent {
        } catch ErrorLieuSet.EmptyLieu {
            XCTFail("Le lieu n'est pas vide, pourtant")
        } catch {
            XCTFail("\(error)")
        }
    }
    
    func testAjouterLieuVoyage() {
        let voy = Voyage(nom: "a")
        let endroit = Lieu(nomLieu: "u.u", date: "2016/02/24")
        do {
            try voy.ajouterLieu(endroit)
        } catch ErrorLieuSet.EmptyLieu {
            XCTFail("Le lieu n'est pourtant pas vide voyons !")
        } catch ErrorLieuSet.LieuAlreadyPresent {
            XCTFail("Le voyage était pourtant vide voyons !")
        } catch let error {
            XCTFail("\(error)")
        }
        do {
            try voy.ajouterLieu(endroit)
            XCTFail("Le lieu était pourtant déjà dans le voyage !")
        } catch ErrorLieuSet.EmptyLieu {
            XCTFail("Le lieu n'est pourtant pas vide voyons !")
        } catch ErrorLieuSet.LieuAlreadyPresent {
        } catch let error {
            XCTFail("\(error)")
        }
    }
    
    func testIndexLieuLieuSet() {
        let lieuSet = LieuSet()
        let lieu1 = Lieu(nomLieu: "Le lit", date: "2016/02/24")
        let lieu2 = Lieu(nomLieu: "Sous la couette", date: "2016/02/24")
        do {
            try lieuSet.ajouterLieu(lieu1)
        } catch ErrorLieuSet.LieuAlreadyPresent {
            XCTFail("Le LieuSet était vide, normalement")
        } catch ErrorLieuSet.EmptyLieu {
            XCTFail("Le lieu n'est pas vide, pourtant")
        } catch {
            XCTFail("\(error)")
        }
        do {
            try lieuSet.indexLieu(lieu1)
        } catch ErrorLieuSet.EmptyLieu {
            XCTFail("Le lieu n'est pas vide")
        } catch ErrorLieuSet.LieuNotInLieuSet {
            XCTFail("Le lieu est dans le voyage")
        } catch let error {
            XCTFail("\(error)")
        }
        do {
            try lieuSet.indexLieu(lieu2)
            XCTFail("On ne devrait pas trouver la couette, pourtant")
        } catch ErrorLieuSet.EmptyLieu {
            XCTFail("Le lieu n'est pas vide")
        } catch ErrorLieuSet.LieuNotInLieuSet {
        } catch let error {
            XCTFail("\(error)")
        }

    }
    
    func testIndexVoyage() {
        let voy = Voyage(nom: "La fatigue")
        let lieu1 = Lieu(nomLieu: "Le lit", date: "2016/02/24")
        let lieu2 = Lieu(nomLieu: "Sous la couette", date: "2016/02/24")
        do {
            try voy.ajouterLieu(lieu1)
        } catch ErrorLieuSet.EmptyLieu {
            XCTFail("Le lieu n'est pourtant pas vide voyons !")
        } catch ErrorLieuSet.LieuAlreadyPresent {
            XCTFail("Le voyage était pourtant vide voyons !")
        } catch let error {
            XCTFail("\(error)")
        }
        do {
            try voy.indexLieu(lieu1)
        } catch ErrorLieuSet.EmptyLieu {
            XCTFail("Le lieu n'est pas vide")
        } catch ErrorLieuSet.LieuNotInLieuSet {
            XCTFail("Le lieu est dans le voyage")
        } catch let error {
            XCTFail("\(error)")
        }
        do {
            try voy.indexLieu(lieu2)
            XCTFail("On ne devrait pas trouver la couette, pourtant")
        } catch ErrorLieuSet.EmptyLieu {
            XCTFail("Le lieu n'est pas vide")
        } catch ErrorLieuSet.LieuNotInLieuSet {
        } catch let error {
            XCTFail("\(error)")
        }
    }
    
    func testSupprimerLieuSelonLieuLieuSet() {
        let lieuSet = LieuSet()
        let lieu1 = Lieu(nomLieu: "Le lit", date: "2016/02/24")
        do {
            try lieuSet.ajouterLieu(lieu1)
        } catch let error {
            XCTFail("\(error)")
        }
        lieuSet.enleverLieuSelonLieu(lieu1)
        do {
            try lieuSet.indexLieu(lieu1)
            XCTFail("L'index ne devrait pas être trouvable")
        } catch ErrorLieuSet.EmptyLieu {
            XCTFail("Le lieu n'était pas vide lors de l'insertion, pourquoi maintenant alors ?")
        } catch ErrorLieuSet.LieuNotInLieuSet {
        } catch let error {
            XCTFail("\(error)")
        }
    }
    
    func testSupprimerLieuSelonNomLieuSet() {
        let lieuSet = LieuSet()
        let lieu1 = Lieu(nomLieu: "Le lit", date: "2016/02/24")
        let lieu2 = Lieu(nomLieu: "Le lit", date: "2016/02/25")
        let lieu3 = Lieu(nomLieu: "Les lits", date: "2016/02/26")
        do {
            try lieuSet.ajouterLieu(lieu1)
        } catch let error {
            XCTFail("\(error)")
        }
        do {
            try lieuSet.ajouterLieu(lieu2)
        } catch let error {
            XCTFail("\(error)")
        }
        do {
            try lieuSet.ajouterLieu(lieu3)
        } catch let error {
            XCTFail("\(error)")
        }
        lieuSet.enleverLieuSelonNom("Le lit")
        do {
            try lieuSet.indexLieu(lieu1)
            XCTFail("L'index ne devrait pas être trouvable")
        } catch ErrorLieuSet.EmptyLieu {
            XCTFail("Le lieu n'était pas vide lors de l'insertion, pourquoi maintenant alors ?")
        } catch ErrorLieuSet.LieuNotInLieuSet {
        } catch let error {
            XCTFail("\(error)")
        }
        do {
            try lieuSet.indexLieu(lieu2)
            XCTFail("L'index ne devrait pas être trouvable")
        } catch ErrorLieuSet.EmptyLieu {
            XCTFail("Le lieu n'était pas vide lors de l'insertion, pourquoi maintenant alors ?")
        } catch ErrorLieuSet.LieuNotInLieuSet {
        } catch let error {
            XCTFail("\(error)")
        }
        do {
            try lieuSet.indexLieu(lieu3)
        } catch ErrorLieuSet.EmptyLieu {
            XCTFail("Le lieu n'était pas vide lors de l'insertion, pourquoi maintenant alors ?")
        } catch ErrorLieuSet.LieuNotInLieuSet {
            XCTFail("Erreur, le lieu devrait être dans le LieuSet")
        } catch let error {
            XCTFail("\(error)")
        }
    }
    
    func testSupprimerLieuSelonDateLieuSet() {
        let lieuSet = LieuSet()
        let lieu1 = Lieu(nomLieu: "Le lit", date: "2016/02/24")
        let lieu2 = Lieu(nomLieu: "La couette", date: "2016/02/24")
        let lieu3 = Lieu(nomLieu: "L'oreiller", date: "2016/02/26")
        do {
            try lieuSet.ajouterLieu(lieu1)
        } catch let error {
            XCTFail("\(error)")
        }
        do {
            try lieuSet.ajouterLieu(lieu2)
        } catch let error {
            XCTFail("\(error)")
        }
        do {
            try lieuSet.ajouterLieu(lieu3)
        } catch let error {
            XCTFail("\(error)")
        }
        lieuSet.enleverLieuSelonDate("2016/02/24")
        do {
            try lieuSet.indexLieu(lieu1)
            XCTFail("L'index ne devrait pas être trouvable")
        } catch ErrorLieuSet.EmptyLieu {
            XCTFail("Le lieu n'était pas vide lors de l'insertion, pourquoi maintenant alors ?")
        } catch ErrorLieuSet.LieuNotInLieuSet {
        } catch let error {
            XCTFail("\(error)")
        }
        do {
            try lieuSet.indexLieu(lieu2)
            XCTFail("L'index ne devrait pas être trouvable")
        } catch ErrorLieuSet.EmptyLieu {
            XCTFail("Le lieu n'était pas vide lors de l'insertion, pourquoi maintenant alors ?")
        } catch ErrorLieuSet.LieuNotInLieuSet {
        } catch let error {
            XCTFail("\(error)")
        }
        do {
            try lieuSet.indexLieu(lieu3)
        } catch ErrorLieuSet.EmptyLieu {
            XCTFail("Le lieu n'était pas vide lors de l'insertion, pourquoi maintenant alors ?")
        } catch ErrorLieuSet.LieuNotInLieuSet {
            XCTFail("Erreur, le lieu devrait être dans le LieuSet")
        } catch let error {
            XCTFail("\(error)")
        }
    }
    
    func testSupprimerLieuSelonLieuVoyage() {
        let voy = Voyage(nom: "a")
        let lieu1 = Lieu(nomLieu: "Le lit", date: "2016/02/24")
        do {
            try voy.ajouterLieu(lieu1)
        } catch let error {
            XCTFail("\(error)")
        }
        voy.enleverLieuSelonLieu(lieu1)
        do {
            try voy.indexLieu(lieu1)
            XCTFail("L'index ne devrait pas être trouvable")
        } catch ErrorLieuSet.EmptyLieu {
            XCTFail("Le lieu n'était pas vide lors de l'insertion, pourquoi maintenant alors ?")
        } catch ErrorLieuSet.LieuNotInLieuSet {
        } catch let error {
            XCTFail("\(error)")
        }
    }
    
    func testSupprimerLieuSelonNomVoyage() {
        let voy = Voyage(nom: "Ikea")
        let lieu1 = Lieu(nomLieu: "Le lit", date: "2016/02/24")
        let lieu2 = Lieu(nomLieu: "Le lit", date: "2016/02/25")
        let lieu3 = Lieu(nomLieu: "Les lits", date: "2016/02/26")
        do {
            try voy.ajouterLieu(lieu1)
        } catch let error {
            XCTFail("\(error)")
        }
        do {
            try voy.ajouterLieu(lieu2)
        } catch let error {
            XCTFail("\(error)")
        }
        do {
            try voy.ajouterLieu(lieu3)
        } catch let error {
            XCTFail("\(error)")
        }
        voy.enleverLieuSelonNom("Le lit")
        do {
            try voy.indexLieu(lieu1)
            XCTFail("L'index ne devrait pas être trouvable")
        } catch ErrorLieuSet.EmptyLieu {
            XCTFail("Le lieu n'était pas vide lors de l'insertion, pourquoi maintenant alors ?")
        } catch ErrorLieuSet.LieuNotInLieuSet {
        } catch let error {
            XCTFail("\(error)")
        }
        do {
            try voy.indexLieu(lieu2)
            XCTFail("L'index ne devrait pas être trouvable")
        } catch ErrorLieuSet.EmptyLieu {
            XCTFail("Le lieu n'était pas vide lors de l'insertion, pourquoi maintenant alors ?")
        } catch ErrorLieuSet.LieuNotInLieuSet {
        } catch let error {
            XCTFail("\(error)")
        }
        do {
            try voy.indexLieu(lieu3)
        } catch ErrorLieuSet.EmptyLieu {
            XCTFail("Le lieu n'était pas vide lors de l'insertion, pourquoi maintenant alors ?")
        } catch ErrorLieuSet.LieuNotInLieuSet {
            XCTFail("Erreur, le lieu devrait être dans le LieuSet")
        } catch let error {
            XCTFail("\(error)")
        }
    }
    
    func testSupprimerLieuSelonDateVoyage() {
        let voy = Voyage(nom: "La sieste")
        let lieu1 = Lieu(nomLieu: "Le lit", date: "2016/02/24")
        let lieu2 = Lieu(nomLieu: "La couette", date: "2016/02/24")
        let lieu3 = Lieu(nomLieu: "L'oreiller", date: "2016/02/26")
        do {
            try voy.ajouterLieu(lieu1)
        } catch let error {
            XCTFail("\(error)")
        }
        do {
            try voy.ajouterLieu(lieu2)
        } catch let error {
            XCTFail("\(error)")
        }
        do {
            try voy.ajouterLieu(lieu3)
        } catch let error {
            XCTFail("\(error)")
        }
        voy.enleverLieuSelonDate("2016/02/24")
        do {
            try voy.indexLieu(lieu1)
            XCTFail("L'index ne devrait pas être trouvable")
        } catch ErrorLieuSet.EmptyLieu {
            XCTFail("Le lieu n'était pas vide lors de l'insertion, pourquoi maintenant alors ?")
        } catch ErrorLieuSet.LieuNotInLieuSet {
        } catch let error {
            XCTFail("\(error)")
        }
        do {
            try voy.indexLieu(lieu2)
            XCTFail("L'index ne devrait pas être trouvable")
        } catch ErrorLieuSet.EmptyLieu {
            XCTFail("Le lieu n'était pas vide lors de l'insertion, pourquoi maintenant alors ?")
        } catch ErrorLieuSet.LieuNotInLieuSet {
        } catch let error {
            XCTFail("\(error)")
        }
        do {
            try voy.indexLieu(lieu3)
        } catch ErrorLieuSet.EmptyLieu {
            XCTFail("Le lieu n'était pas vide lors de l'insertion, pourquoi maintenant alors ?")
        } catch ErrorLieuSet.LieuNotInLieuSet {
            XCTFail("Erreur, le lieu devrait être dans le LieuSet")
        } catch let error {
            XCTFail("\(error)")
        }
    }
}
