# Module 02

We'll initiate this module talking about **constants**, **literals**, and **variables**. 

Perl is not a strongly typed language, because a strongly typed language has explicit type declaration like: integer, float, string, etc. On strongly typed languages, type checking is performed during compile time.

Perl performs implicit conversion during runtime. There are no individual types for integer, string, and float in Perl. Instead, they are categorized as **scalar types**, but Perl also supports complex data types like lists, arrays, and hashes.

Now imagine your requirement states that your utility needs to scan for four different cards, and they are not going to change this requirement.

To declare a constant in Perl, you just write:

```perl
use constant num_cards => 4;
```

Pay attention to the assignment operator used to assign an integer value, the `=>`. A constant in Perl can be a number, string, or even a mathematical expression with the condition that the result of the expression must result in a scalar value. As already mentioned, we do not need to define the type of the constant.

Let's turn our attention to literals. As the name suggests, a literal is a hard coded value in your script, so you can have a numeric or a string literal. For example, the `\n` character is a literal.

Unlike constants, a string literal is not assigned to anything and can't be reused elsewhere in your program.

Now talking about variables, a variable is used to hold a piece of data to be reused in the program. Any Perl variable must begin with a dollar sign `$`.

When writing Perl variables and constants, you need to remember that they're case-sensitive, and they also must start with a letter or an underscore. Hyphen and spaces are also not allowed for naming them.

Now we're going to take a look about some Perl features that helps us in proper error handling.

```perl
#!/usr/bin/perl

$card1 = "1234-1234-1234-1234";

print "Card number: $Card1\n";

# output: Card number: Card1
```

We can see that because Perl variables are case-sensitive, we can't output the expected value in our print statement, however the misspelling is identified as an error which may cause some problems as we evolve our script.

```perl
#!/usr/bin/perl

use strict;

$card1 = "1234-1234-1234-1234";

print "Card number: $Card1\n";

# output:
#Global symbol "$Card1" requires explicit package name (did you forget to declare "my $card1"?)
#Execution of file.pl aborted due to compilation errors.
```

Now our script failed with compilation errors. The `strict` pragma scans your script and looks for expressions and statements which may lead to potential errors.

The `strict` pragma also expects that the variable be declared explicitly before assigning it the value. Any variable that is declared using `my` keyword is considered lexically scoped, in the sense that this variable is accessible only inside the block in which it was defined. We're going to learn blocks and scopes shortly.

```perl
#!/usr/bin/perl

use strict;

my $card1 = "1234-1234-1234-1234";

print "Card number: $card1\n";

# output:Card number: 1234-1234-1234-1234
```

---

### Code blocks and code scopes

Let's learn about scopes and blocks now.

In Perl, you define a block with a pair of curly braces `{}`, and all the variables, expressions, and statements within those braces are considered to be visible only within that pair of curly braces, this section of code is called an anonymous block.

```perl
#!/usr/bin/perl

use strict;

my $card_num_length = 12; # 12 digits
my $sec_code_length = 3; # 3 digits

{
    my $total_length = $card_num_length + $sec_code_length;
    say "Total length: $total_length";
}

say "Total length now is: $total_length";
```

How many lines will be printed to console when we run the above code? Nothing will be printed because the variable `total_length` is only visible within the anonymous block. 

> Global symbol "$total_length" requires explicit package name (did you forget to declare "my $total_length"?)

We can easily fix it by changing the scope of `total_length` to the main block.

```perl
#!/usr/bin/perl

use strict;

my $card_num_length = 12; # 12 digits
my $sec_code_length = 3; # 3 digits
my $total_length;

{
    my $total_length = $card_num_length + $sec_code_length;
    say "Total length: $total_length";
}

say "Total length now is: $total_length";
```

Now it should be fixed and printed, right? Yes it will print, but only the first line will display the total length correctly.

```
Total length: 15
Total length now is:
```

We're seeing this to reinforce that Perl treats `total_length` as two independent variables. The `total_length` variable outside the block has no clue of the variable with same name inside the block and vice versa.

```perl
#!/usr/bin/perl

use strict;

my $card_num_length = 12; # 12 digits
my $sec_code_length = 3; # 3 digits
my $total_length;

{
    $total_length = $card_num_length + $sec_code_length;
    say "Total length: $total_length";
}

say "Total length now is: $total_length";
```

What's expected to be printed? If you guessed: 

```
Total length: 15
Total length now is: 15
```

Then you're totally right. The `my` keyword is a differentiator. At the moment Perl sees the `my` keyword, it creates a new variable within the anonymous block scope. Once we remove it, it continued with a variable with the same name in the main block scope.

To end this lesson, just pay attention to all the interpolations we've seen so far. Perl doesn't require explicit type casting to print a variable. But that feature is only available for print statements that are inside double quotes `""`. Interpolation using single quotes `''` is not supported because it treats all characters literally, thus not differentiating a variable from a string.

---

### Operators

Let's move and explore the different operators supported in Perl, starting with the numeric ones.

Before looking at numeric operators, let's understand Perl numbers better. By default, all the numbers in Perl are expressed as base 10, but you can display a binary number by prefixing it with `0b`, a hexadecimal number by prefixing it with `0x` or `0X`, and an octal number by prefixing it with `O`.

```perl
#!/usr/bin/perl

#valid number representation in perl

$base_ten_number = 10;
$binary_number = 0b1010;
$hexadecimal_number = 0xA;
$octal_number = 012;

print "Base ten number: $base_ten_number\n";
print "Binary number: $binary_number\n";
print "Hexadecimal number: $hexadecimal_number\n";
print "Octal number: $octal_number\n";
```

Any number with a decimal point `.` is considered a floating-point number. All other numbers are integers.

Perl supports many arithmetic operations, let's show them in action:

```perl
#!/usr/bin/perl

use strict;
use warnings;

print "5 + 5 equals to :", 5 + 5, "\n";
print "5 - 5 equals to :", 5 - 5, "\n";
print "5 * 5 equals to :", 5 * 5, "\n";
print "5 / 5 equals to :", 5 / 5, "\n";
print "5 % 5 equals to :", 5 % 5, "\n";
print "5 ** 5 equals to :", 5 ** 5, "\n";
```

Perl follows operators precedence, so division and multiplication are evaluated first, then addition and subtraction.

```perl
#!/usr/bin/perl

use strict;
use warnings;

# It will print: 30
print "5 + 5 * 5 equals to: ", 5 + 5 * 5, "\n";

# Now will print: 50
print "(5 + 5) * 5 equals to: ", (5 + 5) * 5, "\n";
```

Now let's turn our attention to logical operators, but before that, let's understand better about boolean values.

Boolean values can be either `true` or `false`. In Perl, a true value is represented by integer `1` and a false value is represented by integer `0`. There are no true and false values or strings in Perl for boolean representation.

Perl supports logical operations like `AND`, `OR`, and `NOT`.

A logical `AND` is true if all the operands are true, is represented by two ampersand sign `&&` or the word `and`. The following table illustrates how logical `AND` works:

| Operand 1 | Operand 2 | Result |
|:---------:|:---------:|:------:|
| TRUE      | TRUE      | TRUE   |
| FALSE     | TRUE      | FALSE  |
| TRUE      | FALSE     | FALSE  |
| FALSE     | FALSE     | FALSE  |

A logical `OR` is true if any of the operands is true, is represented by two pipe sign `||` or the word `or`. The following table illustrates how logical `OR` works:

| Operand 1 | Operand 2 | Result |
|:---------:|:---------:|:------:|
| TRUE      | TRUE      | TRUE   |
| FALSE     | TRUE      | TRUE   |
| TRUE      | FALSE     | TRUE   |
| FALSE     | FALSE     | FALSE  |

A logical `NOT` is true if the operand is false, because it reverses the boolean value, is represented by the exclamation sign `!`. The following table illustrates how logical `NOT` works.

| Operand 1 | Result |
|:---------:|:------:|
| TRUE      | FALSE  |
| FALSE     | TRUE   |


```perl
#!/usr/bin/perl

use strict;
use warnings;

my $val_true = 1;
my $val_false = 0;

print "Logical AND: ", $val_true && $val_false, "\n";
print "Logical OR: ", $val_true || $val_false, "\n";
print "Logical NOT: ", !$val_true, "\n";
```

Let's switch gears, and learn about Perl strings and string operators.

A string is a sequence of characters, enclosed in double or single quotes. Perl strings contain ASCII, UNICODE, and escape sequences characters such as `\n`.

To quote a string that contains speech marks or apostrophes, Perl provides two quote operators: **q** for literal quotes and **qq** for interpolated quotes. The quote operators let the programmer define the encapsulating characters for the string - simply choose characters that are not contained in your string:

```perl
#!/usr/bin/perl

use strict;
use warnings;

my $user = q/sillymoose/; # single quotes
#my $user = qq/sillymoose/; # double quotes
my $difficult_string_interpolated = qq{Welcome $user.\nWhilst you are are here, you can "do as they do in Rome" and enjoy yourself};
print $difficult_string_interpolated;
```


```perl
#!/usr/bin/perl

use strict;
use warnings;

my $name = 'Salamanca';
print length($name);
print lc($name);
print uc($name);
```

To learn more about Perl operators check [here](https://perldoc.perl.org/perlop). Useful Perl functions [here](https://perldoc.perl.org/functions)

Apart from offering functions, Perl offers strings operators as well. You can concatenate strings using the `.` operator, and duplicate strings using the `x` operator.

```perl
#!/usr/bin/perl

use strict;
use warnings;

my $name = 'Salamanca';
print "Mr." . $name, "\n";
print $name x 2, "\n";
```

---

### Lists and Arrays

Until now, we saw scalar variables, like numbers and strings. What if we need to store a list of values, like a list of all employee titles in your office, list of branch locations of your office, and so on?

It's just not practical to store each value in an individual scalar variable. Perl lets you group related scalar values into a list.

A list is an ordered sequence of integers and strings. A list can contain other lists. You can use the `@` operator to create a list, and the elements are enclosed in parentheses, separated by commas.

```perl
#!/usr/bin/perl

use strict;
use warnings;

print (1, 2, 3, 4, 5), "\n";
```

As we saw, the print function will not add a space between the values that are not part of the list, but we can use the `join` function to add a space between the values.

```perl
#!/usr/bin/perl

use strict;
use warnings;

print (join(', ', (1, 2, 3, 4, 5)), "\n");
```

We can also combine lists that mix integer and string values.

```perl
#!/usr/bin/perl

use strict;
use warnings;

print ((('a', 'b', 'c'), (4, 5, 6)), "\n");
```

Perl has no problem creating a complex list and combines the string and integer elements. This process is called **flattening**. If I had a list of lists, “flatten” would be the operation that returns a list of all the leaf elements in order, i.e., something that changes:

```
[[a, b, c], [d, e, f], [g, h i]]
```

Into:

```
[a, b, c, d, e, f, g, h, i]
```

The `qw` function creates a list based on strings passed to it separated by spaces.

```perl
#!/usr/bin/perl

use strict;
use warnings;

print qw(b 2 c), "\n";
```

Imagine you wanted to access a specific element in your list. Perl lets you do it using the indexing operator:

```perl
#!/usr/bin/perl

print ((1, 2, 3, 4, 5)[2], "\n");
```

Until here you've learned about Perl lists, that are **immutable**. An immutable object means that its content cannot be changed after it is created. But in practical business scenario, that is hardly the case. You may need to change the employee titles as new jobs positions are introduced, you may need to add or delete branch locations as new locations get added. For that, you can use Perl arrays.

In the Perl community, lists and arrays are often used interchangeably, and the subtle difference is not known to everyone. The main difference between them:

| Perl List     | Perl Array     |
|:-------------:|:--------------:|
| Immutable     | Mutable        |
| Static object | Dynamic object |

As we've learned, a scalar variable is defined with a dollar sign, arrays are defined with the at sign.

```perl
#!/usr/bin/perl

use strict;
use warnings;

my @list = (1, 2, 3, 4, 5);
print $list[2], "\n";
```

Perl doesn't require explicit casting to cast from one type to the other. When you assign an array to a scalar variable, the length of the array is assigned to the scalar variable. 

Perl also has a special operator `$#` that returns the highest index of the array.

```perl
#!/usr/bin/perl

use strict;
use warnings;

my @list = (1, 2, 3, 4, 5);
my $var = @list;

print ("Total of $var elements, and the highest index is $#list. \n");
```

---

### Hashes

Now we're going to learn another complex data type called **hash**.

Unlike list and arrays, which are a collection of scalar values, each element in a hash is represented as a key-value pair.

Imagine, along with storing the job titles, you also wanted to store the salaries corresponding to each title. You cannot store this relationship using an array, and Perl hash come to the rescue. Whenever you want to fetch the salary corresponding to a job title, you can perform a single lookup in the hash for the job title, and fetch the salary.

Let's see hash data type in action, a hash variable is defined with a percentage sign.

```perl
#!/usr/bin/perl

use strict;
use warnings;

my %hash = ('a' => 1, 'b' => 2, 'c' => 3);
print $hash{'b'}, "\n";

print("Value of the first element is $hash{'a'}\n");

print("All keys on the hash: ", keys(%hash), "\n");
print("All values on the hash: ", values(%hash), "\n");

$hash{d} = 4;
print("Value of the added element is $hash{'d'}\n");
```

## Summary

Let's recap what we've learned so far:

- Perls constants, literals, and variables, what is a scalar variable, and how to define it.
- Blocks and scopes, and how Perl performs variable interpolation.
- Numbers and strings, and also arithmetic, logical, and string operators.
- Storing sequence of related data in lists and arrays, and the difference between them, so as common operations they support.
- Finally, hashes and how to store and fetch data from them.
