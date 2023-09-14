//
//  TextRecognitionContext.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-09-14.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import SwiftUI
import SwiftUIKit
import Vision

/**
 This class can be used to store text recognition results.
 
 A SwiftUI view can use `.performTextRecognition` to perform
 text recognition in a collection of images.
 */
class TextRecognitionContext: ObservableObject {
    
    init() {}
    
    @Published
    var recognizedTexts: [String] = []
    
    func reset() { recognizedTexts = [] }
}

extension View {
    
    /**
     Perform text recognition in a list of images then write
     the result to the provided context.
     */
    func performTextRecognition(
        in images: [ImageRepresentable],
        with context: TextRecognitionContext
    ) {
        context.reset()
        let queue = DispatchQueue(label: "imageTextRecognition", qos: .userInitiated)
        queue.async {
            let images = images.compactMap { $0.cgImage }
            for image in images {
                let requestHandler = VNImageRequestHandler(cgImage: image, options: [:])
                let request = textRecognitionRequest(for: context)
                do {
                    try requestHandler.perform([request])
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

private extension View {
    
    func textRecognitionRequest(
        for context: TextRecognitionContext
    ) -> VNRecognizeTextRequest {
        let request = VNRecognizeTextRequest { request, error in
            if let error = error { return print(error) }
            guard let observations = request.results as? [VNRecognizedTextObservation] else { return }
            let texts = observations.compactMap { $0.topCandidates(1).first?.string }
            context.recognizedTexts.append(contentsOf: texts)
        }
        request.recognitionLevel = .accurate
        request.usesLanguageCorrection = true
        return request
    }
}
