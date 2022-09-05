;No dependencies

;StrLen("string") => "string".Length
PrimDefineProp("".base, "Length", {Get: StrLen})