# VHDL Cheatsheet

**VHDL** : **V**HSIC **H**ardware **D**escriptive **L**anugage<br>
**VHSIC** : **V**ery **H**igh **S**cale **I**ntegrated **C**ircuit
<br>

#### ⚠ Think in Hardware ⚠

## Content
1. [Introduction](https://github.com/Notes-MD/VHDL#introduction)
   - [Simulate or Model](https://github.com/Notes-MD/VHDL#simulate-or-model)
   - [Synthesize to hardware](https://github.com/Notes-MD/VHDL#synthesize-to-hardware)
   - [Descriptions (uses at different levels)](https://github.com/Notes-MD/VHDL#descriptions-uses-at-different-levels)
     - [Behavioural](https://github.com/Notes-MD/VHDL#behavioural)
     - [Data Flow](https://github.com/Notes-MD/VHDL#data-flow)
     - [Structural](https://github.com/Notes-MD/VHDL#structural)
   - [Design approaches](https://github.com/Notes-MD/VHDL#design-approaches)
     - [Top Down](https://github.com/Notes-MD/VHDL#top-down)
     - [Structureal VHDL](https://github.com/Notes-MD/VHDL#structureal-vhdl)
     - [RTL (Register Transfer Level) VHDL](https://github.com/Notes-MD/VHDL#rtl-register-transfer-level-vhdl)
     - [Signal assignment](https://github.com/Notes-MD/VHDL#signal-assignment)
     - [Ongoing changes](https://github.com/Notes-MD/VHDL#ongoing-changes)
2. [Delta Delays δ](https://github.com/Notes-MD/VHDL#delta-delays-%CE%B4)
3. [Vectors](https://github.com/Notes-MD/VHDL#vectors)
4. [Conditional Assignment](https://github.com/Notes-MD/VHDL#conditional-assignment)
   - [4 Ways of implemention](https://github.com/Notes-MD/VHDL#4-ways-of-implemention)
5. [Modules](https://github.com/Notes-MD/VHDL#modules)
   - [Entity](https://github.com/Notes-MD/VHDL#entity)
   - [Architecture](https://github.com/Notes-MD/VHDL#architecture)
   - [VHDL Entity & Ports](https://github.com/Notes-MD/VHDL#vhdl-entity--ports)
   - [Component Pins & VHDL Ports](https://github.com/Notes-MD/VHDL#component-pins--vhdl-ports)
   - [Hierarchy](https://github.com/Notes-MD/VHDL#hierarchy)
   - [VHDL Signals](https://github.com/Notes-MD/VHDL#vhdl-signals)
6. [Constants](https://github.com/Notes-MD/VHDL#constants)
7. [Aliases](https://github.com/Notes-MD/VHDL#aliases)
   - [Type System (Datatypes)](https://github.com/Notes-MD/VHDL#type-system-datatypes)
   - [IEEE Standard Logic](https://github.com/Notes-MD/VHDL#ieee-standard-logic)
8. [Arrays](https://github.com/Notes-MD/VHDL#arrays)
   - [Vectors: 1 dimension Arrays](https://github.com/Notes-MD/VHDL#vectors-1-dimension-arrays)
   - [Aggregates](https://github.com/Notes-MD/VHDL#aggregates)
   - [Example: Read Only Memory](https://github.com/Notes-MD/VHDL#example-read-only-memory)
9. [Operators](https://github.com/Notes-MD/VHDL#operators)
   - [Operators from highest preference](https://github.com/Notes-MD/VHDL#operators-from-highest-preference)
   - [Theory](https://github.com/Notes-MD/VHDL#theory)
10. [Example Design: Dice](https://github.com/Notes-MD/VHDL#example-design-dice)
