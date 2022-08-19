It should be at least one character, not "any amount" (* changed to +)

If a link itself is wrong (or not set), we shouldn't activate chrome with run link, so the steps are done separately 

Ok so turns out you need to use [] syntax entirely, when you're using the json library

Reasoning: you can't set a property with accessor syntax, it will simply not translate to the json, but you *can* using [] syntax

Now either setting the episode or setting the link, when the object doesn't yet exist, creates both properties with null values

Then either one is set, and since the object is already created, they won't be overwritten

