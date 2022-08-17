# GetLink general idea:

Show_GetLink() compiles a link by reading the object of the show in the json file

You give it a show name, that show has its key

The value of that key is an object

It has the link property and an episode property

Concatenates the link and the episode (plus one) and returns it

# Features:

Safety on every step

If the key of the show doesn't exist, returns an empty string and says that the show doesn't exist

If the link doesn't exist, says so and returns an empty string

If the episode doesn't exist, sets it to 0 (which becomes 1), updates the json, and continues running