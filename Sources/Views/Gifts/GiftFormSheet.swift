import SwiftUI

struct GiftFormSheet: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var price = ""
    @State private var link = ""
    @State private var priority = "Medium"
    @State private var notes = ""
    
    let priorities = ["Low", "Medium", "High", "Wishlist"]
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Gift Details") {
                    TextField("Gift Name", text: $name)
                    
                    TextField("Price", text: $price)
                        #if os(iOS)
                        .keyboardType(.decimalPad)
                        #endif
                    
                    TextField("Link (optional)", text: $link)
                        #if os(iOS)
                        .keyboardType(.URL)
                        .autocapitalization(.none)
                        #endif
                    
                    Picker("Priority", selection: $priority) {
                        ForEach(priorities, id: \.self) { priority in
                            Text(priority).tag(priority)
                        }
                    }
                }
                
                Section("Notes") {
                    TextField("Add notes...", text: $notes, axis: .vertical)
                        .lineLimit(3...6)
                }
            }
            .navigationTitle("New Gift")
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
                        // TODO: Save gift
                        dismiss()
                    }
                    .disabled(name.isEmpty)
                }
            }
        }
    }
}

#Preview {
    GiftFormSheet()
}

