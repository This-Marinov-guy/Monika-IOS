import SwiftUI

struct PersonFormSheet: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var birthday: Date = Date()
    @State private var hasBirthday = false
    @State private var notes = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Person Details") {
                    TextField("Name", text: $name)
                    
                    Toggle("Has Birthday", isOn: $hasBirthday)
                    
                    if hasBirthday {
                        DatePicker("Birthday", selection: $birthday, displayedComponents: .date)
                    }
                }
                
                Section("Notes") {
                    TextField("Add notes...", text: $notes, axis: .vertical)
                        .lineLimit(3...6)
                }
            }
            .navigationTitle("New Person")
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        // TODO: Save person
                        dismiss()
                    }
                    .disabled(name.isEmpty)
                }
            }
        }
    }
}

#Preview {
    PersonFormSheet()
}

