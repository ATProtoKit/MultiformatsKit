//
//  Errors.swift
//  MultiformatsKit
//
//  Created by Christopher Jr Riley on 2025-03-21.
//

import Foundation

/// A list of errors related to varint encoding and decoding.
public enum VarintError: Error, LocalizedError, CustomStringConvertible {

    /// The integer is not an unsigned integer.
    case negativeInteger

    /// The integer is larger than 9 bytes.
    case integerTooLarge

    /// The integer is empty.
    case emptyInput

    /// The last byte was a continuation byte, but the input ended.
    case continuationByteAtEnd

    /// The value wasn't minimally encoded.
    case overlongEncoding

    /// Not all bytes were used by the variant encoding.
    case notAllBytesUsed

    /// The continuation byte was missing.
    ///
    /// - Parameter byteIndex: The index of the byte.
    case missingContinuationByte(byteIndex: Int)

    public var errorDescription: String? {
        switch self {
            case .negativeInteger:
                return "Integer is negative. Varint only supports unsigned integers."
            case .integerTooLarge:
                return "Integer is too large to be encoded as varint (more than 9 bytes)."
            case .emptyInput:
                return "Input is empty. Varints must be at least 1 byte long."
            case .continuationByteAtEnd:
                return "Last byte was a continuation byte but input ended."
            case .overlongEncoding:
                return "Value was not minimally encoded."
            case .notAllBytesUsed:
                return "Not all bytes were used by the varint encoding."
            case .missingContinuationByte(let byteIndex):
                return "Expected continuation byte at index \(byteIndex), but none was available."
        }
    }

    public var description: String {
        return errorDescription ?? String(describing: self)
    }
}

/// A list of errors related to Multicodec operations.
public enum MulticodecError: Error, LocalizedError {

    /// The provided data is empty.
    case emptyData

    /// The name provided is invalid.
    ///
    /// - Parameter name: The name provided.
    case invalidName(name: String)

    /// The code provided is invalid.
    ///
    /// - Parameter code: The code provided.
    case invalidCode(code: Int)

    /// The status provided is invalid.
    ///
    /// - Parameter status: The status provided.
    case invalidStatus(status: String)

    /// There is a mismatch between the expected and found code.
    ///
    /// - Parameters:
    ///   - expected: The expected code.
    ///   - found: The code that was actually there.
    case mismatchedCode(expected: UInt8, found: UInt8)

    /// The Multicode is not registered.
    ///
    /// - Parameter string: The Multicode's ID.
    case notRegistered(id: String)

    /// There is a duplicate name.
    ///
    /// - Parameter name: The provided name.
    case duplicateName(name: String)

    /// There is a duplicate code.
    ///
    /// - Parameter code: The provided code.
    case duplicateCode(code: Int)

    /// The query name or code is too ambiguous.
    case ambiguousQuery

    public var errorDescription: String? {
        switch self {
            case .emptyData:
                return "The provided data is empty."
            case .invalidName(let name):
                return "Invalid multicodec name: \(name)"
            case .invalidCode(let code):
                return "Invalid multicodec code: \(code)"
            case .invalidStatus(let status):
                return "Invalid multicodec status: \(status)"
            case .mismatchedCode(let expected, let found):
                return "Mismatched multicodec code. Expected 0x\(String(format: "%02x", expected)), found 0x\(String(format: "%02x", found))."
            case .notRegistered(let id):
                return "Multicodec not registered: \(id)"
            case .duplicateName(let name):
                return "Multicodec name already exists: \(name)"
            case .duplicateCode(let code):
                return "Multicodec code already exists: \(code)"
            case .ambiguousQuery:
                return "You must specify exactly one of name or code."
        }
    }

    public var description: String {
        return errorDescription ?? String(describing: self)
    }
}

/// A list of errors for ``BaseN`` encoding and decoding.
public enum BaseNError: Error, LocalizedError {

    /// The base alphabet is invalid.
    ///
    /// - Parameter alphabet: The base alphabet in question.
    case invalidAlphabet(alphabet: String)

    /// The character used is too ambiguous.
    ///
    /// - Parameter alphabet: The character in question.
    case ambiguousCharacter(alphabet: Character)

    /// The character used is invalid.
    ///
    /// - Parameter character: The invalid character.
    case invalidCharacter(character: Character)

    /// The character being used exists more than once.
    ///
    /// - Parameter character: The duplicate character.
    case duplicateCharacter(character: Character)

    /// There are an invalid number of characters.
    case invalidNumberOfCharacters

    var errorDescription: String {
        switch self {
            case .invalidAlphabet(let alphabet):
                return "Invalid BaseN alphabet: \(alphabet)."
            case .ambiguousCharacter(alphabet: let alphabet):
                return "\(alphabet) is ambiguous. Please use a different alphabet."
            case .invalidCharacter(character: let character):
                return "Invalid BaseN character: \(character)."
            case .duplicateCharacter(character: let character):
                return "Duplicate BaseN character: \(character)."
            case .invalidNumberOfCharacters:
                return "The number of characters in the input is invalid."
        }
    }

    public var description: String {
        return errorDescription ?? String(describing: self)
    }
}

/// A list of errors related to prefixes.
public enum PrefixError: Error, LocalizedError {

    /// The prefix is invalid.
    case invalidPrefix

    /// The Multibase string is unable to be decoded.
    case unableToDecodeMultibaseString

    /// The Multibase prefix is not supported.
    case unsupportedMultibasePrefix

    var errorDescription: String {
        switch self {
            case .invalidPrefix:
                return "The prefix is invalid."
            case .unableToDecodeMultibaseString:
                return "The Multibase string is unable to be decoded."
            case .unsupportedMultibasePrefix:
                return "The Multibase prefix is not supported."
        }
    }

    public var description: String {
        return errorDescription ?? String(describing: self)
    }
}

/// A list of errors related to BaseN decoding.
public enum BaseNDecodingError: Error, LocalizedError {

    /// There is an invalid character.
    ///
    /// - Parameter character: The invalid character.
    case invalidCharacter(character: Character)

    /// There was an unexpected amount of data at the end.
    case unexpectedEndOfData

    var errorDescription: String {
        switch self {
            case .invalidCharacter(character: let character):
                return "There is an invalid character: \(character)."
            case .unexpectedEndOfData:
                return "There was an unexpected amount of data at the end."
        }
    }

    public var description: String {
        return errorDescription ?? String(describing: self)
    }
}

/// A list of errors that can be thrown by the CID implementation.
public enum CIDError: Error, LocalizedError {

    /// The CID is invalid.
    case invalidCID(message: String)

    /// The content for the CID couldn't be converted to a `Data` object.
    ///
    /// - Parameter string: The content itself.
    case invalidDataConversion(content: String)

    /// The version number for the CID is invalid.
    ///
    /// - Parameter versionNumber: The invalid version number.
    case invalidVersion(versionNumber: UInt64)

    /// The multihash for CIDv0 is invalid.
    case invalidMultihashForCIDv0

    public var errorDescription: String? {
        switch self {
            case .invalidCID(let message):
                return "Invalid CID. \(message)"
            case .invalidDataConversion(let content):
                return "The string (\(content)) for the CID couldn't be converted to a `Data` object."
            case .invalidVersion(let version):
                return "Invalid or unsupported CID version: \(version)"
            case .invalidMultihashForCIDv0:
                return "CIDv0 must be a valid SHA2-256 multihash: exactly 34 bytes long with prefix 0x12, 0x20."
        }
    }

    public var description: String {
        return errorDescription ?? String(describing: self)
    }
}
