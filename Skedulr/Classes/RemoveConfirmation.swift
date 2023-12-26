//
//  RemoveConfirmation.swift
//  Skedulr
//
//  Created by Michael Opsha on 12/13/23.
//

import SwiftUI

struct RemoveConfirmation: View {
    @Binding var classes: [SingleClass]
    @Binding var confirming: Bool
    var body: some View {
        VStack{
            Text("ARE YOU SURE?")
                .font(.largeTitle)
            HStack{
                Spacer()
                Button(action: {
                    confirming = false
                }){
                    Text("NO")
                        .font(.largeTitle)
                }
                Spacer()
                Button(action: {
                    classes.removeAll()
                    confirming = false
                }){
                    Text("YES")
                        .font(.largeTitle)
                }
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    RemoveConfirmation(classes: .constant(SingleClass.sampleData), confirming: .constant(true))
}
