//
//  PostsView.swift
//  Archy
//
//  Created by MURAT BAŞER on 25.08.2023.
//

import SwiftUI

struct PostsView: View {
    @State private var isGridVisible = true
    @State private var isLineVisible = true
    var body: some View {
        HStack{
            Button{
                self.isGridVisible = true
                self.isLineVisible = false
            }label: {
                Image(systemName: "circle.grid.3x3.fill")
            }
            Spacer()
            Button{
                self.isGridVisible = false
                self.isLineVisible = true
            }label: {
                Image(systemName: "line.3.horizontal")
            }
        }.foregroundColor(.black)
            .font(.system(size: 25))
            .padding(.horizontal,100)
        if isGridVisible {
            PostsGridView()
        }
        else if isLineVisible {
            PostsLineView()
        }
            
    }
}

struct PostsView_Previews: PreviewProvider {
    static var previews: some View {
        PostsView()
    }
}
