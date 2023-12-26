//
//  ClassCard.swift
//  Skedulr
//
//  Created by Michael Opsha on 12/4/23.
//

import SwiftUI

struct ClassCard: View {
    var clas: SingleClass
    var body: some View {
        VStack{
            Text(clas.title)
                .textCase(.uppercase)
        }
    }
}

#Preview {
    ClassCard(clas: SingleClass.sampleData[0])
}
