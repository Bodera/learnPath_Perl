# Module 08

## Working with databases

Along the course, have you thought about how to handle SQL in Perl? Because that is exactly what we will learn now, how to connect and execute SQL queries using Perl script. For this purpose, we will use the __[DBI](https://metacpan.org/pod/DBI)__ module.

We can use this module for most of the common databases, and we will use PostgreSQL database in our demo. You already know how to install a Perl module, and we can easily use Docker to create a container that runs a PostgreSQL database.

While connecting with the database, you are required to pass the *user_id* and *password* information, and it is never a good idea to hard code that kind of information in your Perl scripts. So typically, you will maintain this information in a properties file, once your script load that properties file, it can read the values from it.

We can use the __[Config::Properties](https://metacpan.org/pod/Config::Properties)__. This module is primarily used to read and write property files. You must download and install it as well.

1. Make a SQL script to populate the database.
2. Store in a text file the environment variables for the PostgreSQL database.
3. Create a Dockerfile for the PostgreSQL database.

What you need to do to start the PostgreSQL database:

```bash
bash setup_database.sh
docker run -d --name my-postgres-container -p 5432:5432 my-postgres-image
```

To complete delete all data related to this container you need to run:

```bash
docker stop my-postgres-container
docker container prune -f
docker rmi my-postgres-image
docker image prune -a -f
docker volume prune -a -f
docker buildx prune -f
```

Now let's try to connect to the database using a simple Perl program.

```perl
#!/usr/bin/perl

use strict;
use warnings;
use Config::Properties;
use DBI;

open (my $dbfh, '<', 'db.properties') or die $!;
my $properties = Config::Properties->new();
$properties->load($dbfh);
my $dbname = $properties->getProperty('dbname');
my $dbuser = $properties->getProperty('dbuser');
my $dbpass = $properties->getProperty('dbpass');
my $dbhost = DBI->connect($dbname, $dbuser, $dbpass) or die $DBI::errstr;
my $query = "INSERT INTO houses (name, price) VALUES ('House 11', 9999990.00),";
my $stm = $dbhost->prepare($query);
$stm->execute() or die $DBI::errstr;
$stm->finish();
$dbhost->disconnect();
```

## Security vulnerability in Perl scripts

Though Perl is a very powerful language, hackers can easily attack it if your script is open for vulnerabilities, especially if your script is accepting arguments. That's because a script accepting arguments is similar to having an inlet to your home. Unless you protect it with proper security systems, an intruder may easily enter your property. A script is no different, you need to provide safeguards to prevent a potential hacker from misusing the script.

Let's explore the following example:

```perl
#!/usr/bin/perl

use strict;
use warnings;

my $input = $ARGV[0];

print "Input: $input\n";
open (my $fh, $input) or die $!;

while (<$fh>) {
    print $_;
}

close $fh;
```

The script above accepts a file name as a script argument, opens this file, prints its content to the console, and finally, close the file. It is a straightforward script, and it doesn't look too complex. How could a potential hacker exploit it?

From the command line, let's run our script providing the `db_credentials.txt` file as an argument:

```bash
perl danger.pl db_credentials.txt
Input: db_credentials.txt
POSTGRES_DB=module_08
POSTGRES_USER=admin
POSTGRES_PASSWORD=1234
POSTGRES_HOST=localhost
POSTGRES_PORT=5432
```

We can confirm that it displays the whole content of the file. Now look at this:

```bash
perl danger.pl "dir |"
Input: dir |
Volume in drive Y is Data
Volume Serial Number is 404F-9999

Directory of /home/admin

25/06/2024  01:54    <DIR>          .
25/06/2024  01:54    <DIR>          ..
25/06/2024  02:28               185 danger.pl
               1 File(s)            185 bytes
               2 Dir(s)         424.768 bytes free
```

Now it shows the actual contents of the directory. But that's not all.

```bash
perl danger.pl "copy ..\working_with_databases\db_credentials.txt |"
Input: copy ..\module_03\db_credentials.txt |
        1 file(s) copied.
```

We can even execute instructions from other files, like this:

```bash
perl danger.pl "perl ..\..\module_03\for_loop.pl |"
Input: del db_credential.txt |
2 * 2 = 4
4 * 2 = 8
6 * 2 = 12
8 * 2 = 16
10 * 2 = 20
```

If you're wondering why this is a big issue, imagine that a potential hacker can use the same process to copy malware to a specific directory and run it. He can copy a script that extracts all the credit card numbers and copy these numbers to a file, and any other **N** number of possibilities out there. We can simply delete a file from a directory.

```bash
perl danger.pl "del db_credentials.txt |"
Input: del db_credentials.txt |
```

And the copied file has been deleted. An attacker could potentially use this method to delete critical files to your business once he knows its location, so it's paramount that you pay utmost importance not just to the business logic of your script, but running your business logic securely.

## Securing Perl scripts

To address issues like those we've sawn, Perl has a feature called **taint checking** that alerts the developer of security loopholes and errors out until those issues are addressed. You can imagine taint checking as an imaginary code reviewer that constantly monitors your code for security-related issues. 

This feature is turned on with the `-T` switch next to the shebang line. Once Perl sees this switch, it marks all the data coming from outside as tainted. Just for reinforcement, turning on this feature does not guarantee that the security issues are automatically fixed, it will just alert the potential loopholes, and is your responsibility to fix them.

Let's modify the previous script to turn on taint checking:

```perl
#!/usr/bin/perl -T

use strict;
use warnings;

my $input = $ARGV[0];

print "Input: $input\n";
open (my $fh, $input) or die $!;

while (<$fh>) {
    print $_;
}

close $fh;
```

Now if we run the script we'll receive the following alert:

```bash
perl caution.pl "perl ..\..\module_03\for_loop.pl |"
"-T" is on the #! line, it must also be used on the command line at .\caution.pl line 1.
```

It means that we've to add the `-T` switch in the command line as well while running the program. This additional security blocks a malicious user from getting around taint checking by using a different Perl binary. Let's run it again passing the `-T` switch at the command line.

```bash
perl -T caution.pl "perl ..\..\module_03\for_loop.pl |"
Input: perl ..\..\module_03\for_loop.pl |
Insecure $ENV{PATH} while running with -T switch at .\caution.pl line 9.
```

Previously we saw that without the `-T` switch the command passed in double quotes was executed, now with taint checking turned on, we are alerted with an insecure path variable while running the script.

Though this blocks any security issues, what if you are in a development environment, and you are not too concerned about security issues? To address these scenarios, Perl offers a softer version of taint checking, and we just have to replace the uppercase `-T` with a lowercase `-t`.

```bash
perl -t caution.pl "perl ..\..\module_03\for_loop.pl |"
Input: perl ..\..\module_03\for_loop.pl |
Insecure $ENV{PATH} while running with -t switch at .\caution.pl line 9.
Insecure dependency in piped open while running with -t switch at .\caution.pl line 9.
"my" variable @numbers masks earlier declaration in same scope at ..\..\module_03\for_loop.pl line 28.
Scalar value @numbers[...] better written as $numbers[...] at ..\..\module_03\for_loop.pl line 35.
Scalar value @numbers[...] better written as $numbers[...] at ..\..\module_03\for_loop.pl line 35.
2 * 2 = 4
4 * 2 = 8
6 * 2 = 12
8 * 2 = 16
10 * 2 = 20
```

Now the error has turned into a warning, and the program continues to run.

To fix the tainted data, Perl recommends using regular expressions to allow only good input data and block the bad ones. So let's modify our script and add the following validation:

```perl
my $input;
if ($ARGV[0] =~ /^(?!.*[|$%;]).*/) {
    $input = $ARGV[0];
}
```

We're telling Perl to block characters like `$`, `|`, `%`, and `;` from the input parameter. If the input doesn't match this metacharacters, it will be assigned to the variable `$input`.

Let's rerun the script:

```bash
perl -t caution.pl "perl ..\..\module_03\for_loop.pl |"
Input:
Use of uninitialized value $input in open at .\caution.pl line 12.
No such file or directory at .\caution.pl line 12.
```

Now the bad input is successfully blocked. If we pass the actual file name, it runs smoothly.

```bash
perl -t caution.pl "perl ..\..\module_03\for_loop.pl"
Input: 
```

That's because the input is invalid. The argument should not contain double dots.

```bash
perl -t caution.pl danger.pl
Input: danger.pl
#!/usr/bin/perl

use strict;
use warnings;
...
```

Secure Perl programming is a vast concept, and we just scratched the surface. Consider reading the [Perl Security Guide](https://perldoc.perl.org/perlsec.html) for more information, and check the [OWASP Security](https://owasp.org/) for more security tips.

## Testing Perl scripts

This section will teach you one of the important aspects of any software development, that is testing. It doesn't matter how well you write your code, if it doesn't satisfy the business cases, it's of no use to the business. Testing all business cases is paramount to the success of your project. So you need to test the business cases upfront before shipping your code to production. Perl offers a lot of modules for this purpose, and let's explore them now.

On the previous module when we created the starting structure of a Perl module using the `h2xs` utility, it created a directory structure where the `lib` directory hosted the Perl module, and the directory named `t` hosted files that ends in a `.t` extension. That kind of file is a Perl test file that will hold all the test cases.

Check it out how the template looks like:

```perl
# Before 'make install' is performed this script should be runnable with
# 'make test'. After 'make install' it should work as 'perl FileMasker.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use strict;
use warnings;

use Test::More tests => 1;
BEGIN { use_ok('FileMasker') };

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.
```

This line:

```perl
use Test::More tests => 1;
```

Informs Perl interpreter the number of test cases to be executed. To write a test case you must start with an `ok` function.

For the sake of simplicity, let's include a simple `sum` subroutine in that `FileMasker`module, which will accept two parameters and return the sum of them.

```perl
sub sum {
    my ($a, $b) = @_;
    return $a + $b;
}
```

*This subroutine presents the exact same behavior as the previous one:*

```perl
sub sum {
    return $[0] + $[1];
}
```

For the changes to be effective, you may need to run `make install` or `gmake install` to rebuild the module. **But maybe not!**

```bash
perl Makefile.PL
gmake install #Windows
make install #Linux
```

Let's write our first test:

```perl
use FileMasker;
use Test::More tests => 1;

ok(FileMasker::sum(6,6) == 12);
```

And now we execute it:

```bash
perl t/FileMasker.t
1..1
ok 1
```

We receive a very simple output this time. The `1..1` indicates the number of test cases run. The `ok 1` statement, on the line below, indicates that the test passed.

Let's write another test, forcing the test to fail:

```perl
use FileMasker;
use Test::More tests => 2;

ok(FileMasker::sum(6,6) == 12);
ok(FileMasker::sum(10,10) == 8);
```

And now we execute it:

```bash
perl t/FileMasker.t
1..2
ok 1
not ok 2
#   Failed test at .\t\FileMasker.t line 16.
# Looks like you failed 1 test of 2.
```

This time we get a `not ok` message indicating that the test failed at the provided line number.

Now that we understand how to run a test case in Perl, let's write another test case that tests card masking. Sounds fair right?

```perl
use FileMasker;

use Test::More tests => 3;

my $mask_expected = 'CARD NUMBER: ************6828';
my $mask_result = FileMasker::mask_card_number('CARD NUMBER: 6011490036796828');
is($mask_result, $mask_expected, 'mask_card_number test with uppercase');

ok(FileMasker::mask_card_number('Card number: 6011490036796828') ne 'Card number: 6011490036796828', "mask_card_number test with lowercase");

ok(FileMasker::sum(6,6) == 12, "sum test");
```

Here I introduced a few flavors available on the `Test::More` module, consider reading the documentation for more details [here](https://metacpan.org/pod/Test::More). Before explain what this test suite does, let's run it.

```bash
perl t/FileMasker.t
1..3
ok 1 - mask_card_number test with uppercase
not ok 2 - mask_card_number test with lowercase
#   Failed test 'mask_card_number test with lowercase'
#   at .\t\FileMasker.t line 19.
ok 3 - sum test
# Looks like you failed 1 test of 3.
```

We've added an optional parameter that serves as a test description. This is very useful when debugging. The `ok` function has the purpose to validate boolean expressions, for value comparisons the `is` function is more appropriate.

Our tests provided us the info that our application has a gap, because it only masks the last 4 digits of the card number if the string number is written in uppercase.

We can enhance the test report by replacing the `perl` command with `prove`. Just like that:

```bash
prove t/FileMasker.t
.\t\FileMasker.t .. 1/3 
#   Failed test 'mask_card_number test with lowercase'
#   at .\t\FileMasker.t line 19.
# Looks like you failed 1 test of 3.
.\t\FileMasker.t .. Dubious, test returned 1 (wstat 256, 0x100)
Failed 1/3 subtests

Test Summary Report
-------------------
.\t\FileMasker.t (Wstat: 256 Tests: 3 Failed: 1)
  Failed test:  2
  Non-zero exit status: 1
Files=1, Tests=3,  1 wallclock secs ( 0.00 usr +  0.01 sys =  0.01 CPU)
Result: FAIL
```

Notice a subtle difference when we add the `-l` switch to `prove`, see more at the documentation page [here](https://perldoc.perl.org/prove).

```bash
prove -l t/FileMasker.t
.\t\FileMasker.t .. 1/3 
#   Failed test 'mask_card_number test with lowercase'
#   at .\t\FileMasker.t line 19.
Undefined subroutine &FileMasker::sum called at .\t\FileMasker.t line 21.
# Looks like your test exited with 255 just after 2.
.\t\FileMasker.t .. Dubious, test returned 255 (wstat 65280, 0xff00)
Failed 2/3 subtests

Test Summary Report
-------------------
.\t\FileMasker.t (Wstat: 65280 Tests: 2 Failed: 1)
  Failed test:  2
  Non-zero exit status: 255
  Parse errors: Bad plan.  You planned 3 tests but ran 2.
Files=1, Tests=2,  0 wallclock secs ( 0.00 usr +  0.00 sys =  0.00 CPU)
Result: FAIL
```

Write proper unit test cases, addressing all possible outputs from your subroutine before shipping your code to production.

## Sorting lists

When you're working with data, sorting is a common task that you are often faced with. Let's see how to sort lists in Perl.

When your list contains only strings, you can simply use the `sort` function:

```perl
#!/usr/bin/perl

use strict;
use warnings;

my @cards = ('Visa', 'MasterCard', 'American Express', 'Discover', 'Maestro');

print "Array before sorting: @cards\n";
@cards = sort @cards;
print "Array after sorting: @cards\n";
```

As an output we get the following:

```bash
Array before sorting: Visa MasterCard American Express Discover Maestro
Array after sorting: American Express Discover Maestro MasterCard Visa
```

Now let's see how to sort a list that only contains numbers using the same technique:

```perl
#!/usr/bin/perl

use strict;
use warnings;

my @card_ocurrences = (111, 77, 98, 53, 109);

print "Array before sorting: @card_ocurrences\n";
@card_ocurrences = sort @card_ocurrences;
print "Array after sorting: @card_ocurrences\n";
```

Output:

```bash
Array before sorting: 111 77 98 53 109
Array after sorting: 109 111 53 77 98 
```

You can see the sorting is incorrect because the `sort` function treated all the numbers as a string and sorted it alphabetically and not numerically. To fix this, we need to use the **block sorting**. This syntax accepts two numbers represented by two special variables, separated by a spaceship operator `<=>`, which is the operator used for comparing two numbers. The spaceship operator returns **-1** if the left operand is less than the right operand, **0** if both are equal, and **1** if the left operand is greater than the right one.

```perl
#!/usr/bin/perl

use strict;
use warnings;

my @card_ocurrences = (111, 77, 98, 53, 109);

print "Array before sorting: @card_ocurrences\n";
@card_ocurrences = sort {$a <=> $b} @card_ocurrences;
print "Array after sorting: @card_ocurrences\n";
```

Output:

```bash
Array before sorting: 111 77 98 53 109
Array after sorting: 53 77 98 109 111
```

At this point, you may be thinking that the output is hard to read. Hang tight because shortly we're going to learn how to format this display.

Imagine a scenario which the business logic requires you to perform a custom sort on the list based on its length? Perl offers another feature that lets you write a subroutine and pass it to the `sort` function instead of the block, as we've sawn. The only requirement is that your subroutine must return either `-1`, `0` or `1`, to address the three different cases already mentioned.

```perl
#!/usr/bin/perl

use strict;
use warnings;

my @cards = ('Visa', 'MasterCard', 'American Express', 'Discover', 'Maestro');

sub compare {
    if (length($a) < length($b)) {
        return -1;
    } elsif (length($a) == length($b)) {
        0;
    } else {
        return 1;
    }
}

print "Array before sorting: @cards\n";
print "Array after sorting: ", sort compare @cards;
print "\n";
```

Output:

```bash
Array before sorting: Visa MasterCard American Express Discover Maestro
Array after sorting: VisaMaestroDiscoverMasterCardAmerican Express
```

We can see that the sorting is done based on the length of the strings. So far we've explored how to operate sort using ascending order, but what if we need to sort them in descending order? For that, Perl offers a reverse sort function.

```perl
#!/usr/bin/perl

use strict;
use warnings;

my @cards = ('Visa', 'MasterCard', 'American Express', 'Discover', 'Maestro');
print "Array before sorting: @cards\n";
print "Array after sorting: ", sort @cards;
print "\n";
print "Array after sorting descending: ", reverse sort @cards;
print "\n";
```

Output:

```bash
Array before sorting: Visa MasterCard American Express Discover Maestro
Array after sorting: American ExpressDiscoverMaestroMasterCardVisa
Array after sorting descending: VisaMasterCardMaestroDiscoverAmerican Express
```

We can apply the `reverse` on the 3 kinds of sorting that we've seen so far. But to reverse sort a list of numbers just swap the special variables in the `sort` function.

```perl
#!/usr/bin/perl

use strict;
use warnings;

my @card_ocurrences = (111, 77, 98, 53, 109);

print "Array before sorting: @card_ocurrences\n";
print "Array after sorting: ", sort { $a <=> $b } @card_ocurrences;
print "\n";
print "Array after sorting descending: ", sort { $b <=> $a } @card_ocurrences;
print "\n";
```

Output:

```bash
Array before sorting: 111 77 98 53 109
Array after sorting: 53 77 98 109 111
Array after sorting descending: 111 109 98 77 53
```

## Formatting and Reporting in Perl

Perl lets you generate simple reports and charts using PERL formats. A format informs the Perl interpreter about the static text location and the variable data location. You can refer to the documentation [here](https://perldoc.perl.org/perlform).

The format name follows the `format` keyword, and if the format name is omitted, the formatted report is printed to the `STDOUT`. For example:

```perl
format <FORMAT_NAME> = 
<FIELD_LINE>
    <static text>
    <dynamic data>;
<VALUE_LINE>
    <variables separated by commas>;
```

The `<FIELD_LINE>` specifies how the data needs to be formatted and can contain both text and field holders. A text holder holds static text that will be displayed at the output. A field holder holds the space where Perl eventually writes the data, a typical field holder is `&<` or `&>`. The use of `@` indicates the start of a regular field, and the use of `<` indicates that the field needs to be left justified, whereas the use of `>` indicates that the field needs to be right justified. The placeholder for a numeric field is `#`.

The `<VALUE_LINE>` indicates the variable whose value needs to be applied on the `<FIELD_LINE>`. When the format is defined, the next step is to invoke it. Perl provides a `write` keyword to fetch the format, and a single `.` in column 1 is used to terminate a format. 

By default, the `write` statement writes to the standard output by default, which is one open file handle. Since we need to write our output to the `STDOUT`, we need to associate our `format` with `STDOUT`. To achieve this lets first select the output handle using the `select` function and associate it using the special variable `$~`.

The final step is to populate data to the scalar variables `$name` and `$ocurrence`.

```perl
#!/usr/bin/perl

use warnings;

format CARD_DETAILS =
Card: @<<<<<<<<<<<<<<<< Ocurrence: @####
$name, $ocurrence
.

select(STDOUT);
$~ = CARD_DETAILS;

my @cards = ('Visa', 'MasterCard', 'American Express', 'Discover', 'Maestro');
my @card_ocurrences = (111, 77, 98, 53, 109);

$i = 0;
foreach(@cards) {
    $name = $cards[$i];
    $ocurrence = $card_ocurrences[$i];
    $i++;
    write;
}
```

Output:

```bash
Card: Visa              Ocurrence:   111
Card: MasterCard        Ocurrence:    77
Card: American Express  Ocurrence:    98
Card: Discover          Ocurrence:    53
Card: Maestro           Ocurrence:   109
```

You might want to take a look at the [Perl 6 form](https://metacpan.org/release/DCONWAY/Perl6-Form-0.04/view/Form.pm), to implement reporting without using the `format` built-in.

Here is the same code, without naming the format:

```perl
#!/usr/bin/perl

use warnings;

format =
Card: @>>>>>>>>>>>>>>>> Ocurrence: @0####
$name, $ocurrence
.

my @cards = ('Visa', 'MasterCard', 'American Express', 'Discover', 'Maestro');
my @card_ocurrences = (111, 77, 98, 53, 109);

$i = 0;
foreach(@cards) {
    $name = $cards[$i];
    $ocurrence = $card_ocurrences[$i];
    $i++;
    write;
}
```

## Object-oriented programming in Perl

Until now, we've only written programs in a procedural way. But in fact, Perl lets you develop modular and portable code using an object-oriented paradigm.

In Perl, the package we used when creating a module, we will use to create a class. An object is a reference to the class, and a method or function in Perl is a subroutine. The Perl file must end with a `.pm` extension, and the package must have the same name as the file, so remember to export the directory to the `PERL5LIB` environment variable.

To construct an object, it's very common to write a subroutine named `new`, anytime an object is created using this `new` method, Perl automatically passes the class name as the first argument. An object is a reference to a class, and Perl offers a built-in function, `bless`, that creates this reference and returns an instance of the class. Our class must return a true value.

Our class should look like this:

```perl
package Card;

sub new {
    my ($class, $args) = @_;
    my $self = bless {
        card_name => $args->{card_name},
        card_num => $args->{card_num},
        card_sec_code => $args->{card_sec_code}
    }, $class;
}

sub to_string {
    my $self = shift;
    return "Card name: $self->{card_name}\nCard number: $self->{card_num}\nCard security code: $self->{card_sec_code}\n";
}

1;
```

Demo:

```perl
#!/usr/bin/perl

use strict;
use warnings;
use Card;

my $card = Card->new({card_name => 'John Doe', card_num => '1234567890123456', card_sec_code => 123});
print $card->to_string;
```

Output:

```bash
Card name: John Doe
Card number: 1234567890123456
Card security code: 123
```

Let's cover now another object-oriented programming concept: **inheritance**. Imagine a scenario where you have two types of a card, a magnetic stripe card and a chip card. Both these are card types. So instead of creating a new class, let's create a class named `Chipcard`, so then we can inherit it from the `Card` class. To set up the inheritance relation between classes, Perl offers a special variable, `@ISA`, which is used to refer there is a relationship. Pay attention to the use of the `our` keyword, which indicates the opposite of the `my` keyword in the sense it declares a variable to be global, that is visible across the entire lexical scope and package boundaries. 

```perl
package Chipcard;
require Card;

our @ISA = qw(Card);
1;
```

Demo:

```perl
#!/usr/bin/perl

use strict;
use warnings;

require Chipcard;

my $chipcard = Chipcard->new({card_name => 'Mary Doe', card_num => '6543210987654321', card_sec_code => 321});

print $chipcard->to_string;
```

Output:

```bash
Card name: Mary Doe
Card number: 6543210987654321
Card security code: 321
```

We've proven that there is a relationship between classes, because the `Chipcard` class inherits from the `Card` class and can access the `to_string` parent class method. But nothing stops us from doing an overload of the `to_string` method.

## Perl best practices

- Enforce proper indentation and documentation to enhance readability.
- Comments focused on "what" and "why", not the "how".
- Maintain a consistent and well-defined naming convention.
- Develop concise subroutines.
- Refactor large monoliths into smaller modular pieces.
- Strive to a high code coverage ratio.
- Always use the `strict` and `warnings` pragmas. Pay attention to error handling and address any warnings issued by the Perl interpreter.
- Minimize the use of `unless` and `until` statements as they can be confusing.
- Think of creative ways to hack your own program.
- Check CPAN modules before creating your own. Strive for code reuse.
