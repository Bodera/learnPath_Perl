# Module 07

This is the module __distributing your code using Perl modules__.

On previous module, we refactored our script and created subroutines. So any time you need to reuse this subroutine, we can quickly invoke it by calling its name.

What if you need to call this subroutine from a different script? What if another project in your organization wants to reuse your code? The answer for these questions is __Perl modules__.

Even if you're an app developer, you don't write all the apps you use on your phone. You go to the app store, download and install the apps developed by other developers. So, an app provides a simple plug and play environment for your phone. Similarly, a module lets you download and install some commonly used features like text processing, file handling, log tracing, and many more.

Does it mean Perl has an app store to download modules? Yes. Hang tight, and you will learn about it towards the end of this module. So lets dive in, and start by creating a Perl module.

The first step is to name your module, and here we'll name it as __file masker__. This utility will open a file, perform common regex checks, and log messages to the console. Unlike a Perl script, a Perl module will have an extension of `.pm`.

Like Java, Perl packages provide the classes with their own namespaces.

```perl
package FileMasker;

sub log {
    print "Log: $_[0]\n";
}

1;
```

You can later on enhance this subroutine and add a log level, then use this log level to control printing back the messages to the console.

---

Now that we've got our module ready, let's use it our script. First we need to reference this module in our script by adding the following line:

```perl
#!usr/bin/perl
use strict;
use warnings;

require FileMasker;
```

You can use either `use` or `require` keywords. To invoke the subroutine, you will use the module name, followed by doble colon `::`, and the subroutine name.

```perl
#!usr/bin/perl
use strict;
use warnings;

require FileMasker;

FileMasker::log("Store transaction detected!");
```

But if we try to run our script now, we'll get an error similar to this:

```bash
Can't locate FileMasker.pm in @INC (you may need to install the FileMasker module) (@INC contains: <path>
```

So our script cannot locate the `FileMasker` module in `@INC`. From the prefix you can make out that `@INC` is a special type of array, there Perl maintains the list of directories to search for modules and libraries.

If you are coming from the Java world, you must be familiar with the Java `PATH` variable that holds the location to the Java `bin` directory. There are a couple of ways to address this issue. The first option is to copy the Perl module to the directories that are currently listed under `@INC`. The second option is to add the directory to the environment variable `PERL5LIB`.

If you are in a UNIX environment, you can use the export command and set this variable. Just like that:

```bash
export PERL5LIB="/path/to/perl/libs:$PERL5LIB"
echo $PERL5LIB
```

It does not overwrite any previous directories already set in the `PERL5LIB` environment variable. Instead, it appends the new directory to the existing `PERL5LIB` variable.

On Windows environment, you can open the __Run__ dialog and then type `sysdm.cpl` followed by __Enter__. Navigate to the Advanced tab and select `Environment Variables`. Under the `User variables` pane, click the `Add` button in order to create the `PERL5LIB` variable. Then type the path to the directory that contains your Perl modules.

For both environments, you may need to restart your terminal to see the changes made.

Now that we're able to reference the `FileMasker` module in our script, let's enhance it by adding a few more subroutines.

```perl
sub open_file {
    my $input_file = shift;
    open (my $file_handle, '+<', $input_file) or die $!;
    return $file_handle;
}
```

Our code is starting to get more readable. We can enhance this subroutine even further by passing the file mode as an additional parameter, making your code even more flexible. Like this:

```perl
sub open_file {
    my $input_file = shift;
    open (my $file_handle, $_[0], $input_file) or die $!;
    return $file_handle;
}
```

Let's add one last subroutine and abstract the code that checks if the card is present. A novice developer may find it challenging to understand our regex, so we're going to create a subroutine named `mask_card_number` that will take an input line and returns the mask string if it contains credit card data. By doing this we can keep our regex hidden from the main script and makes our code more readable.

```perl
sub mask_card_number {
    my $line = shift;
    $line =~ s/(?<=NUMBER:\s)(\d+)(?=\d{4})/'*' x length($1)/e;
    return $line;
}
```

The output of our script has not changed, and our code is much more readable now.

---

Now that you've developed the module, and learned how to invoke it from the main script, let's learn how to package it so that other projects and teams can reuse it.

Perl provides us a utility named `h2xs` that lets you create a standard directory structure to distribute a module. Here is a brief background of this tool.

During the initial days of Perl, `XS` language was used to develop the glue code that Perl used to talk to C language libraries. The `h2xs` tool was primarily used to scan the C header file that ends in the `.h` extension and then generate the `XS` code directly.

You invoke this tool like this:

```bash
h2xs -AX -n FileMasker
```

The `-A` signals Perl to omit the autoloader code. In Perl, you can write an autoloader code to defer the loading of subroutines until they are explicitly invoked instead of loading the entire module all at once. You can compare this to lazy loading in other languages. The `-X` signals to omit any elements in `XS` language. There are also the `-n` option, which specifies the name of the module.

We get the following output:

```bash
Writing FileMasker/lib/FileMasker.pm
Writing FileMasker/Makefile.PL
Writing FileMasker/README
Writing FileMasker/t/FileMasker.t
Writing FileMasker/Changes
Writing FileMasker/MANIFEST
```

Inside the `lib` directory there is the actual module file that ends with a `.pm` extension. There is also a `t` directory designed to contain all the test code. Base directory contains the `Makefile` used during the module's installation process. Now we copy the subroutines created in our first `FileMasker.pm` to the new module inside the `lib` directory. 

The next step is to create an archive using the `tar` command. Like this:

```bash
tar -cvzf FileMasker.tar FileMasker
```

We get the following output:

```bash
a FileMasker
a FileMasker/Changes
a FileMasker/lib
a FileMasker/Makefile.PL
a FileMasker/MANIFEST
a FileMasker/README
a FileMasker/t
a FileMasker/t/FileMasker.t
a FileMasker/lib/FileMasker.pm
```

Now a compressed artifact containing our module has been successfully created. This file can be easily distributed now, and the recipient can uncompress the archive and install this module. But how? Well to simulate the download and install process, lets move to another directory and run the following command:

```bash
mkdir new_dir && cd new_dir
tar -xvf FileMasker.tar
cd FileMasker
perl .\Makefile.PL
gmake test #windows
make test #linux
```

As an output, we get the following output:

```bash
t/FileMasker.t .. ok   
All tests successful.
Files=1, Tests=1,  1 wallclock secs ( 0.00 usr +  0.00 sys =  0.00 CPU)
Result: PASS
```

Finally, to install our module we run:

```bash
gmake install #windows
make install #linux
```

The console prints the following:

```bash
Installing <some_dir>\site\lib\FileMasker.pm
Appending installation info to <some_dir>\perl\lib/perllocal.pod
```

---

Until here, you have seen how to develop and package your module so that others can use it. Now, you're going to learn how to download and install Perl modules returned by another user. You may remember that in the initial modules, there was mentioned that Perl has a common repository, like the Apple App Store, from where you can download Perl modules. That centralized repository is __CPAN__, short for Comprehensive Perl Archive Network. It consists of close to a quarter million Perl modules, so the chances are high that someone in the Perl community has a module already developed for some task that you are trying to accomplish in your project. So instead of reinventing the wheel, I would highly encourage you to check the __CPAN__ first before developing your own module.

There are a couple of ways you can install Perl modules. The first option is directly from the [website](https://metacpan.org), which is a Google-like search engine to search for CPAN modules. If you search for [DateTime](https://metacpan.org/pod/DateTime), you will be redirected to a sort of wiki page that provides a lot of information about the module (test coverage, version compatibility, link for download, install instructions, etc.).

The CPAN command-line interface (CPAN shell) is a utility that comes with the Perl distribution. You can use it to download and install modules from CPAN.

```bash
cpan

cpan shell -- CPAN exploration and modules installation (v2.28)
Enter 'h' for help.

cpan>
```

When installing modules, use the `i` command and be careful to type the module name accordingly, because module names are case-sensitive. 

```bash
cpan

cpan shell -- CPAN exploration and modules installation (v2.28)
Enter 'h' for help.

cpan> i DateTime

Module id = DateTime
    CPAN_USERID  DROLSKY (Dave Rolsky <autarch@urth.org>)
    CPAN_VERSION 1.65
    CPAN_FILE    D/DR/DROLSKY/DateTime-1.65.tar.gz
    UPLOAD_DATE  2023-11-06
    MANPAGE      DateTime - A date and time object for Perl
    INST_FILE    D:\Downloads\Programs\Perl_Portable\perl\vendor\lib\DateTime.pm
    INST_VERSION 1.54
```

Type `q` to quit.

---

Now that we are familiar with the CPAN shell, let's switch back to the web browser and see how to download and install Perl modules manually. You can, of course, use a one-line command to install it, but knowing how to install a module manually always helps if you are faced with any errors during the automatic installation process.

When you click on the download link, a compressed `tar.gz` Perl module is downloaded to the local machine. After extracting it, type the following command:

```bash
cd ..\DateTime-1.65\
perl .\Makefile.PL
gmake
gmake install
```

The final output should look like this:

```bash
Appending installation info to <some_dir>\perl\lib/perllocal.pod
```

This simple three-step process is all that is needed to install the module, and will help you if you are faced with any errors during the auto-installation process.

It's time to see this module in action.

```perl
#!usr/bin/perl
use strict;
use warnings;

require FileMasker;
require DateTime;

my $date = DateTime->now;
my $month = $date->month;

print "Current month: $month\n";
```

## Summary

- Understanding the value proposition of Perl modules and how to create them.
- Common errors faced while importing modules and fixing them using environment variables.
- How to package modules using `h2xs` utility.
- How to explore, download, and install CPAN modules, and how to import them on your script.