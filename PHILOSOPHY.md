# Principles

"Take care of the pennies, and the dollars take care of themselves."

This is a common principle in finance. In engineering, the pennies are the
ideas; the small, fundamental concepts that everything else is built on. The
dollars are the products, the solutions, the systems. Most people chase the
dollars. They learn the tool, the framework, the platform. They skip the idea
underneath.

Thus: take care of the ideas, and the implementations take care of themselves.

The examples here are drawn from software engineering, but the ideas are not.


## I. The Problem

Every concept in computing, no matter how many layers of abstraction sit on top
of it, reduces to a collection of simple ideas. An idea, in this context, is the
smallest unit of understanding that cannot be simplified further without losing
meaning. It is not a tool, not a pattern, not a framework. It is the reason
those things exist. A pointer is an idea; a memory address that refers to
another location. Contiguous allocation is an idea; elements stored adjacently
so the hardware can access them efficiently. These are not opinions or
conventions. They are just how the thing works.

The names we give collections of these ideas are just labels; useful for
communication, but not for understanding. Most complexity in this industry comes
from learning the label and skipping the ideas it contains. When that happens,
you can operate the tool, but you cannot reason about it. You end up defending
practices you cannot trace back to a real problem, following rules you cannot
explain, and arguing over vocabulary that only has ambiguity because everyone is
reasoning at the wrong layer.

When people cannot agree on what something means, that is a signal. They are
looking at an abstraction instead of the collection of ideas it represents.


## II. Manual and Automatic

The best way I have found to explain this is with cars.

Before automatic transmission existed, a driving licence required knowing how
to drive a manual. Learning to drive and learning how the car operates were the
same thing. Then the automatic came along and separated them. Forward, backward,
stop, and you are on the road. The barrier to entry dropped, more people could
drive, and that is genuinely a net positive. But the definition of "knowing how
to drive" quietly changed. It no longer included understanding how gears
translate engine speed into wheel speed, or why clutch timing matters, or what
engine load actually means. The tool made participation possible by removing
the requirement to understand the machine underneath. That is a trade-off, not
a free upgrade.

The manual driver, carrying that mechanical understanding, does not need many
rules. The rules are just logical consequences of ideas they already hold. The
automatic driver, freed from that weight, fills the space with rules instead:
brake before a hill, never exceed a certain speed in a turn. These rules work
fine, right up until the context changes. And then they have nothing to fall
back on.

This maps directly to software. The distinction between software engineering and
computer science, as I experienced it, is not prestige or difficulty. It is
whether the education trained you to decompose problems into their underlying
ideas, or to apply known solutions to recognized patterns. A software
engineering curriculum spends four years forcing you to reason from fundamentals
against problems you have never seen before. By the third year, you are not
memorizing. You are deriving. The degree is not the point. The rewiring is.


## III. Honesty

None of this works without honesty, though. Not honesty with others, although
that helps; honesty with yourself. The willingness to look at something you have
invested real time and effort into and admit that it is not working, that the
framework you were given does not hold up, that the authority you trusted was
just wrong.

You do not patch a structure with a flawed foundation. You go back to the
foundation. That is uncomfortable. It means accepting that starting over is
sometimes the only path forward, and that the cost of doing so is lower than
continuing to build on something unsound.

This extends well beyond code. I followed conventional nutritional advice for
years; the food pyramid, caloric deficit models, the standard framework. It did
not work. When I stopped following the rules and started learning the actual
ideas, insulin response, chronic inflammation, how the body processes specific
inputs in a sedentary context, the answer was simpler than the framework. And it
worked. Nutritional science is notoriously difficult to study reliably, and
nobody should take my word over their own research. But applying this approach,
stripping back to underlying ideas and reasoning from there, has had a
consistent track record with the people around me. The point is not the diet.
The point is that inherited rules failed where first principles succeeded.


## IV. Examples

To illustrate, here is this philosophy applied to a few common topics in
software.

### Linked Lists

A common sentiment is that linked lists are useless. Most people who say this
were taught to memorize them as "a list where each node points to the next,"
compared them unfavorably to arrays, and moved on.

The idea underneath is different. An array requires contiguous allocation; every
element sits adjacent in a single block of memory, which means the sequence has
a bounding limit within that block. A linked list removes that constraint. Each
element stores a reference to the next, and that reference does not have to
point to an adjacent address, or even to the same machine. As long as the
reference resolver can follow it, the storage is unbounded. The idea is not "a
list with pointers." The idea is infinite memory for a sequence.

### Header Files

Ask a newer developer what header files (.h) are for, and the answer is usually
"where you put your declarations." That is the convention, but it is not the
idea.

Early compilers could not hold an entire program in memory during compilation.
Source files (.c) had to be compiled independently into object files (.o);
machine code with unresolved references to symbols defined elsewhere. The
compiler needed a way to verify those references without seeing the full
implementation. Header files solved that by declaring symbols (function
signatures, type definitions, external variables) so each source file could be
checked in isolation. A linker then resolved the references across object files
into a final binary.

This same idea extends to type annotations. Explicit return types in C were not
added for the programmer's benefit; the compiler needed them to generate correct
machine code. It had to know which registers to read and how many bytes to
expect. On the PDP-11 where C was born, an int came back in register R0, a long
in R0:R1, and floats were handled differently again. K&R C let you omit the
return type, but the compiler did not skip the information; it defaulted to int.
Get it wrong and you read garbage. The "for the human" justification came later,
after people forgot the original constraint.

The idea is not "declarations go in .h files" or "always annotate your return
types." The idea is that compilers needed explicit information to generate
correct code under hardware constraints. Modern languages like Go and Rust prove
this; their compilers resolve dependencies across source files directly, infer
return types, and need no headers at all. The hardware outgrew the constraint.
The convention remained.

### Async/Await

The online debate about "concurrency vs parallelism" never reaches consensus.
Nobody can agree, and the reason is that nobody is talking about the hardware.

There are two ideas. Multitasking: a single CPU core executes one instruction
stream at a time, but when a task yields (waiting on I/O, a timer, a network
response), the core switches to another task rather than sitting idle. The core
is never doing two things at once; it is just not wasting time waiting.
Multi-threading: multiple instruction streams executing simultaneously. Nothing
in this idea specifies where those streams execute; they could be on cores in
the same chip, or on machines on opposite sides of the planet.

Take JavaScript, commonly described as "single threaded." If that were the whole
story, how does a browser make network requests while your code continues to
run? How does Node.js utilize multiple cores with worker threads? The label
"single threaded" only describes the runtime's main execution model: one
instruction stream, yielding between tasks so nothing blocks. That is
multitasking. But JavaScript does not live in isolation. The browser delegates
network I/O to the operating system. Node.js spawns actual threads for heavy
computation. A request to a remote server means two instruction streams
executing simultaneously on different hardware. That is multi-threading.

The label "single threaded" is not wrong, but it is incomplete to the point of
being misleading. The ideas underneath have no such ambiguity.

### Git

Many developers treat GitHub like cloud storage. They push to save their work,
pull to get other people's work, and when a merge conflict appears, it feels
like something has gone wrong. It has not. They just never learned what Git
actually is.

Git tracks changes as a directed acyclic graph; it only moves forward and never
loops back on itself. Each commit is a snapshot of the entire project at a point
in time. Each branch is just a pointer, a name that refers to a specific commit.
When you make a new commit, the pointer moves forward. That is all a branch is.
GitHub is a remote host for that graph. These are two separate ideas, and
conflating them is where the confusion starts.

A merge is reconciling two divergent paths in the graph. If two people edited
different files, Git resolves it automatically. If they edited the same lines,
it needs a human decision. That is not a bug; it is correct behavior.

Merge conflicts are not a Git problem; they are a team coordination problem. Two
people editing the same lines means two people were working on the same thing
without talking to each other. Git was designed for version control, not for
sharing code in real time. That is what live development environments and
collaborative editors solve.

This is exactly why companies end up with long internal documents prescribing
single-branch workflows and step-by-step instructions for resolving conflicts.
It is why the industry cycles through branching strategies; Git Flow, GitHub
Flow, trunk-based development, and whatever comes next. Each one is an attempt
to impose order on a tool that teams do not understand, solving a problem the
tool was never designed to solve. If you know what a branch is and what a merge
does, the "right" strategy is just the logical consequence of your team's
deployment needs.


## V. Conclusion

Every example above follows the same pattern. A concept gets a label. The label
gets taught instead of the ideas behind it. People build rules around the label.
The rules accumulate. And when the context changes, there is nothing underneath
to adapt from.

No amount of tooling, configuration, or best practices replaces actually
understanding what is happening. Solutions are environmental; they change with
context, with constraints, with hardware. Ideas do not. A pointer works the same
way regardless of the language. Multitasking works the same way regardless of
the runtime. A graph is a graph whether you are using Git or designing a
network.

The ideas are the pennies. Everything else is dollars.

Take care of the ideas, and the implementations take care of themselves.
