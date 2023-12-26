//
//  ClassPicker.swift
//  Skedulr
//
//  Created by Michael Opsha on 12/4/23.
//

import SwiftUI

struct ClassPicker: View {
    @Binding var selection: SingleClass
    @Binding var classList: [SingleClass]
    var body: some View {
        Picker("Class", selection: $selection){
            ForEach($classList){ $clas in
                ClassView(clas: $clas)
            }
        }
        .pickerStyle(.navigationLink)
    }
}

#Preview {
    ClassPicker(selection: .constant(SingleClass.sampleData[0]), classList: .constant(SingleClass.sampleData))
}
