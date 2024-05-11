# Module 03

In this module we'll take a look at controlling the execution using loops in Perl. Let's start by learning how to implement branching logic using *if* and *if-else* statements.

It's very common that your program needs to execute a code based on certain conditions. You can archive this using the *if* statement. The idea is that along the flow of execution of some routine, some condition needs to be evaluated. If the condition is true, a set of code will be executed, otherwise that set of code will be skipped.

In the following example, based on the given array, print the total number of elements in the array when the size of the array is equal to 4. 

```perl
use strict;
use warnings;

my @cards = ('Visa', 'MasterCard', 'American Express', 'Discover');
my $cards_size = @cards;

if ($cards_size == 4) {
    print "There are $cards_size cards";
}
```

Now let's introduce the use of the *else* statement.

```perl
#!/usr/bin/perl

use strict;
use warnings;

my @cards = ('Visa', 'MasterCard', 'American Express', 'Discover', 'Maestro');
my $cards_size = @cards;

if ($cards_size < 5) {
    print "A few major credit cards will be checked in our log files.";

} else {
    print "Many major credit cards will be checked in our log files.";
}
```

Now let's introduce the use of the *elsif* statement.

```perl
#!/usr/bin/perl

use strict;
use warnings;

my @cards = ();
my $cards_size = @cards;

if ($cards_size < 5 && $cards_size > 0) {
    print "A few major credit cards will be checked in our log files.";

} elsif ($cards_size > 4) {
    print "Many major credit cards will be checked in our log files.";

} else {
    print "No major credit cards will be checked in our log files.";
}
```

The next example shows the use of the *unless* statement, which produces the same result as the *if not* statement `if (!<condition>)`. You can also use the *unless* statement in combination with the *if* and *else* statement. But that may tend to be confusing and not readable.

```perl
#!/usr/bin/perl

use strict;
use warnings;

my @cards = ();
my $cards_size = @cards;

unless ($cards_size > 0) {
    print "No major credit cards will be checked in our log files.\n";
}
```

---

Now we're going to explore another looping construct provided by Perl, the *for* loop. You will use a *for* loop when you need to iterate over all the elements in a collection like a list, array or hash.

In the following example, to each element print the double of it.

```perl
#!/usr/bin/perl

use strict;
use warnings;

my @numbers = (2, 4, 6, 8, 10);

for (@numbers) {
    print "$_ * 2 = " . $_ * 2 . "\n";
}
```

Now let's introduce the use of the *foreach* loop.

```perl
#!/usr/bin/perl

use strict;
use warnings;

my @numbers = (2, 4, 6, 8, 10);

foreach (@numbers) {
    print "$_ * 2 = " . $_ * 2 . "\n";
}
```

There is also a way to loop using the C-style for loop, which is the `for (init; condition; step) { <code> }` syntax.

```perl
#!/usr/bin/perl

use strict;
use warnings;

my @numbers = (2, 4, 6, 8, 10);
for (my $number = 0; $number < 3; $number++) {
    print "@numbers[$number] * 2 = " . @numbers[$number] * 2 . "\n";
}
```

---

Now we're going to learn *while* loop and the *do..while* loop, as well as the scenarios of when to use one or the other.

A *while* loop check the condition first and continue to execute the code block as long as the condition remains true. Once the condition evaluates to false, the loop is terminated. So your code block needs to have some logic that eventually make the checking condition turn false. Otherwise, you will end up in an infinite loop. Unlike a *for* loop, the *while* loop doesn't provide a default iterator, so we need to iterate it ourselves.

Let's check some Perl code illustrating the *while* loop.

```perl
#!/usr/bin/perl

use strict;
use warnings;

my @cards = ("Visa", "MasterCard", "American Express", "Discover", "Maestro");
my $index = 0;

while ($index <= $#cards) {
    print "Actual card in index $index is @cards[$index].\n";
    ++$index;
}
```

Perl offers a variation of the while loop called *do..while* loop as a minor variation between both of them.

In the *while* loop you saw that the condition was checked at the beginning of the loop. Whereas in the *do..while* loop, the condition is checked at the end. You might think what difference does it make? Well, on the *while* loop, there is a possibility that the execution might not even enter the loop. In contrast, the condition is checked at the end in *do.. while* loop, and even if the condition evaluates to false, the loop will be executed at least once.

Let's check some Perl code illustrating the *do..while* loop.

```perl
#!/usr/bin/perl

use strict;
use warnings;

my $index = 0;

do {
    print "This will be printed at least once.\n";
    ++$index;
} while ($index == 0);
```

Let's now consider a business case where another card with the name `Diners` has been added to our card array, and we have been instructed to skip the processing for the `Diners` card. Lets use Perl control statement *next* to achieve it.

```perl
#!/usr/bin/perl

use strict;
use warnings;

my @cards = ("Visa", "MasterCard", "Diners", "American Express", "Discover", "Maestro");
my $index = 0;

while ($index <= $#cards) {
    if ($cards[$index] eq "Diners") {
        print "Skipping $cards[$index] card.\n";
        ++$index;
        next;
    }

    print "Actual card in index $index is @cards[$index].\n";
    ++$index;
}
```

Imagine another scenario where you are instructed not just to skip the process if the `Diners` card is found, but completely stop processing any further. To do so, you can use Perl control statement *last*.

The *last* statement works like a *break* statement that exits the current loop.

```perl
#!/usr/bin/perl

use strict;
use warnings;

my @cards = ("Visa", "MasterCard", "Diners", "American Express", "Discover", "Maestro");
my $index = 0;

while ($new_index <= $#my_cards) {
    if ($my_cards[$new_index] eq "Diners") {
        print "Skipping $my_cards[$new_index] card.\n";
        last;
    }

    print "Actual card in index $new_index is @my_cards[$new_index].\n";
    ++$new_index;
}
```

---

Now we'll learn about the *until* and *do..until* loops. We've seen that a *while* loop will check the condition first and then executes a block of code as the condition remains true. Now an *until* loop is quite the opposite of a *while* loop in the sense that it will run a block of code as long as the condition is false.

Let's check some Perl code illustrating the *until* loop.

```perl
#!/usr/bin/perl

use strict;
use warnings;

my @cards = ("Visa", "MasterCard", "American Express", "Discover", "Maestro");

print "============Until loop==============\n";
my $index = 0;
until ($index > $#cards) {
    print "Actual card in index $index is @cards[$index].\n";
    ++$index;
}
```

The logic above is exactly the same as the *while* loop, only the condition is reversed.

```perl
#!/usr/bin/perl

use strict;
use warnings;

# That's the same code above using a while loop instead.

my @cards = ("Visa", "MasterCard", "American Express", "Discover", "Maestro");

print "============While loop==============\n";
my $index = 0;
while ($index <= $#cards) {
    print "Actual card in index $index is @cards[$index].\n";
    ++$index;
}
```

Now let's check the *do..until* loop. Just like the *do..while* loop, it runs at least once before the loop is terminated, and keeps running as long as the condition is false.

```perl
#!/usr/bin/perl

use strict;
use warnings;

my @cards = ("Visa", "MasterCard", "American Express", "Discover", "Maestro");

print "============do..until loop==============\n";
my $index = 0;
do {
    print "Actual card in index $index is @cards[$index].\n";
    ++$index;
} until ($index > $#cards);
```

Similar to what we saw in the *do..while* loop, we can use the *next* and *last* statements with the *until* loop to control the execution.

Let's see the *next* and *last* statements with the *until* loop.

```perl
#!/usr/bin/perl

use strict;
use warnings;

print "============Next instruction and eq operator==============\n";
my @my_cards = ("Visa", "MasterCard", "Diners", "American Express", "Discover", "Maestro");
my $new_index = 0;

until ($new_index > $#my_cards) {
    if ($my_cards[$new_index] eq "Diners") {
        print "Skipping $my_cards[$new_index] card.\n";
        ++$new_index;
        next;
    }

    print "Actual card in index $new_index is @my_cards[$new_index].\n";
    ++$new_index;
}

print "============Last statement==============\n";
$new_index = 0;

until ($new_index > $#my_cards) {
    if ($my_cards[$new_index] eq "Diners") {
        print "Skipping $my_cards[$new_index] card.\n";
        last;
    }

    print "Actual card in index $new_index is @my_cards[$new_index].\n";
    ++$new_index;
}
```

---

Now we're going to learn the Perl *given-when* statement. You could use an *if* statement to evaluate conditional logic, but what if there are multiple conditions presented? Your code will look cluttered and hard to read. If you have some foundation on languages like C, and Java, you must be familiar with the *switch* statement. However, Perl doesn't offer one, instead it provides the *given-when* statement.

If you plan to use this feature, you need to remember a few things:

1. That is a feature available on Perl 5.0.10+, so use the pragma `use feature 'switch'` or `use v5.0.10` to enable it.
2. This feature also uses a Perl __smartmatch__ operator `~~`, which is still in experimental status.

It behaves like: when the expression returns the first value, the first code block is executed, if not, the expression is rechecked, and if it returns the second value, the second code block is executed, if not, the expression is rechecked, and so on. You can write a *default* section that will be used for cases that are not handled by any specific values, just like a catch-all bucket. 

Now let's check some Perl code illustrating the *given-when* statement. The requirement is to prompt the user to enter a credit card type, and if it's one of the Visa, Master, Amex, or Discover, we need to print a message that our utility will check for the entered card type. If the user enters something else, we need to print a default message saying `Unrecognized card type`.

```perl
#!/usr/bin/perl

use strict;
use warnings;

use feature 'switch';

print "Enter a credit card type: ";

given (<STDIN>) {
    when (/^Visa$/) {
        print "Visa card detected.\n";
    }
    when (/^MasterCard$/) {
        print "MasterCard card detected.\n";
    }
    when (/^American Express$/) {
        print "American Express card detected.\n";
    }
    when (/^Discover$/) {
        print "Discover card detected.\n";
    }
    default {
        print "Unrecognized card type.\n";
    }
}
```

## Summary

We reached the end of this module. Let's recap what we've learned so far:

1. Implementing branching logic using if, elsif, and else statements
2. Implementing if not logic using Perl unless
3. Iterate over collections using for loop
4. Setup conditional logic using while and do..while, and until and do..until
5. Setup looping logic using next and last
6. Implementing switching logic using Perl given-when
