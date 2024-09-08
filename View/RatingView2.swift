//
//  RatingView2.swift
//  gratify
//
//  Created by Sam on 4/14/24.
//

import Foundation
import SwiftUI

struct RatingView2: View {
    @ObservedObject var viewModel: ViewModel
    @Binding var navigationPath: NavigationPath
    @State var isSubmitDisabled: Bool = false
    
    var body: some View {
        Spacer()
        VStack {
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Text("Jot up to 3 things you're grateful for today.")
                .font(Font.custom("GillSans", size: 20))
            
            Form {
                TextField("Entry 1", text: Binding(
                    get: { viewModel.dailyEntry?.summary1 ?? "" },
                    set: { viewModel.dailyEntry?.summary1 = $0 }
                ))
                .onChange(of: viewModel.dailyEntry?.summary1 ?? "") { _ in
                    print("test1")
                    validateForm()
                }
                
                TextField("Entry 2", text: Binding(
                    get: { viewModel.dailyEntry?.summary2 ?? "" },
                    set: { viewModel.dailyEntry?.summary2 = $0 }
                ))
                .onChange(of: viewModel.dailyEntry?.summary2 ?? "") { _ in
                    validateForm()
                }
                
                TextField("Entry 3", text: Binding(
                    get: { viewModel.dailyEntry?.summary3 ?? "" },
                    set: { viewModel.dailyEntry?.summary3 = $0 }
                ))
                .onChange(of: viewModel.dailyEntry?.summary3 ?? "") { _ in
                    validateForm()
                }
                
                Button(action: {
                    viewModel.dailyEntry?.id = UUID()
                    viewModel.dailyEntry?.date = Date()
                    navigationPath = NavigationPath()
                }) {
                    Text("Submit")
                }
                .disabled(isSubmitDisabled)
            }
            .scrollContentBackground(.hidden)
        }
    }
    
    func validateForm() {
        guard let entry = viewModel.dailyEntry else {
            isSubmitDisabled = false
            return
        }
        print((entry.summary1?.isEmpty == false) && (entry.summary2?.isEmpty == false) && (entry.summary3?.isEmpty == false))
        isSubmitDisabled = (entry.summary1?.isEmpty == false) && (entry.summary2?.isEmpty == false) && (entry.summary3?.isEmpty == false)
    }
}
