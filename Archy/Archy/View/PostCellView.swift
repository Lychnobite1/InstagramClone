//
//  PostCellView.swift
//  Archy
//
//  Created by MURAT BAŞER on 21.08.2023.
//

import SwiftUI
import SDWebImageSwiftUI
import Firebase
struct PostCellView: View {
    var post : Post
    @State private var count = 0
    @State private var isLike = false
    @State private var likeCount = 0
    var body: some View {
        VStack(alignment: .leading,spacing: 10){
            HStack{
                Text(post.username)
                Spacer()
                Button{
                    // delete
                }label: {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                        .font(.system(size: 20))
                }
            }
            .padding(.horizontal,25)
            WebImage(url: URL(string: post.image))
                .resizable()
                .frame(width: 350,height: 350)
            HStack{
                HStack(spacing: 10){
                    Text("\(count)")
                    Image(systemName: "hand.thumbsup")
                }
                .font(.system(size: 18))
                
               
                
                
                Spacer()
                HStack(spacing: 17){
                    Button{

                        self.isLike.toggle()
                        if self.isLike == true {
                            self.count += 1
                        } else {
                            self.count -= 1
                        }
                        
                        
                    }label: {
                        Image(systemName: isLike ? "heart.fill":"heart")
                            .foregroundColor(isLike ? .red : .black)
                    }
                    
                    Button{
                        
                    }label: {
                        Image(systemName: "bubble.left")
                    }
                    .foregroundColor(.black)
                    Button{
                        
                    }label: {
                        Image(systemName: "arrowshape.turn.up.right")
                    }
                    .foregroundColor(.black)
                    
                    
                    
                }
                .font(.system(size: 26))
                
            }
            .padding(.horizontal,25)
            Text(post.descrip).padding(.horizontal)
            
        }
        
    }

    
}

struct PostCellView_Previews: PreviewProvider {
    static var previews: some View {
        PostCellView(post: Post(username: "MuratBaser", mail: "Murat@gmail.com", image: "nofoto", descrip: "asdassdfdsfsdfsdfsdfsdfsdfsdfsdfsdfsdfd", likeCount: 0))
    }
}
