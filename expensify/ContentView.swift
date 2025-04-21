//
//  ContentView.swift
//  expensify
//
//  Created by Anand Rajaram on 21/04/25.
//

import SwiftUI
import SwiftData
import Observation

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var people: [Person]
    @State private var showingAddPerson = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(people) { person in
                    NavigationLink(destination: PersonDetailView(person: person)) {
                        HStack {
                            Text(person.name)
                                .font(.headline)
                            Spacer()
                            Text("₹\(String(format: "%.2f", person.total))")
                                .fontWeight(.bold)
                                .foregroundColor(person.total > 0 ? .red : .green)
                        }
                    }
                }
                .onDelete(perform: deletePeople)
            }
            .navigationTitle("Expense Tracker")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: { showingAddPerson = true }) {
                        Label("Add Person", systemImage: "person.badge.plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddPerson) {
                AddPersonView()
            }
        }
    }
    
    private func deletePeople(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(people[index])
            }
        }
    }
}

struct AddPersonView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @State private var name = ""
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
            }
            .navigationTitle("Add Person")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let newPerson = Person(name: name)
                        modelContext.insert(newPerson)
                        dismiss()
                    }
                    .disabled(name.isEmpty)
                }
            }
        }
    }
}

struct PersonDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @Bindable var person: Person
    @State private var showingAddExpense = false
    
    var body: some View {
        List {
            Section(header: Text("TOTAL: ₹\(String(format: "%.2f", person.total))").font(.headline)) {
                ForEach(person.expenses) { expense in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(expense.expenseDescription)
                                .font(.headline)
                            Text(expense.date.formatted(date: .abbreviated, time: .omitted))
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .trailing) {
                            Text("₹\(String(format: "%.2f", expense.amount))")
                                .fontWeight(.bold)
                            
                            Toggle("", isOn: Binding(
                                get: { expense.isPaid },
                                set: { expense.isPaid = $0 }
                            ))
                            .labelsHidden()
                            .tint(.green)
                        }
                    }
                }
                .onDelete(perform: deleteExpenses)
            }
        }
        .navigationTitle(person.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { showingAddExpense = true }) {
                    Label("Add Expense", systemImage: "plus")
                }
            }
        }
        .sheet(isPresented: $showingAddExpense) {
            AddExpenseView(person: person)
        }
    }
    
    private func deleteExpenses(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(person.expenses[index])
            }
        }
    }
}

struct AddExpenseView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @Bindable var person: Person
    
    @State private var description = ""
    @State private var amount = 0.0
    @State private var date = Date()
    @State private var isPaid = false
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Description", text: $description)
                
                HStack {
                    Text("₹")
                    TextField("Amount", value: $amount, format: .number)
                        .keyboardType(.decimalPad)
                }
                
                DatePicker("Date", selection: $date, displayedComponents: .date)
                
                Toggle("Paid", isOn: $isPaid)
            }
            .navigationTitle("Add Expense")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let newExpense = Expense(
                            expenseDescription: description,
                            amount: amount,
                            date: date,
                            isPaid: isPaid
                        )
                        person.expenses.append(newExpense)
                        dismiss()
                    }
                    .disabled(description.isEmpty || amount <= 0)
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [Person.self, Expense.self], inMemory: true)
}
	
