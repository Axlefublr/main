I thought I couldn't make the regex map in runner static, but I actually absolutely can! All that was needed is a way to pass the result[2], which was the only differing part of the equasion.

Now the map only needs to be created once, and then the value is passed