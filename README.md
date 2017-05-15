# PygmentsKit [![GitHub license](https://img.shields.io/badge/License-MIT-blue.svg?style=flat-square)](https://raw.githubusercontent.com/notronik/PygmentsKit/master/LICENSE) [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat-square)](https://github.com/Carthage/Carthage) [![Swift 3.0](https://img.shields.io/badge/Swift-3.0-EF5138.svg?style=flat-square&logo=data%3Aimage%2Fpng%3Bbase64%2CiVBORw0KGgoAAAANSUhEUgAAAA4AAAAOCAIAAACQKrqGAAAABGdBTUEAALGPC%2FxhBQAAAAlwSFlzAAALEwAACxMBAJqcGAAABCRpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IlhNUCBDb3JlIDUuNC4wIj4KICAgPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4KICAgICAgPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIKICAgICAgICAgICAgeG1sbnM6dGlmZj0iaHR0cDovL25zLmFkb2JlLmNvbS90aWZmLzEuMC8iCiAgICAgICAgICAgIHhtbG5zOmV4aWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20vZXhpZi8xLjAvIgogICAgICAgICAgICB4bWxuczpkYz0iaHR0cDovL3B1cmwub3JnL2RjL2VsZW1lbnRzLzEuMS8iCiAgICAgICAgICAgIHhtbG5zOnhtcD0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wLyI%2BCiAgICAgICAgIDx0aWZmOlJlc29sdXRpb25Vbml0PjI8L3RpZmY6UmVzb2x1dGlvblVuaXQ%2BCiAgICAgICAgIDx0aWZmOkNvbXByZXNzaW9uPjU8L3RpZmY6Q29tcHJlc3Npb24%2BCiAgICAgICAgIDx0aWZmOlhSZXNvbHV0aW9uPjcyPC90aWZmOlhSZXNvbHV0aW9uPgogICAgICAgICA8dGlmZjpPcmllbnRhdGlvbj4xPC90aWZmOk9yaWVudGF0aW9uPgogICAgICAgICA8dGlmZjpZUmVzb2x1dGlvbj43MjwvdGlmZjpZUmVzb2x1dGlvbj4KICAgICAgICAgPGV4aWY6UGl4ZWxYRGltZW5zaW9uPjE0PC9leGlmOlBpeGVsWERpbWVuc2lvbj4KICAgICAgICAgPGV4aWY6Q29sb3JTcGFjZT4xPC9leGlmOkNvbG9yU3BhY2U%2BCiAgICAgICAgIDxleGlmOlBpeGVsWURpbWVuc2lvbj4xNDwvZXhpZjpQaXhlbFlEaW1lbnNpb24%2BCiAgICAgICAgIDxkYzpzdWJqZWN0PgogICAgICAgICAgICA8cmRmOlNlcS8%2BCiAgICAgICAgIDwvZGM6c3ViamVjdD4KICAgICAgICAgPHhtcDpNb2RpZnlEYXRlPjIwMTY6MDk6MDMgMTc6MDk6ODc8L3htcDpNb2RpZnlEYXRlPgogICAgICAgICA8eG1wOkNyZWF0b3JUb29sPlBpeGVsbWF0b3IgMy41LjE8L3htcDpDcmVhdG9yVG9vbD4KICAgICAgPC9yZGY6RGVzY3JpcHRpb24%2BCiAgIDwvcmRmOlJERj4KPC94OnhtcG1ldGE%2BCu2pn9UAAAGNSURBVCgVjZHLK0VRFMb3Wnufx73yuF2PlAwor7gSBoqUKGVABgYyMDOQgTJTomQo%2F4KZlJGUsYGhEQMkIe9HouPee849e1nnXNerlD0457TWb33r%2B86G5%2BEO8b%2BDf2K%2B%2F6uVQ4mCRu4JpiXrmsRPOkSZsGywI1heIUjziHZeVUOLOTBCbvpTO6fq%2B6qxlVGjs4%2B1gcjb27VHJ1Rto8h4WTpEAYSXzhwfqLYulWi3x6dEJI%2FuroWU1uAYZV0JoT70UdLjnbu5Fp1ewMoqWdPkbq0LANnQjAVF9Obwd6iKGCQA8M9P3lbm9e2Vqk9EZxaBAximMK1sXAycmbbRM4CV1RzcPz1KLs%2Fpp%2FuPbSyhg6B8FIuR86IvTqOTs8KOUNLBWDEWxbNtiMXN7v7UxipvCL1K5R%2FuO0sz1tCY0dmL8VJepW8u3Z1terzH0nJQBk%2FC18VqTRkP8wuhpEyApIcb%2FfwUEPmFwnN5OPcHuIbIXimVpLMTwXcnkZcGNtIpNsnvb2hQZhEQ8mcx5LjzDnQqj2LsRLkOAAAAAElFTkSuQmCC)](https://swift.org)

PygmentsKit is a small Cocoa framework that wraps `pygmentize` to obtain pygments tokens, and provides a method for turning these tokens into `NSAttributedString` attributes. PygmentsKit's `AttributedParser` uses tmTheme theme files, making PygmentsKit compatible with TextMate and Sublime Text theme files.

## Requirements
- Xcode 8 or newer
- Mercurial (`hg`) on your `PATH`. You can install mercurial using [homebrew](http://brew.sh) by running `brew install hg`.

## Installation
### Carthage
Add the following line to your project's Cartfile:
```
github "nvgrw/PygmentsKit" "master"
```

Then run `carthage update` and add the PygmentsKit.framework files to your project.

Right now you have to use `"master"` in your Cartfile, as there are no tagged release versions.

### Manually
I recommend that you use [Carthage](https://github.com/Carthage/Carthage), but if you really don't want to or can't, you can also build PygmentsKit manually.

To do this, just open the xcodeproj file and build the framework like normal. If you need a release version, modify the build scheme as required.

There is *no* need to run the `get_pygments.sh` script. This script is used by the Xcode project to download and patch pygments from the project's repository. If you really want to run it manually, make sure that the working directory is the project root directory.

## Using PygmentsKit
### Just Tokens
```swift
import PygmentsKit
// ...
Parser.parse("my code string", with: "pygments lexer identifier") { (range, token) in
	// range is the range within the String.

	// token is an instance of `Token` that contains the token kind and substring
	// within the range.
}
// ...
```

### Tokens and Theme Attributes
To use the `AttributedParser` you must provide a `Theme`. `Theme` loads and stores the scopes and colour attributes of a tmTheme file.

```swift
import PygmentsKit
// ...
// Create a Theme
guard let tmTheme = NSDictionary(contentsOfFile: "my_theme.tmTheme") as? [NSObject: AnyObject] else {
	// handle the error
}

let theme = Theme(data: tmTheme) // this also returns nil if creation fails
// ...
```

You can then parse the code string with the theme:
```swift
// ...
AttributedParser.parse("my code string", with: "pygments lexer identifier", theme: theme) { (range, token, attributes) in
	// attributes is an array of attributes that you can just set or add to your attributed string
}
// ...
```

## Other Stuff
When you create a `Theme`, its constructor also loads the theme's global settings into memory. Global settings include things like the editor background colour, the text colour, the gutter colour, etc. To access these settings, use the `Theme.Global` enum to locate the associated colour in the `global` dictionary property of `Theme`. If the theme does not specify a colour, it will not be in this dictionary.

## License
MIT -- see [LICENSE](LICENSE).
