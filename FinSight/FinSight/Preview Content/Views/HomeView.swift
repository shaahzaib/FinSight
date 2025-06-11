//
//  HomeView.swift
//  FinSight
//
//  Created by Macbook Pro on 31/05/2025.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack{
            
            // slider and profile button
            HStack{
                Button {
                    
                } label: {
                    Image(systemName: "slider.vertical.3")
                        .font(.title)
                        
                }
                Spacer()

                Button {
                    
                } label: {
                    Image(systemName: "person.circle.fill")
                        .imageScale(.large)
                       
                        
                }

                
            }.foregroundStyle(.black)
                .padding()
            
            
            
            
            // balance
            
            VStack(spacing: 10){
                Text("Total balance")
                    .fontWeight(.bold)
                    
                Text("$ 50,500")
                    .font(.system(size: 38, weight:.bold) )
            }
            
            .padding(.top,20)
            
            
            // income button
           
                
                Button {
                    
                } label: {
                    HStack{
                        
                        Text("Income")
                          
                        Image(systemName: "chevron.down")
                        
                    }
                    .font(.caption)
                    .padding(.vertical,10)
                    .padding(.horizontal,20)
                    .background(.white,in: Capsule())
                    .shadow(color: .black.opacity(0.2), radius: 5)
                    .foregroundStyle(.black)
                }

                //Graph view
            
            GraphView(data: samplePlot)
                .frame(height: 220)
                .padding(.top,25)
            
            
            Text("Shortcuts")
                .font(.title.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .padding(.top)
            
            
            ScrollView(.horizontal,showsIndicators: false){
                
                HStack(spacing: 15){
                    
                    cardview(image: "apple.logo", title: "Apple", price: "$ 26", color: .black)
                    cardview(image: "xbox.logo", title:"Xbox", price:  "$ 800", color: .green)
                    cardview(image: "playstation.logo", title: "PlayStation", price: "$ 400", color: .blue)
                }
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity , alignment: .top)
    }
    
    @ViewBuilder
    
    func cardview(image:String,title:String,price:String,color:Color) -> some View{
        
        VStack{
            
            Image(systemName: image)
                .imageScale(.large)
                .foregroundStyle(.white)
                .frame(width: 35, height: 35)
                .padding()
                .background(color,in: Circle())
            
            Text(title)
                .font(.title3.bold())
            
            Text(price)
                .fontWeight(.semibold)
                .foregroundStyle(.gray)
        }
        .padding(.vertical)
        .padding(.horizontal,30)
        .background(.white,in: RoundedRectangle(cornerRadius: 15))
        .shadow(color: .black.opacity(0.2), radius: 5)
    }
        
    
}

#Preview {
    HomeView()
}

// sample data

let samplePlot : [CGFloat] = [
    
989,1200,790,750,650,950,1200,600,850,1230,900,1400,1250,1600,1200
]
