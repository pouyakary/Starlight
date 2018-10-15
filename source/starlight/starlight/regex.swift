
//
//  Copyright © 2018-present by Pouya Kary <kary.us>, All rights reserved.
//

//
// ─── IMPORTS ────────────────────────────────────────────────────────────────────
//

    import Foundation

//
// ─── REGULAR EXPRESSION OPERATOR ────────────────────────────────────────────────
//

    infix operator =~

    func =~ (input: String, pattern: String) -> Bool {
        let regex =
            try! NSRegularExpression(pattern: "^\(pattern)$", options: [])
        let matches =
            regex.matches(in: input,
                     options: [],
                       range: NSRange(location: 0, length: input.count))

        return matches.count == 1
    }

// ────────────────────────────────────────────────────────────────────────────────
