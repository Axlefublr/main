* scawy

At first, objects seem scary, but once you learn how to use them you will love them!

* no objects

In v1, objects very much exist, but aren't used in places where they make a lot of sense to be in

For example,

* it's bad

v1 has this janky global variable "ErrorLevel",

* heard

that gets updated by many commands

You used to have to use it to check what a command "returns"

Well sike, commands don't return anything, and Errorlevel can technically change at any moment

* weird

Often you actually had to save Errorlevel to a temporary variable, to check the value later.

Why would we need a middle man now?

Wouldn't it be better if the command just *returned* the value we want?

* much better

Well yes, and v2 does exactly that.

As you may already know, v2 replaced all commands with functions

* even better

and removed the need for errorlevel by just returning the value

* come in

That's exactly where objects come in

* vars

For functions that return multiple values, we got a nice bundle of them

* nicer

We can use the object that's returned to *have* the cake *and* eat it

* gui

Let's have a look at guis

In v1, they occupied the global space, and were an overall pain in the ass to contain

* id

You call the id of the gui

* whatever

and then do whatever with it

* oop

In v2, you don't have to deal with that: guis are object oriented

You can easily have a gui in a function, and overall, have as many guis as you want in a single script, without any hassle

* operate

That's because you get the object of the gui, and then operate on that object

You won't need to worry about affecting some other gui in any way.

* obj

"Object" is actually a really broad abstraction

* array

Arrays are objects,

* maps

and so are maps

* methfunc

And both of them have their own properties and methods

* what

Now hold on, Axlefublr (if that's even your real name), what are properties and methods?

* simple

The difference is actually really simple

I laughed my ass off when I learnt it

* var

Here I'm using a variable

* funk

and calling a function

* obj var

Now I'm using a *property*

* obj meth

and calling a *method*

* benin

Yes, the only difference between a normal variable and a property, a function and a method is belonging.

* beninging

Properties and methods *belong* to something, like a class or an object 

* benin

And to refer to a property or method, you first have to access the object

