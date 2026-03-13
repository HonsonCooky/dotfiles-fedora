# Principles

"Take care of the pennies, and the dollars take care of themselves."

This is a common principle in finance. In engineering, the pennies are the
ideas; the small, fundamental concepts that everything else is built on. The
dollars are the products, the solutions, the systems. Most people chase the
dollars. They learn the tool, the framework, the platform. They skip the idea
underneath.

Thus: take care of the ideas, and the implementations take care of themselves.


## I. The Problem

Every concept in computing, no matter how many layers of abstraction sit on top
of it, reduces to a collection of simple ideas. An idea, in this context, is the
smallest unit of understanding that cannot be simplified further without losing
meaning. It is not a tool, not a pattern, not a framework. It is the reason
those things exist. A pointer is an idea; a memory address that refers to
another location. Contiguous allocation is an idea; elements stored adjacently
so the hardware can access them efficiently. These are not opinions or
conventions. They are just how the thing works.

The names we give collections of these ideas are just labels; useful for communication, but not for
understanding. The ideas underneath are smaller, more stable, and more
transferable than the labels built on top of them.

Most complexity in this industry comes from learning the label and skipping the
ideas it contains. When that happens, you can operate the tool, but you cannot
reason about it. You end up defending practices you cannot trace back to a real
problem, following rules you cannot explain, and arguing over vocabulary that
only has ambiguity because everyone is reasoning at the wrong layer. When people
cannot agree on what something means, that is usually a signal; they are
probably looking at an abstraction instead of the collection of ideas it
represents.

In my experience, this plays out often. Practices get adopted because someone
said to, not because anyone understood the problem being solved. The arguments
for keeping them are rarely mechanical; they are appeals to convention,
seniority, or some hypothetical future developer who will be confused. Scratch
the surface and there is nothing structural holding the position together.


## II. Manual and Automatic

The best way I have found to explain this is with cars.

Before automatic transmission existed, a driving licence required knowing how to
drive a manual. The automatic made it possible to get on the road without
understanding how a gearbox works; forward, backward, stop. More people could
drive. That is genuinely a net positive.

But tooling lowers the barrier to entry, and lowering the barrier does not fill
in the knowledge that was skipped. The automatic driver can operate the vehicle;
they have not absorbed the ideas that the manual driver was forced to learn: how
gears translate engine speed into wheel speed, why clutch timing matters, what
engine load actually means. The tool made participation possible without
requiring that understanding. That is a trade-off, not a free upgrade.

The two drivers carry different knowledge. The manual driver understands gear
ratios, engine load, and clutch engagement. The automatic driver, freed from
that weight, fills the space with rules: brake before a hill, never exceed a
certain speed in a turn. These rules work fine, until the context changes, and
then they have nothing to fall back on. The manual driver does not need those
rules, because the rules are just logical consequences of the ideas they already
hold.

This maps pretty directly to the distinction between software engineering and
computer science as disciplines. The difference is not prestige or difficulty;
it is whether the education trained you to decompose problems into their
underlying ideas, or to apply known solutions to recognized patterns. A software
engineering curriculum, at least the one I went through, spends four years
forcing you to apply fundamentals to problems you have never seen before. By the
third year, you are not memorizing; you are reasoning from first principles
under pressure. The degree is not the point. The rewiring is.

Engineers who learned "manual" carry fewer rules, because the rules are logical
consequences of ideas they already hold. Engineers who learned "automatic" tend
to accumulate rules as a substitute for the understanding they skipped. When the
environment shifts, one group decomposes the new problem from its ideas. The
other searches for a new set of rules to follow.


## III. Honesty

None of this works without honesty, though. Not honesty with others, although
that helps; honesty with yourself. The willingness to look at something you have
invested real time and effort into and admit that it is not working, that the
framework you were given does not hold up, that the authority you trusted was
just wrong.

This is not a comfortable process. It requires you to accept that starting over
from the foundation is sometimes the only path forward, and that the cost of
doing so is lower than the cost of continuing to build on something unsound. In
engineering terms, you do not patch a structure with a flawed foundation. You
go back to the foundation.

This extends well beyond code, too. I followed conventional nutritional advice
for years; the food pyramid, caloric deficit models, the standard framework. It
did not work. When I stopped following the rules and started learning the actual
ideas, the picture changed. Insulin response, chronic inflammation, how the body
actually processes specific inputs in a sedentary context. The answer was a
smaller set of ideas than the framework had led me to believe, and it worked.
Now, nutritional science is notoriously difficult to study reliably, and nobody
should take my word over their own research. But applying this same approach,
stripping back to the underlying ideas and reasoning from there, has had a
consistent track record with the people around me when applied to specific
health outcomes. The point is not the diet. The point is that the same
philosophy that simplifies software also simplified a problem I had been failing
to solve for years by following inherited rules.

In each case, the answer tends to be a smaller collection of ideas than the
framework that was handed to you. But finding it requires the discipline to
question the framework in the first place, and the honesty to act on what you
find.


## IV. Examples

A linked list is a sequence of elements where each element stores a pointer (a
memory address) to the next. An array requires contiguous allocation; every
element sits adjacent in memory. A linked list trades that constraint for
flexibility, at the cost of extra memory per element to store the pointer. A
queue enforces O(1) insertion and removal; constant time regardless of size.
Combine these ideas and you get a queue that scales without requiring a single
unbroken block of memory. The names didn't tell you that; the ideas did.

Header files (.h) exist because early compilers could not hold an entire program
in memory during compilation. Source files (.c) were compiled independently into
object files (.o); machine code with unresolved references to symbols defined
elsewhere. Header files declared those symbols (function signatures, type
definitions, external variables) so the compiler could verify usage without
seeing the implementation. A linker then resolved the references across object
files into a final binary. Modern languages like Go and Rust prove this
mechanism is no longer necessary; their compilers resolve dependencies across
source files directly. The hardware outgrew the constraint that created the
pattern.

Async/await is cooperative multitasking. A single CPU core executes one
instruction stream at a time, but when a task yields (waiting on I/O, a timer,
a network response), the core switches to another task rather than sitting idle.
Multi-threading is true parallelism; multiple cores each executing their own
instruction stream simultaneously. The online debate about "concurrency vs
parallelism" only exists because people reason about the abstraction (the
language keyword) instead of the mechanism (what the hardware is doing). At the
CPU level, there is nothing ambiguous.


## V. Conclusion

No amount of tooling, configuration, or best practices replaces understanding
what is actually happening. Solutions are environmental; they change with
context, with constraints, with hardware. Ideas do not. They move between
domains, between languages, between problems. Learn the ideas, and the
implementation follows. Skip the ideas, and no amount of rules will save you.

Take care of the ideas, and the implementations take care of themselves.
