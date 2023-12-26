//
//  ClassesView.swift
//  Skedulr
//
//  Created by Michael Opsha on 12/4/23.
//

import SwiftUI

struct ClassesView: View {
    @Binding var classes: [SingleClass]
    @State private var addingNew = false
    @State private var confirming = false
    var body: some View {
        NavigationStack{
            List($classes){ $clas in
                NavigationLink(destination: ClassEditView(clas: $clas, classes: $classes)){
                    ClassCard(clas: clas)
                }
                .listRowBackground(clas.theme.mainColor)
                .foregroundColor(clas.theme.accentColor)
            }
            .navigationTitle("Classes")
            .toolbar {
                Button(action: {
                    addingNew = true
                }){
                    Image(systemName: "plus")
                }
                .accessibilityLabel("New Task")
            }
        }
        Button(action: {
            confirming = true
        }){
            Text("Remove All Classes")
        }
        .padding()
        .sheet(isPresented: $addingNew){
            NewClass(addingNew: $addingNew, classes: $classes)
        }
        .sheet(isPresented: $confirming){
            RemoveConfirmation(classes: $classes, confirming: $confirming)
        }
    }
}

#Preview {
    ClassesView(classes: .constant(SingleClass.sampleData))
}
