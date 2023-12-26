//
//  NewClass.swift
//  Skedulr
//
//  Created by Michael Opsha on 12/4/23.
//

import SwiftUI

struct NewClass: View {
    @Binding var addingNew: Bool
    @Binding var classes: [SingleClass]
    @State private var newClass = SingleClass.genericClass
    var body: some View {
        NavigationStack{
            ClassEditView(clas: $newClass, classes: $classes)
                .toolbar{
                    ToolbarItem(placement: .cancellationAction){
                        Button("Dismiss"){
                            addingNew = false
                        }
                    }
                    ToolbarItem(placement: .confirmationAction){
                        Button("Add"){
                            classes.append(newClass)
                            addingNew = false
                        }
                    }
                }
        }
    }
}

#Preview {
    NewClass(addingNew: .constant(true), classes: .constant(SingleClass.sampleData))
}
