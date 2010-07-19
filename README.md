Pattern matching in Ruby
========================

This library is an implementation of an ML-style pattern matching
construct for Ruby.

Languages like ML and Haskell feature a pattern matching construct
that allows control flow based on the structure of data.  Some Haskell
examples can be found [here](http://www.haskell.org/tutorial/patterns.html).

Here's an example in Ruby:

    def qsort(a)
      match(a) do

        pattern([]) { [] }

        pattern(Cons(:x, :xs)) { |b| 
          (qsort b[:xs].find_all { |e| e < b[:x] }) +
          [b[:x]] + 
          (qsort b[:xs].find_all { |e| e >= b[:x] })
        }
      end  
    end

match/pattern is analogous to
[case/when](http://www.ruby-doc.org/docs/ProgrammingRuby/html/tut_expressions.html#S5).
A crucial difference is that a pattern match results in a
_binding_, which is passed down to the block.

Symbols are used to denote "placeholder" variables.  These symbols are
the keys into the binding hash provided to the block.

In the above example, `Cons` is a pattern constructor that binds the
head of the array to the first argument and the rest of the array to
the second.

Another example can be found in samples/simplify_expr.rb .


How it works
------------

match/pattern works similar to case/when.  The _target_ or _subject_
of the pattern match is matched against each of the patterns.

The `pattern` function accepts an object and a block.  The object is
the pattern and the block is executed if the target _matches_ the
pattern.

To check if the target matches the pattern, the `pmatch` method is
called on the pattern object; if the pattern object does not have this
method, then the === method is called (just like case/when).  But if
the pattern is a symbol, then it always matches the target, and a
binding of the symbol to the target is generated.

The `pmatch` method of a pattern object must return a binding object,
which is just a hash.  If multiple patterns are present in one pattern
(e.g. using the And pattern constructor) then the bindings are all
"mixed" into one hash.  Duplicate bindings cause an error.

This allows you to define pattern constructors on your own data
structures, by creating functions that return "pattern" objects,
i.e. objects that respond to the `pmatch` method.
