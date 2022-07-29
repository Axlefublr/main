# Character match

`.` -- Any character except newline

`\d` -- Digit [0-9]

`\D` -- Not a Digit [^0-9]

`\w` -- Word character [a-zA-Z0-9_]

`\W` -- Not a Word character [^a-za-z0-9_]

`\s` -- Whitespace [\t \n]

`\S` -- Not Whitespace [^\t \n]

# Boundries

`\b` -- Word boundry

`\B` -- Not a Word boundry

`^` -- Beginning of a string

`$` -- End of the string

# Group structures

`[]` -- Catches any single character in `[]`

`[a-g]` -- Catches any char in range, a range is defined with a `-`

`[^]` -- Catches any single character that is NOT in `[]`

`|` -- Or

`()` -- Group

# Quantifiers

`*` -- 0+

`+` -- 1+

`?` -- 0-1

`{3}` -- Exact number

`{3,4}` -- Range of numbers

# Meta

`\` -- Escape character

# Flags

`g` -- Match more than one occurence

`i` -- Case insensitive

`m` -- Multiline
