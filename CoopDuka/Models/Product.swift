//
//  Post.swift
//  CoopDuka
//
//  Created by Perpetua Kabute    on 17/03/2026.
//
import Foundation

struct Product: Identifiable, Codable, Hashable {
    let id: Int
    let userId: Int
    let title: String
    let body: String
}
