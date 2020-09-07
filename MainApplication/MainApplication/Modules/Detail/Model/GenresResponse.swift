//
//  GenresResponse.swift
//  MainApplication
//
//  Created by alpiopio on 07/09/20.
//  Copyright © 2020 alfian0. All rights reserved.
//

import Foundation

/*
 ["genres": <__NSArrayI 0x6000001f0420>(
 {
     id = 28;
     name = Action;
 },
 {
     id = 12;
     name = Adventure;
 },
 {
     id = 16;
     name = Animation;
 },
 {
     id = 35;
     name = Comedy;
 },
 {
     id = 80;
     name = Crime;
 },
 {
     id = 99;
     name = Documentary;
 },
 {
     id = 18;
     name = Drama;
 },
 {
     id = 10751;
     name = Family;
 },
 {
     id = 14;
     name = Fantasy;
 },
 {
     id = 36;
     name = History;
 },
 {
     id = 27;
     name = Horror;
 },
 {
     id = 10402;
     name = Music;
 },
 {
     id = 9648;
     name = Mystery;
 },
 {
     id = 10749;
     name = Romance;
 },
 {
     id = 878;
     name = "Science Fiction";
 },
 {
     id = 10770;
     name = "TV Movie";
 },
 {
     id = 53;
     name = Thriller;
 },
 {
     id = 10752;
     name = War;
 },
 {
     id = 37;
     name = Western;
 }
 )
 ]
 */

struct GenresResponse: Codable {
    let genres: [Genre]
    
    struct Genre: Codable {
        let id: Int
        let name: String
    }
}
