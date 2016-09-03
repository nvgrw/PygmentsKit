//
//  Copyright (c) 2016 Niklas Vangerow
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import Foundation

// MARK: Pygments token types -

public struct Token {
    let kind: Kind
    let payload: String
}

// MARK: Token types -
extension Token {
    enum Kind: String {
        case token = "Token"
        
        case text = "Token.Text"
        case whitespace = "Token.Text.Whitespace"
        case escape = "Token.Escape"
        case error = "Token.Error"
        case other = "Token.Other"
        
        case keyword = "Token.Keyword"
        case keywordConstant = "Token.Keyword.Constant"
        case keywordDeclaration = "Token.Keyword.Declaration"
        case keywordNamespace = "Token.Keyword.Namespace"
        case keywordPseudo = "Token.Keyword.Pseudo"
        case keywordReserved = "Token.Keyword.Reserved"
        case keywordType = "Token.Keyword.Type"
        
        case name = "Token.Name"
        case nameAttribute = "Token.Name.Attribute"
        case nameBuiltin = "Token.Name.Builtin"
        case nameBuiltinPseudo = "Token.Name.Builtin.Pseudo"
        case nameClass = "Token.Name.Class"
        case nameConstant = "Token.Name.Constant"
        case nameDecorator = "Token.Name.Decorator"
        case nameEntity = "Token.Name.Entity"
        case nameException = "Token.Name.Exception"
        case nameFunction = "Token.Name.Function"
        case nameProperty = "Token.Name.Property"
        case nameLabel = "Token.Name.Label"
        case nameNamespace = "Token.Name.Namespace"
        case nameOther = "Token.Name.Other"
        case nameTag = "Token.Name.Tag"
        case nameVariable = "Token.Name.Variable"
        case nameVariableClass = "Token.Name.Variable.Class"
        case nameVariableGlobal = "Token.Name.Variable.Global"
        case nameVariableInstance = "Token.Name.Variable.Instance"
        
        case literal = "Token.Literal"
        case literalDate = "Token.Literal.Date"
        
        case string = "Token.Literal.String"
        case stringBacktick = "Token.Literal.String.Backtick"
        case stringChar = "Token.Literal.String.Char"
        case stringDoc = "Token.Literal.String.Doc"
        case stringDouble = "Token.Literal.String.Double"
        case stringEscape = "Token.Literal.String.Escape"
        case stringHeredoc = "Token.Literal.String.Heredoc"
        case stringInterpol = "Token.Literal.String.Interpol"
        case stringOther = "Token.Literal.String.Other"
        case stringRegex = "Token.Literal.String.Regex"
        case stringSingle = "Token.Literal.String.Single"
        case stringSymbol = "Token.Literal.String.Symbol"
        
        case number = "Token.Literal.Number"
        case numberBin = "Token.Literal.Number.Bin"
        case numberFloat = "Token.Literal.Number.Float"
        case numberHex = "Token.Literal.Number.Hex"
        case numberInteger = "Token.Literal.Number.Integer"
        case numberIntegerLong = "Token.Literal.Number.Integer.Long"
        case numberOct = "Token.Literal.Number.Oct"
        
        case `operator` = "Token.Operator"
        case operatorWord = "Token.Operator.Word"
        
        case punctuation = "Token.Punctuation"
        
        case comment = "Token.Comment"
        case commentHashbang = "Token.Comment.Hashbang"
        case commentMultiline = "Token.Comment.Multiline"
        case commentPreproc = "Token.Comment.Preproc"
        case commentPreprocFile = "Token.Comment.PreprocFile"
        case commentSingle = "Token.Comment.Single"
        case commentSpecial = "Token.Comment.Special"
        
        case generic = "Token.Generic"
        case genericDeleted = "Token.Generic.Deleted"
        case genericEmph = "Token.Generic.Emph"
        case genericError = "Token.Generic.Error"
        case genericHeading = "Token.Generic.Heading"
        case genericInserted = "Token.Generic.Inserted"
        case genericOutput = "Token.Generic.Output"
        case genericPrompt = "Token.Generic.Prompt"
        case genericStrong = "Token.Generic.Strong"
        case genericSubheading = "Token.Generic.Subheading"
        case genericTraceback = "Token.Generic.Traceback"
        
        var scope: String? {
            switch self {
            case .token:
                return nil
                
            case .text:
                return nil
            case .whitespace:
                return nil
            case .escape:
                return nil
            case .error:
                return "invalid.illegal"
            case .other:
                return nil
            case .keyword:
                return "keyword.other"
            case .keywordConstant:
                return "constant.language"
            case .keywordDeclaration:
                return "storage.type"
            case .keywordNamespace:
                return "keyword.control"
            case .keywordPseudo:
                return "constant.language"
            case .keywordReserved:
                return "keyword.other"
            case .keywordType:
                return "storage.type"
                
            case .name:
                return nil
            case .nameAttribute:
                return "entity.other.attribute-name"
            case .nameBuiltin:
                return "variable.language"
            case .nameBuiltinPseudo:
                return "variable.language"
            case .nameClass:
                return "entity.name.type"
            case .nameConstant:
                return "constant.other"
            case .nameDecorator:
                return "entity.name.function"
            case .nameEntity:
                return "constant.character"
            case .nameException:
                return "entity.name.type"
            case .nameFunction:
                return "entity.name.function"
            case .nameProperty:
                return nil // can't find this in the reference
            case .nameLabel:
                return "variable.other"
            case .nameNamespace:
                return "variable.other"
            case .nameOther:
                return nil
            case .nameTag:
                return "entity.name.tag"
            case .nameVariable, .nameVariableClass, .nameVariableGlobal, .nameVariableInstance:
                return "variable.other"
                
            case .literal:
                return "constant.other"
            case .literalDate:
                return "constant.numeric"
                
            case .string:
                return "string"
            case .stringBacktick:
                return "string.interpolated"
            case .stringChar:
                return "constant.other"
            case .stringDoc:
                return "comment.block.documentation"
            case .stringDouble:
                return "string.quoted.double"
            case .stringEscape:
                return "constant.character.escape"
            case .stringHeredoc:
                return "string.unquoted"
            case .stringInterpol:
                return "string.interpolated"
            case .stringOther:
                return "string.other"
            case .stringRegex:
                return "string.regexp"
            case .stringSingle:
                return "string.quoted.single"
            case .stringSymbol:
                return "string.other"
                
            case .number, .numberBin, .numberFloat, .numberHex, .numberInteger, .numberIntegerLong, .numberOct:
                return "constant.numeric"
                
            case .`operator`:
                return "keyword.operator"
            case .operatorWord:
                return "keyword.operator"
                
            case .punctuation:
                return nil
                
            case .comment:
                return "comment"
            case .commentHashbang:
                return "comment.line.number-sign"
            case .commentMultiline:
                return "comment.block"
            case .commentPreproc, .commentPreprocFile:
                return "comment.line"
            case .commentSingle:
                return "comment.line"
            case .commentSpecial:
                return "comment.line"
                
            case .generic:
                return nil
            case .genericDeleted:
                return nil
            case .genericEmph:
                return "markup.italic"
            case .genericError:
                return "invalid"
            case .genericHeading:
                return "markup.heading"
            case .genericInserted:
                return "markup.other"
            case .genericOutput:
                return "markup.raw"
            case .genericPrompt:
                return "markup.raw"
            case .genericStrong:
                return "markup.bold"
            case .genericSubheading:
                return "markup.heading"
            case .genericTraceback:
                return "invalid"
            }
        }
    }
}
