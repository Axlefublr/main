'track' in runner to get the currently playing track to the clipboard

Info disappears slower

Now the separation of show title and link of it is parsed with regex

The show should *always* be first, link second

The amount of spaces between between them doesn't matter

The amount of spaces inside of the show title doesn't matter

All duplicated spaces are replaced to a single space

If there isn't a show object yet, it's created

If there isn't an episode property yet, it's created and set to 0. If it exists, it's not touched

The link is set regardless

For now, all the infos stay

When setting values (while also creating the value if necessary), the access syntax should be used, when you use [] syntax, you can get an error when setting the value for something that doesn't exist yet (which is currently used to only create an object if it doesn't exist)