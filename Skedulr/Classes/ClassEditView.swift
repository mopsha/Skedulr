//
//  ClassEditView.swift
//  Skedulr
//
//  Created by Michael Opsha on 12/13/23.
//

import SwiftUI

struct ClassEditView: View {
    @Binding var clas: SingleClass
    @Binding var classes: [SingleClass]
    var body: some View {
        Form{
            Section(header: Text("Class Info")){
                TextField("Title", text: $clas.title)
                ThemePicker(selection: $clas.theme)
            }
        }
    }
}

#Preview {
    ClassEditView(clas: .constant(SingleClass.sampleData[0]), classes: .constant(SingleClass.sampleData))
}
