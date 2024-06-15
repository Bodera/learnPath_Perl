# Module 06

This is the module __Creating Reusable Code Using Subroutines and References__.

We will start learning about Perl references. And before we dive deep, let's first answer why we need references.

By using Perl references you can create multidimensional data structures, such as an array of arrays, or arrays of hashes, or hashes of hashes, and so on.

Let's explore more about it in the code editor.

```perl
#!usr/bin/perl
use strict;
use warnings;

my $card = "Visa"; # $card is a scalar variable
my $card_ref = \$card; # $card_ref is a reference to $card
```

As you saw, we create a reference to a variable using the unary backslash operator `\`. It can precede any variables, or subroutines.

If you are familiar with the C language, you can think of Perl references as C pointers. It holds the memory address of the object that it points to. Let's switch back to the code editor.

```perl
#!usr/bin/perl
use strict;
use warnings;

my $card = "Visa"; # $card is a scalar variable
my $card_ref = \$card; # $card_ref is a reference to $card

print "card: $card\n";
print "card_ref: $card_ref\n";
```

Output:

```bash
card: Visa
card_ref: SCALAR(0x2784f80)
```

You can see the variable contains the value "Visa", and the variable reference has two parts to it. The first "SCALAR" indicates the variable type it's pointing to, and the hexadecimal number next to it is the actual memory location of the scalar variable.

We use the __dereference__ process to read the actual value that a reference is pointing to. To do that we need to prefix its value with a dollar sign `$`, so it references the variable. Like this:

```perl
#!usr/bin/perl
use strict;
use warnings;

my $card = "Visa"; # $card is a scalar variable
my $card_ref = \$card; # $card_ref is a reference to $card

print "card: $card\n";
print "card_ref: $card_ref\n";
print "card_ref value: $$card_ref\n";
```

Output:

```bash
card: Visa
card_ref: SCALAR(0x27712f8)
card_ref value: Visa
```

References can be used not only on scalar variables, they can be used on arrays and hashes. Let's see how to do it in the code editor.

```perl
#!usr/bin/perl
use strict;
use warnings;

my @cards = ('MasterCard', 'Discover', 'Maestro');
my $cards_ref = \@cards;

print "cards_ref: $cards_ref\n";
print "cards_ref value: @$cards_ref\n";
```

Output:

```bash
cards_ref: ARRAY(0x2768068)
cards_ref value: MasterCard Discover Maestro
```

And here is an example of a hash reference:

```perl
#!usr/bin/perl
use strict;
use warnings;

my %cards_catalogue = (Visa => 0, MasterCard => 1, Discover => 2, Maestro => 3);
my $cards_catalogue_ref = \%cards_catalogue;

print "cards_catalogue_ref: $cards_catalogue_ref\n";
foreach my $k (keys %$cards_catalogue_ref) {
    print "$k: $cards_catalogue_ref->{$k}\n";
}
```

Output:

```bash
cards_catalogue_ref: HASH(0x2741df8)
Maestro: 3
Discover: 2
MasterCard: 1
Visa: 0
```

Notice how the references mention if the variable is a scalar, an array, or a hash data type followed by the hex code indicating the address to the actual memory location. So we used the dereferenced variables to read the actual value that a reference is pointing to.

---

Though we learned about references, we are still unclear what the use case of Perl references will be.

Imagine a scenario where you need to build a two-dimensional array. In the two-dimensional array the first row and first column starts at index __0__.

Let's jump into code to better understand this scenario.

```perl
#!usr/bin/perl
use strict;
use warnings;

my @primary_card_brands = ('Visa', 'MasterCard', 'Discover', 'Maestro');
my @secondary_card_brands = ('Elo', 'Paypal', 'Skrill', 'Apple Pay');

my @two_dimensional_array = (
    @primary_card_brands,
    @secondary_card_brands
);

print "Element on first row and first column: $two_dimensional_array[0][0]\n";
```

As an output, we get the following result:

```bash
Cant use string ("<card-brand-here>") as an ARRAY ref while "strict refs" in use at <script-name.pl> line <script-line>.
```

If we made a small change in this code, the result may surprise you.

```perl
#...

print "Element on first row and first column: $two_dimensional_array[0]\n";
```

As an output, we get the following result:

```bash
Element on first row and first column: Visa
```

So what's happening here? When you created an array using two existing arrays, Perl used the __flattening process__ and flattened both the arrays.

What we send was this:

|      |            |          |           |
|:----:|:----------:|:--------:|:---------:|
| Visa | MasterCard | Discover | Maestro   |
| Elo  | Paypal     | Skrill   | Apple Pay |

And under the hood we got:

```perl
['Visa', 'MasterCard', 'Discover', 'Maestro', 'Elo', 'Paypal', 'Skrill', 'Apple Pay']
```

If we wanted to reach the `Paypal` element, we need to do access the fifth element in the array.

So from this example we learned that this is not the way you should take to create two-dimensional arrays. But in fact we can overcome this problem by using references.

```perl
#!usr/bin/perl
use strict;
use warnings;

my $primary_card_brands_ref = \@primary_card_brands;
my $secondary_card_brands_ref = \@secondary_card_brands;

my @real_two_dimensional_array = (
    $primary_card_brands_ref,
    $secondary_card_brands_ref
);

print "Element on second row and second column: $real_two_dimensional_array[1][1]\n";
```

As an output, we get the following result:

```bash
Element on second row and second column: Paypal
```

---

Now you will be introduced to Perl's anonymous references and symbolic references.

When it comes to references, there are three different aspects.

1. Variables.
2. Data assigned to these variables.
3. References pointing to those variable.

Until now, we created a variable first and assigned a reference explicitly to it. Perl also lets you create a reference and assign the data directly without explicitly creating a variable, and this reference is called an __anonymous reference__.

Let's jump into code to better understand this new concept.

```perl
#!usr/bin/perl
use strict;
use warnings;

# Perl lets you create an array reference dynamically 
# when you enclose the elements within square brackets instead of parentheses.

my @arr_ref = ([10, 20, 30],
                [40, 50, 60]);

print "Element on second row and second column is: $arr_ref[1][1]\n";
```

As an output, we get the following result:

```bash
Element on second row and second column is: 50
```

Similarly, you can create a dynamic hash reference as well using curly braces instead of parentheses.

```perl
#!usr/bin/perl
use strict;
use warnings;

my $hash_ref = {
    'peter' => 'monkey',
    'psyche' => 'cat',
    'sarah' => 'dog'
};

print "Psyche's pet is: $hash_ref->{'sarah'}\n";
```

As an output, we get the following result:

```bash
Psyche's pet is: cat
```

Now let's take a look about symbolic references. Perl does not recommend this, and you cannot use this feature without turning off the `use strict` pragma. With that disclaimer, let's omit it in the code editor and see how it works.

```perl
#!usr/bin/perl
use warnings;

$$card_brand = "Mastercard";
```

Anytime that Perl sees a variable prefixed with double dollar sign `$$`, it indicates this variable is dereferencing a reference variable and the intention is to return the value pointed by that variable.

On the previous code snippet, we've assigned a string and not a variable. In cases like this, Perl looks for the value assigned to the variable `$card_brand` and uses that value as a variable name.

So with the following code snippet, can you guess the output?

```perl
#!usr/bin/perl
use warnings;

my $card_brand = "Visa";
$$card_brand = "Mastercard";
print "$Visa\n";
```

If you guessed "Mastercard", you are right! If you are curious, when using the `use strict` pragma, the following code will give you an error.

```perl
#!usr/bin/perl
use strict;
use warnings;

my $card_brand = "Visa";
$$card_brand = "Mastercard";
```

```bash
Can't use string ("Visa") as a SCALAR ref while "strict refs" in useat <script-name.pl> line <script-line>.
```

That's a powerful feature of Perl, but adds a lot of complexity to the code and can lead to unexpected results. Useful when you want to access a variable when its name is in another variable.

---

We will move on and learn about subroutines in Perl. Subroutines are also called functions or procedures in other languages, and they are typically used to write a logic that can be reused elsewhere in the code, or a new project. They are your go-to place for refactoring your script when it starts to get larger.

Imagine a business requirement where you have been asked to enter a piece of footer information that prints the timestamp when the script is run. Let's jump into code and write a subroutine that implements this functionality.

```perl
#!usr/bin/perl
use strict;
use warnings;

sub print_timestamp {
    my $timestamp = localtime(); # get current timestamp based on location

    print "This script was run on: $timestamp\n";
}

&print_timestamp;
```

We can apply references to subroutines as well. Let's see how it works in the code editor.

```perl
#!usr/bin/perl
use strict;
use warnings;

sub print_timestamp {
    my $timestamp = localtime(); # get current timestamp based on location

    print "This script was run on: $timestamp\n";
}

my $timestamp_ref = \&print_timestamp;

&$timestamp_ref;
```

It's time to explore how to pass parameters to the subroutines and refactor the script we've built so far. The script consist in reading an input file line by line, check if the line contains a credit card number, then mask the card number except for the last four digits, and rewrite the file.

What if we want to reuse the logic elsewhere in our script? We can extract this code and create a subroutine, and this subroutine can be used in places where the masking logic is required. But there is a catch, that piece of code operates on an input file, in order to reuse this logic, the input file might be different every time this code is used. To achieve this dynamism we're going to use subroutine parameters.

All the parameters passed to a subroutine are maintained in a special array variable `@_`. The arguments can be individually fetched using the `$_[<index>]` syntax.

```perl
#!usr/bin/perl
use strict;
use warnings;

sub mask_card_number {
    my $file_handle = $_[0];
    my $read_pos = tell($file_handle);
    while (<$file_handle>) {
        $_ =~ tr/[a-z]/[A-Z]/;
        if ( $_ =~ s/(?<=NUMBER:\s)(\d+)(?=\d{4})/'*' x length($1)/e ) {
            seek( $file_handle, $read_pos, 0 );
            print $file_handle $_;
        }

        $read_pos = tell($file_handle);
    }
}
```

Perl's variables created inside a subroutine are not accessible outside the subroutine (limited scope). You can see the final result [here](./src/module_06/challenge_refactored.pl).

---

You've learned about the Perl private variable before, in this section let's look at what global variables are.

Imagine that you need to print your company name. This will be constant as there is no need to define another variable explicitly within a subroutine.

Let's explore more about it in the code editor.

```perl
#!usr/bin/perl
use strict;
use warnings;

my $company_name = "ScriptMakers Inc.";
print "$company_name\n";

sub print_company_name {
    print "$company_name\n";
}

&print_company_name;

print "$company_name\n";
```

As an output, we get the following result:

```bash
ScriptMakers Inc.
ScriptMakers Inc.
ScriptMakers Inc.
```

We can see Perl has no problem accessing the scalar variable `company_name` inside the subroutine. What if we change the value of this variable inside the subroutine?

```perl
#!usr/bin/perl
use strict;
use warnings;

my $company_name = "ScriptMakers Inc.";
my $company_address = "123 Main Street";

print "$company_name\n";
print "$company_address\n";

print "===================\n";

sub print_company_info {
    $company_address = "456 Boulevard Avenue";
    print "$company_name\n";
    print "$company_address\n";
}

&print_company_info;

print "===================\n";

print "$company_name\n";
print "$company_address\n";
```

As an output, we get the following result:

```bash
ScriptMakers Inc.
123 Main Street
===================
ScriptMakers Inc.
456 Boulevard Avenue
===================
ScriptMakers Inc.
456 Boulevard Avenue
```

Notice that once the value is changed inside the subroutine, this value is carried forward even outside, which proves that the scope of this variable is global.

Perl also offers another type of variable called **state variables**. Introduced in version 5.9.4, as the name indicates state variables maintain their state and don't get reinitialized upon multiple calls to the subroutines. You need to use the pragma `use feature state` to utilize this feature.

Imagine a scenario where you have been asked to print the footer five times at the end of the execution. To achieve this, we can use a for loop.

```perl
#!usr/bin/perl
use strict;
use warnings;

use feature 'state';

sub print_footer {
    state $counter = 1;
    print "Footer line: $counter\n";
    $counter++;
}

for (1..5) {
    &print_footer;
}
```

As an output, we get the following result:

```bash
Footer line: 1
Footer line: 2
Footer line: 3
Footer line: 4
Footer line: 5
```

Unlike a private variable, the state variable maintains its state information across invocation and it is not reinitialized every time it is invoked.

## Summary

On this module you've learned that:

- The importance of references in creating multidimensional data structures.
- Anonymous references and the caution we need to exercise while using symbolic references.
- How to create subroutines, invoke them, pass parameters, and return values from them.
- Global variables, private variables, and state variables.
