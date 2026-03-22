# Philosophy

There is an old saying in finance: "take care of the pennies, and the dollars take care of themselves."

I have been chewing on a version of that for years now. My degree taught me to think in pennies; the small, fundamental
ideas that everything else is built on. Pointers, memory layout, what a compiler actually needs and why. Then I entered
the industry, and the industry does not care about pennies. It cares about dollars; the product, the framework, the
platform. Ship it, scale it, move on. I spent three years learning to play that game, and the whole time something felt
wrong.

Where others settled into it, I could not. The friction between what I had been trained to do and what the industry
rewarded kept pulling me back toward an understanding I already had but could not yet put into words: take care of the
ideas, and the implementations take care of themselves. Writing this document is part of that process. Being able to
explain something simply is a good way to find out whether you actually understand it.

None of this arrived as a single realization. It has developed over time, driven by pain points I have encountered and
areas in my life I have needed to understand so I can find some inner peace. The examples here are drawn from software
engineering, but the ideas are not.


## I. The Problem

A way of thinking about this: every concept in computing, no matter how many layers of abstraction sit on top of it, reduces
to a collection of simple ideas. What I mean by "idea" is the smallest unit of understanding that cannot be simplified
further without losing meaning. It is not a tool, not a pattern, not a framework. It is the reason those things exist. A
pointer is an idea; a memory address that refers to another location. Contiguous allocation is an idea; elements stored
adjacently so the hardware can access them efficiently. These are not opinions or conventions. They are just how the
thing works.

The way I see it, the names we give collections of these ideas are just labels; useful for communication, but not for
understanding. In my experience, most complexity in this industry comes from two places. First, labels becoming the
baseline; people learn the name, skip the ideas it contains, and treat the label itself as understanding. Second, people
who benefit from that confusion; whether through ignorance or intent, complexity that nobody questions is complexity that
ensures job security. When those two forces combine, I end up unable to defend practices I cannot trace back to a real
problem, forced to adopt rules I cannot explain, and stuck arguing over vocabulary that only has ambiguity because
everyone is reasoning at the wrong layer.

I saw this constantly in the corporate roles I held. Someone, somewhere, discovers a way to
overcome a problem and finds success. The idea gets adopted more broadly and finds some more success. But over time it
loses meaning, carried forward by people who never understood the problem it originally solved. Nobody notices when it
becomes a legacy idea, still practiced long after the problem it addressed no longer exists.

When people cannot agree on what something means, that is usually a signal. They are looking at an
abstraction instead of the collection of ideas it represents.


## II. Manual and Automatic

The best way I have found to explain this is with cars.

Before automatic transmission existed, a driving licence required knowing how to drive a manual. Learning to drive and
learning how the car operates were the same thing. Then the automatic came along and separated them. Forward, backward,
stop, and you are on the road. The barrier to entry dropped, more people could drive, and that is genuinely a net
positive. But the definition of "knowing how to drive" quietly changed. It no longer included understanding how gears
translate engine speed into wheel speed, or why clutch timing matters, or what engine load actually means. The tool made
participation possible by removing the requirement to understand the machine underneath. That is a trade-off, not a free
upgrade.

The manual driver, carrying that mechanical understanding, does not need many rules. The rules
are just logical consequences of ideas they already hold. The automatic driver, freed from that weight, fills the space
with rules instead: accelerate through the corner, do not exceed a certain speed in a turn. Good rules, but learnt
without understanding the physics behind why they work. They hold up fine, right up until the context changes. And then
there is nothing to fall back on.

This maps directly to software. The distinction between software engineering and computer science, as I experienced it,
is not prestige or difficulty. It is whether the education trained me to decompose problems into their underlying ideas,
or to apply known solutions to recognized patterns. My software engineering curriculum at Victoria University of
Wellington spent four years forcing me to reason from fundamentals against problems I had never seen before. By the third
year, I was not memorizing. I was deriving. The degree was not the point. The rewiring was.

Margaret Hamilton coined the term "software engineering" in the 1960s to argue that what her team was doing on the Apollo
missions deserved the same rigour and legitimacy as any other engineering discipline. The 1968 NATO conference adopted it
deliberately, as a provocation to the computing community. From the beginning, the term was aspirational; a claim that
building software should require engineering discipline. In some places that aspiration was formalized; in Canada
"engineer" is a legally protected title, and a few US states license software engineers specifically. In New Zealand,
IPENZ recognizes software engineering and offers chartered status, but the title itself is not restricted by law.

In practice, the industry outgrew whatever signal the title once carried. Bootcamp graduates, self-taught developers,
and career switchers all adopted the same label, and I do not begrudge them that. More people building software is a net
positive, the same way more people driving is a net positive. But the term used to carry an informal assumption; that
two people holding it would think about problems in a similar way, that they shared a foundation in decomposition and
reasoning from fundamentals. That assumption is gone, and nothing replaced it. There is no word I can use to find the
people who think the way I was trained to think. That is the frustrating part. Not that the title was taken; it was
never formally held in most places. But the shared understanding it once carried was dissolved, and no replacement signal
emerged.

After graduating, I spent three years in the corporate world across two companies. The industry pulled me
toward the dollars. I looked for mentors who could bridge the gap. I found people who were interesting, a few who were
as dedicated to the craft as I was. But none who had the lower-level systems knowledge and fundamentals down. Decisions
were made based on other people's sentiment, and nobody could offer genuine insight into why we had arrived at the
conclusions and ways of working that we had. That friction, between what I had been trained to do and what the industry
rewarded, is what eventually brought me back to the fundamentals.


## III. Examples

To illustrate, here is this philosophy applied to a few common topics in software.

### Linked Lists

A common sentiment is that linked lists are useless. Most people who say this were taught to memorize them as "a list
where each node points to the next," compared them unfavorably to arrays, and moved on.

The idea underneath is different. An array requires contiguous allocation; every element sits adjacent in a single block
of memory, which means the sequence has a bounding limit within that block. A linked list removes that constraint. Each
element stores a reference to the next, and that reference does not have to point to an adjacent address, or even to the
same machine. As long as the reference resolver can follow it, the storage is unbounded. The idea is not "a list with
pointers." The idea is infinite memory for a sequence.

### C and Its Legacy

Early compilers could not hold an entire program in memory during compilation. Two conventions emerged from that
constraint, and both outlived it.

#### Header Files

Ask a newer developer what header files (.h) are for, and the answer is usually "where you put your declarations." That
is the convention, but it is not the idea.

Source files (.c) had to be compiled independently into object files (.o); machine code with unresolved references to
symbols defined elsewhere. The compiler needed a way to verify those references without seeing the full implementation.
Header files solved that by declaring symbols (function signatures, type definitions, external variables) so each source
file could be checked in isolation. A linker then resolved the references across object files into a final binary.

The idea is not "declarations go in .h files." The idea is that compilers needed explicit information to generate
correct code under hardware constraints. Modern languages like Go and Rust have no header files at all; computing is
now fast enough that the compiler can resolve dependencies across source files directly. The hardware outgrew the
constraint. The convention is dying out now, but it persisted for a long time before anyone questioned it.

#### Type Annotations

Explicit return types in C were not added for the programmer's benefit; the compiler needed them to generate correct
machine code. It had to know which registers to read and how many bytes to expect. On the PDP-11 where C was born, an
int came back in register R0, a long in R0:R1, and floats were handled differently again. K&R C let you omit the return
type, but the compiler did not skip the information; it defaulted to int. Get it wrong and you read garbage. The "for
the human" justification came later, after people forgot the original constraint.

That justification is fine as a starting point. But if readability is the real goal, it is worth asking whether strong
type annotations are actually the most human-readable approach, or just the one we inherited from a compiler constraint
and retrofitted a new reason onto. JavaScript and Python are the most widely adopted languages in the world, and neither
started with mandatory type annotations. That does not prove anything on its own, but it is worth sitting with. If the
original reason for type annotations was the compiler, and the compiler no longer needs them, then the question of what
actually helps the human is wide open again; and the answer might not be what we inherited.

### Async/Await

The online debate about "concurrency vs parallelism" never reaches consensus. Nobody can agree, and the reason might be
that nobody is talking about the hardware.

A CPU core can only execute one instruction at a time. Everything else is a strategy for making it seem like more is
happening. Multitasking is the simplest: when a task has nothing to do (waiting on I/O, a timer, a network response),
the core switches to another task rather than sitting idle. It is never doing two things at once; it is just not wasting
time waiting. Multiplexing goes further; the core switches between tasks so rapidly that they appear to run
simultaneously, even when none of them are waiting. The illusion of parallelism, created by speed alone.
Multi-threading is actual simultaneous execution; multiple instruction streams running at the same time across multiple
cores, or even across machines on opposite sides of the planet.

Take JavaScript, commonly described as "single threaded." If that were the whole story, how does a browser make network
requests while your code continues to run? How does Node.js utilize multiple cores with worker threads? The label
"single threaded" only describes the runtime's main execution model: one core, multiplexing between tasks via the event
loop so nothing blocks. But JavaScript does not live in isolation. The browser delegates network I/O to the operating
system on separate threads. Node.js spawns actual OS threads for heavy computation. A request to a remote server means
two instruction streams executing simultaneously on different hardware. That is multi-threading.

The label "single threaded" is not wrong, but it is incomplete to the point of being misleading. The ideas underneath
have no such ambiguity.

### Git

Many developers treat GitHub like cloud storage. They push to save their work, pull to get other people's work, and
when a merge conflict appears, it feels like something has gone wrong. It has not. They just never learned what Git
actually is.

Git tracks changes as a directed acyclic graph; it only moves forward and never loops back on itself. Each commit is a
snapshot of the entire project at a point in time. Each branch is just a pointer, a name that refers to a specific
commit. When you make a new commit, the pointer moves forward. That is all a branch is. GitHub is a remote host for
that graph. These are two separate ideas, and conflating them is where the confusion starts.

A merge is reconciling two divergent paths in the graph. If two people edited different files, Git resolves it
automatically. If they edited the same lines, it needs a human decision. That is not a bug; it is correct behavior.

Merge conflicts are not a Git problem; they are a team coordination problem. Two people editing the same lines
means two people were working on the same thing without talking to each other. Git was designed for version control, not
for sharing code in real time. That is what live development environments and collaborative editors solve.

This is exactly why companies end up with long internal documents prescribing single-branch workflows and
step-by-step instructions for resolving conflicts. It is why the industry cycles through branching strategies; Git Flow,
GitHub Flow, trunk-based development, and whatever comes next. Each one is an attempt to impose order on a
tool that teams do not understand, solving a problem the tool was never designed to solve. When I understand what a
branch is and what a merge does, the "right" strategy is just the logical consequence of my team's deployment needs.


## IV. Honesty

Everything above is the philosophy. This section is about what it actually costs to live it.

Learning, real learning, requires neural pathway adaptation. The brain has to build new connections and let old ones
weaken, and that process is not rewarding in the moment. There is no dopamine hit for sitting with confusion, no
immediate payoff for admitting that something you relied on does not hold up. University was hard and at times
depressing, and I only understand now, having looked a little further into how the brain works, that it had to be. The
discomfort was the adaptation happening. The tools I came away with were not the languages; they were the ideas, and the
ability to derive new ones.

The industry does not reward this. The environment I work in optimizes for output, not understanding. Ship the feature,
close the ticket, move on. There is no line item for going back to foundations, no quarterly metric for "validated
whether this practice still solves a real problem." The system selects for people who can operate the tool, not for
people who understand the machine underneath. That is not a complaint; it is just the environment. Understanding it is
necessary for navigating it honestly.

Honesty with myself is the hardest part. The willingness to look at something I have invested real time and effort into
and admit that it is not working, that the framework I was given does not hold up, that the authority I trusted was just
wrong. I do not patch a structure with a flawed foundation. I go back to the foundation. That is uncomfortable, but the
cost of continuing to build on something unsound is always higher.


I am not under any illusion that this attitude scales without others who share it. It does not. But it is important to
me, and it is the foundation I am building from.


## V. Conclusion

Ideas do not change with context. Solutions do. Take care of the ideas, and the implementations take care of
themselves.
