//
//  ContentView.swift
//  UnitConversion
//
//  Created by Bhavin Trivedi on 12/8/21.
//

import SwiftUI

struct ContentView: View {
    
    /// Selected input unit type
    @State private var selectedInputType = 0
    
    /// Selected output unit type
    @State private var selectedOutputType = 0
    
    /// Input value
    @State private var input: Double?
    
    /// Meter from selected input type
    var meters: Double {
        let inputValue = input ?? 0
        switch selectedInputType {
        case 0:
            return inputValue
        case 1:
            return inputValue * 1000
        case 2:
            return inputValue * 1.6 * 1000
        case 3:
            return inputValue * 0.30
        case 4:
            return inputValue * 0.91
        default:
            return 0.0
        }
    }
    
    /// Output from selected output type
    var result: Double {
        switch selectedOutputType {
        case 0:
            return meters
        case 1:
            return meters / 1000
        case 2:
            return meters / 1600
        case 3:
            return meters * 3.28
        case 4:
            return meters * 1.09
        default:
            return 0.0
        }
    }
    
    /// Unit types array
    private let unitTypes = ["Meter", "Kilometer", "Mile", "Feet", "Yards"]
    
    let title = "Unit Conversion"
    var body: some View {
        NavigationView {
            Form {
                inputViewSection()
                outputViewSection()
            }
            .navigationTitle(title)
        }
    }
    
    /// Builds output view section
    /// - Returns: View
    @ViewBuilder private func outputViewSection() -> some View {
        Section {
            unitTypesPicker(title: "Output Type", bindingProperty: $selectedOutputType)
            Text("\(result, specifier: "%.2f")")
                .foregroundColor(.red)
                .fontWeight(.bold)
        } header: {
            header(title: "Output")
        }
    }
    
    /// Builds input view section
    /// - Returns: View
    @ViewBuilder private func inputViewSection() -> some View {
        Section {
            unitTypesPicker(title: "Input Type", bindingProperty: $selectedInputType)
            TextField("Enter value", value: $input, formatter: NumberFormatter())
                .keyboardType(.numberPad)
        } header: {
            header(title: "Input")
        }
    }
    
    /// Builds Picker with passed title, content
    /// - Parameters:
    ///   - title: title
    ///   - bindingProperty: binding property
    /// - Returns: Picker
    @ViewBuilder private func unitTypesPicker(title: String, bindingProperty: Binding<Int>) -> some View {
        Picker(title, selection: bindingProperty) {
            ForEach(0..<unitTypes.count) {
                Text(unitTypes[$0]).tag($0)
            }
        }
    }
    
    /// Text with style
    /// - Parameter title: title
    /// - Returns: Text
    @ViewBuilder private func header(title: String) -> some View {
        Text(title)
            .foregroundColor(.brown)
            .fontWeight(.semibold)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
