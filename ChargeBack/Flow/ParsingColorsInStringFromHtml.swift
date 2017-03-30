//
//  ParsingColorsInStringFromHtml.swift
//  ChargeBack
//
//  Created by Antoine Barrault on 26/03/2017.
//  Copyright © 2017 Antoine Barrault. All rights reserved.
//

import Foundation

extension String {

     func extractColorList() -> [(String, String)] {
        var colors = [String: Int]()
        let regexString = "<font color=\\\"#+([.0-9a-zA-z]+)\\\">.*?</font>"
        var counter = 0
        var index = 1
        let maxCounter = 2
        for capture in (self =~ Regex(regexString)).captures {
            // capture is a String
            if counter == maxCounter {
                counter = 0
            }
            if let capture = capture {
                if counter == 1 {
                    colors[capture] = index
                    index += 1
                }
                counter += 1
            }
        }
        var array = [(String, String)]()
        var colorIndex = 1
        for (k, _) in colors.sorted(by: {$0.value < $1.value}) {
            array.append((k, "customcolor\(colorIndex)"))
            colorIndex += 1
        }
        return array

    }

    mutating func replacingColors() -> [(String, String)] {

        let colors = self.extractColorList()
        for color in colors {
            self = self.replace(color: (color.0, color.1))
        }
        return colors
    }

     func replaceColors() -> String {

        var resultString = self
        let colors = self.extractColorList()
        for color in colors {
            resultString = resultString.replace(color: (color.0, color.1))
        }

        return resultString
    }

    func replace(color: (String, String)) -> String {

        let regexString = "(font color=\\\"#+(\(color.0)+)\\\")(>.*?</)(font)"
        let stageName = map(self =~ Regex(regexString), replacementTemplate: "\(color.1)$3\(color.1)")
        return stageName

    }

}
