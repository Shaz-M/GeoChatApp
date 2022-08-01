//
//  MessageCell.swift
//  GeoChatApp
//
//  Created by Shaz on 8/1/22.
//

import SwiftUI

struct MessageCell: View {
    var destination:ChatView
    @State var name: String = "defualt"
    @State var message: String = "default@gmail.com"
    
    var body: some View {
        NavigationLink(destination: destination) {
            HStack {
                Image(systemName: "person.crop.circle.fill")
                    .font(.system(size: 40))
                
                VStack(alignment: .leading, spacing: 2) {
                    HStack(alignment: .center) {
                        Text(name)
                            .font(.headline)
                        Spacer()
                        Text("9:41 AM")
                            .font(.callout)
                    }
                    
                    Text(message)
                        .font(.callout)
                        .lineLimit(1)
                }
            }
            .padding(.vertical, 12)
        }
    }
}

