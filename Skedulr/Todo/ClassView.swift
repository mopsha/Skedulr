//
//  ClassView.swift
//  Skedulr
//
//  Created by Michael Opsha on 12/13/23.
//

import SwiftUI

struct ClassView: View {
    @Binding var clas: SingleClass
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Text(clas.title)
                Spacer()
            }
        }
        .padding()
    }
}

#Preview {
    ClassView(clas: .constant(SingleClass.sampleData[0]))
}
