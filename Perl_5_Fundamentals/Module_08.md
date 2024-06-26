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
