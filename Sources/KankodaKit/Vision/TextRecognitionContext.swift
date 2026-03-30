//
//  TextRecognitionContext.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-09-14.
//  Copyright © 2023-2026 Kankoda. All rights reserved.
//

#if os(macOS) || os(iOS) || os(tvOS) || os(visionOS)
import SwiftUI
import Vision

/// This class can be used to perform image text recognition.
@Observable @MainActor public class TextRecognitionContext {

    public init() {}

    public var recognizedTexts: [String] = []

    public var lastError: Error?

    public func reset() {
        lastError = nil
        recognizedTexts = []
    }
}

extension TextRecognitionContext {

    func updateRecognizedTexts(
        _ texts: [String]
    ) async {
        lastError = nil
        recognizedTexts = texts
    }

    func updateError(
        _ err: Error
    ) async {
        lastError = err
        recognizedTexts = []
    }
}

public enum TextRecognitionMethod: String, Equatable, Sendable {

    case text, document
}

public extension TextRecognitionContext {
    
    /// Perform text recognition in a set of images, using a
    /// certain recognition method.
    @available(iOS 26.0, macOS 26.0, tvOS 26.0, visionOS 26.0, *)
    func performTextRecognition(
        in images: [ImageRepresentable],
        with method: TextRecognitionMethod = .document
    ) {
        reset()
        Task {
            do {
                let result = try await performInternal(in: images, with: method)
                await updateRecognizedTexts(result)
            } catch {
                await updateError(error)
            }
        }
    }
}

extension TextRecognitionContext {
    
    /// Perform text recognition in a set of images, using a
    /// certain recognition method.
    @available(iOS 26.0, macOS 26.0, tvOS 26.0, visionOS 26.0, *)
    func performInternal(
        in images: [ImageRepresentable],
        with method: TextRecognitionMethod = .document
    ) async throws -> [String] {
        switch method {
        case .text:
            let request = RecognizeTextRequest.kankodaRequest
            return try await request.performTextRecognition(in: images)
        case .document:
            let request = RecognizeDocumentsRequest.kankodaRequest
            return try await request.performTextRecognition(in: images)
        }
    }
}

@available(iOS 26.0, macOS 26.0, tvOS 26.0, visionOS 26.0, *)
extension RecognizeTextRequest {

    static var kankodaRequest: Self {
        var request = RecognizeTextRequest()
        request.recognitionLevel = .accurate
        request.usesLanguageCorrection = true
        return request
    }

    func performTextRecognition(
        in images: [ImageRepresentable]
    ) async throws -> [String] {
        let images = images.compactMap { $0.cgImage }
        var results: [String] = []
        for image in images {
            let observations = try await perform(on: image)
            let texts = observations.compactMap {
                $0.topCandidates(1).first?.string
            }
            results.append(contentsOf: texts)
        }
        return results
    }
}

@available(iOS 26.0, macOS 26.0, tvOS 26.0, visionOS 26.0, *)
extension RecognizeDocumentsRequest {

    static var kankodaRequest: Self {
        var request = RecognizeDocumentsRequest()
        request.textRecognitionOptions.useLanguageCorrection = true
        return request
    }

    enum KankodaError: LocalizedError {
        case noDocumentFound
    }

    func performTextRecognition(
        in images: [ImageRepresentable]
    ) async throws -> [String] {
        let images = images.compactMap { $0.cgImage }
        var results: [String] = []
        for image in images {
            let observations = try await perform(on: image)
            guard let doc = observations.first?.document else {
                throw KankodaError.noDocumentFound
            }
            let texts = doc.paragraphs.map { $0.transcript }
            results.append(contentsOf: texts)
        }
        return results
    }
}
#endif
