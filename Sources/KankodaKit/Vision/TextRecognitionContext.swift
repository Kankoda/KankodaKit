//
//  TextRecognitionContext.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-09-14.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

#if os(macOS) || os(iOS) || os(tvOS)
import SwiftUI
import SwiftUIKit
import Vision

/**
 This class can be used to perform image text recognition.
 */
public class TextRecognitionContext: ObservableObject {
    
    public init() {}
    
    @Published
    public var result: [String] = []
    
    public func reset() { result = [] }
}

public extension TextRecognitionContext {
    
    /// Perform text recognition in a collection of images.
    func performTextRecognition(in images: [ImageRepresentable]) {
        reset()
        let queue = DispatchQueue(label: "imageTextRecognition", qos: .userInitiated)
        queue.async {
            let images = images.compactMap { $0.cgImage }
            for image in images {
                let requestHandler = VNImageRequestHandler(cgImage: image, options: [:])
                let request = self.textRecognitionRequest()
                do {
                    try requestHandler.perform([request])
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

private extension TextRecognitionContext {
    
    func textRecognitionRequest() -> VNRecognizeTextRequest {
        let request = VNRecognizeTextRequest { request, error in
            if let error = error { return print(error) }
            guard let observations = request.results as? [VNRecognizedTextObservation] else { return }
            let texts = observations.compactMap { $0.topCandidates(1).first?.string }
            DispatchQueue.main.async {
                self.result.append(contentsOf: texts)
            }
        }
        request.recognitionLevel = .accurate
        request.usesLanguageCorrection = true
        return request
    }
}
#endif
