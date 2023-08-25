//
//  model.swift
//  Archy
//
//  Created by MURAT BAŞER on 20.08.2023.
//

import Foundation


 struct Post : Identifiable {
 var id = UUID()
 var username : String
 var mail : String
 var image : String
 var descrip : String
 var likeCount : Int = 0
 
 }
 

