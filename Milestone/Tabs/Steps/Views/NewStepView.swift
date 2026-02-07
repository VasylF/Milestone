//
//  NewStepView.swift
//  Milestone
//
//  Created by Vasyl Fuchenko on 06.02.2026.
//

import SwiftUI

struct NewStepView: View {
    @Environment(\.dismiss) private var dismiss
    var stepModel: StepModel? = nil
    @State private var title: String = ""
    @State private var isShowingDatePicker = false
    @State private var selectedDate: Date = Date()
    
    private var isEditing: Bool {
        stepModel != nil
    }
    
    private var dateState: DateViewState {
        stepModel?.convertToState() ?? stepModel?.convertToState(selectedDate) ?? .noDate
    }
    
    var body: some View {
        VStack(spacing: .zero) {
            PresentedScreenHeaderView(
                screenName: isEditing ? Strings.editStep : Strings.newStep,
                rightView: AnyView(closeButton)
            )
            VStack(alignment: .leading, spacing: 25) {
                stepNameView
                goalNameView
                dateView
                Spacer()
            }
            .padding(.horizontal, GlobalConstants.hPadding)
            .padding(.top, Constants.topPadding)
        }
        .background(.softGray)
        .onAppear {
            // Initialize editable title from model when editing
            if let stepModel = stepModel {
                title = stepModel.title
            }
        }
    }
    
    private var stepNamednnn: some View {
        ScrollView {
            LazyVStack {
                
            }
//            .padding(.top, Constants.topPadding)
//            .padding(.horizontal, GlobalConstants.hPadding)
//            .safeAreaPadding(.bottom, GlobalConstants.hPadding)
        }
    }
    
    private var stepNameView: some View {
        VStack(alignment: .leading, spacing: 13) {
            Text(Strings.stepNameTitle)
                .font(.inter(.semiBold, size: .lMedium))
                .frame(maxWidth: .infinity, alignment: .leading)
            TextField(Strings.stepNamePlaceholder, text: $title)
                .textInputAutocapitalization(.sentences)
                .disableAutocorrection(false)
                .padding(.horizontal, 12)
                .padding(.vertical, 10)
                .background(Color.white)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                )
        }
    }
    
    private var goalNameView: some View {
        VStack(alignment: .leading, spacing: 13) {
            Text(Strings.stepNameTitle)
                .font(.inter(.semiBold, size: .lMedium))
                .frame(maxWidth: .infinity, alignment: .leading)
            TextField(Strings.stepNamePlaceholder, text: $title)
                .textInputAutocapitalization(.sentences)
                .disableAutocorrection(false)
                .padding(.horizontal, 12)
                .padding(.vertical, 10)
                .background(Color.white)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                )
        }
    }
    
    private var dateView: some View {
        VStack(alignment: .leading, spacing: 13) {
            Text(Strings.todoDateTitle)
                .font(.inter(.semiBold, size: .lMedium))
                .frame(maxWidth: .infinity, alignment: .leading)
            DateView(state: dateState, isCompleted: false) {
                selectedDate = stepModel?.date ?? Date()
                isShowingDatePicker = true
            }
            .popover(isPresented: $isShowingDatePicker, arrowEdge: .top) {
                VStack(alignment: .leading,
                       spacing: Constants.DatePicker.spacing) {
                    DatePicker(
                        Strings.todoDate,
                        selection: $selectedDate,
                        displayedComponents: [.date]
                    )
                    .datePickerStyle(.graphical)

                    HStack {
                        Spacer()
                        Button(Strings.done) {
                            isShowingDatePicker = false
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
                .padding()
                .presentationDetents([.medium])
            }
            
        }
    }
    
    private var closeButton: some View {
        Button {
            dismiss()
        } label: {
            Image(.close)
        }
    }
}

// MARK: - Strings
private enum Strings {
    static let newStep: String = "New Step"
    static let editStep: String = "Edit Step"
    static let stepNameTitle: String = "Step Name"
    static let stepNamePlaceholder: String = "Enter step name"
    static let todoDateTitle: String = "To Do Date (Optional)"
    static let todoDate: String = "To Do Date"
    static let done: String = "Done"
}

// MARK: - Constants
private enum Constants {
    static let topPadding: CGFloat = 25
    enum DatePicker {
        static let spacing: CGFloat = 12
    }
}

// MARK: - Preview
#Preview {
    NewStepView(stepModel: nil)
}

