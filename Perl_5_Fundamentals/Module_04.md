# Module 04

In this module we'll cover different approaches on handling files in Perl. This module will play a critical role in developing our main utility, as it needs to read log files and process them.

But before you start reading files, you need to know how to open and close them, and that's precisely what we're going to see now.

Our first assignment will be learning how to fetch the directory name from the user input, proceed to open this directory, read all the files listed on it and then filter only those that end with a __.log__ extension, close the file, and finally close the directory. Further on these lessons, you will learn how to read the file contents and how to process them.

An important concept that you need to understand while working with any files in Perl is __file handles__. Just like how you open a car using the door handle, you access the files and directories using handles.

Let's check out in action:

```perl
#!/usr/bin/perl

use strict;
use warnings;

my $log_directory = <STDIN>;

chomp $log_directory;
$log_directory =~ s/^\s+|\s+$//g;

print "Log directory is: $log_directory\n";

my $openSuccessful = opendir(my $directory_handle, $log_directory);
if ($openSuccessful) {
    print "Opened $log_directory successfully\n";
} else {
    print "Could not open $log_directory: $!\n";
}

print "Start reading the log files...\n";

while (my $filename = readdir($directory_handle)) {
    if ($filename =~ /\.log$/) {
        print "Opening file: $filename\n";
        open (my $file_handle, '<', $filename)
    }
}
```

| Mode | Privileges                                                     |
|:----:|:--------------------------------------------------------------:|
| <    | open file in read only mode                                    |
| >    | can create new file, clear the file's content, and write to it |
| >>   | can create a new file, write, and append to a file             |
| +<   | let you read and write, but won't let you create a new file    |
| +>   | can create a file, clear the contents, read and write to it    |
| +>>  | can create a file, read, and append to it                      |

And that's the output of our program.

```bash
> perl .\src\module_04\file_handles.pl
> <full_path>\src\module_04\log_directory\
> Log directory is: <full_path>\src\module_04\log_directory\
> Opened <full_path>\src\module_04\log_directory\ successfully
> Start reading the log files...
> Opening file: transaction.log
```

Though Perl will close all the unclosed file handles, it is always a good programming practice to close the file handles explicitly in your script once the process is complete.

For that you can use the `close` function passing the file handling as an argument.

```perl
print "Closing file: $filename\n";
close $file_handle;
```

---

Let's continue the script that we worked on and learn how to read the file contents and print it to the console.

Just before closing our file, we will add the following code to our script:

```perl
while (my $line = <$file_handle>) {
    print "$line\n";
}
```

Perl is all about writing concise code. We're already familiar with some Perl default variables, we can actually simplify this while loop.

When data is read using a diamond operator, the output by default is assigned to the `$_` variable. The following code performs the same task:

```perl
while (<$file_handle>) {
    print "$_\n";
}
```

Now imagine a scenario where you have been asked to read by skipping the first *x* number of bytes. Perl offers the `tell` function to get the current file pointer position in bytes.

```perl
while (<$file_handle>) {
    print tell($file_handle), "  $_\n";
}
```

In order to skip the first *n* lines, you can use the `seek` function. It takes three arguments: a file handle parameter, the position from where the reading process should start (in bytes), and the relative position from where the reading process should end that can be omitted (0 means from the beginning, 1 means from the current position, and 2 means from the end).

```perl
seek($file_handle, 1818);
while (<$file_handle>) {
    print tell($file_handle), "  $_\n";
}
```

---

It's time to explore more about how to write contents to a file. First you have to create an output file, and every time that a line is read from the input file, check if the string contains "Store" on it, if so, write the text "Store transaction detected" in the output file.

```perl
my $output_filename = $log_directory.'output.txt';
open (my $output_file_handle, '>>', $output_filename);
```

We are about to append content to our output file. Here is the logic to check if the reading line contains "Store":

```perl
if ($line =~ /Store/) {
    print "Store transaction detected!\n";
    print $output_file_handle "Store transaction detected!\n";
}
```

By referring to the output file handle in our print statement, we are writing to the output file. Just don't forget to close the output file handle, as it is a good programming practice to do so.

---

Let's move on and explore more about file operators. You can check all available file operators [here](https://perldoc.perl.org/functions/-e#-X).

Until now, we were reading and writing to a file that existed. We didn't address any negative cases. What if the file you are trying to read is not present? What if the file you're trying to read is not readable? And what if the file you're trying to write to is not writable? What if the file you're trying to read is empty? These are just a few exceptions and error conditions that you must address while working with files.

Let's jump back to code and check out the features offered by Perl exclusively to address many of these scenarios.

Remember that `print` at the beginning of our script just before opening the `.log` file?

```perl
print "Opening file: $filename\n";
open(my $file_handle, '<', $log_directory.$filename);
```

Here is a snippet of how you could check the existence of the file using the `-e` operator:

```perl
if (-e $log_directory.$filename) {
    print "Provided file exists.\n";
} else {
    print "Provided file does not exists.\n";
}
```

Here is a snippet of how you could check if the file is readable using the `-r` operator:

```perl
if (-r $log_directory.$filename) {
    print "Provided file is readable.\n";
} else {
    print "Provided files is not readable.\n";
}
```

Here is a snippet of how you could check if the file is not empty using the `-s` operator:

```perl
if (-s $log_directory.$filename) {
    print "Provided not empty file.\n";
} else {
    print "Provided empty file.\n";
}

# To check if file is empty use the -z operator
if (-z $log_directory.$filename) {
    print "Provided empty file.\n";
} else {
    print "Provided not empty file.\n";
}
```

You can combine these operators to check for multiple conditions at once preventing code duplication, like this:

```perl
if (-e -r -s $log_directory.$filename) {
    print "Provided file exists.\n";
} else {
    print "Provided file does not exists.\n";
}
```

Here some 7 commonly used file operators:

| Switch | Checks if file is... |
|:------:|:--------------------:|
| r      | readable             |
| w      | writable             |
| x      | executable           |
| e      | exists               |
| z      | non-empty            |
| d      | directory            |
| l      | symbolic link        |

---

It's time to explore the error handling and error reporting in Perl. Generally, there are two ways an error is handled in any script.

The first option is to throw a warning message, which is considered as an __error reporting__, the script typically continues to run after issuing the warning message. Whereas, the second option is to throw an exception and subsequently exit the script, which is typically referenced as __error handling__.

You're already had a glimpse of handling errors while opening a directory. Let's now explore other Perl features and handle errors effectively.

Remember that the function `opendir` returns a boolean indicating if it was successful in opening the directory. So if it returns `false`, let's warn the user that the directory doesn't exist. We could implement this logic using the `ifnot` statement, but to make our script more readable let's use the `unless` statement.

```perl
my $directory_handle;
unless (opendir($directory_handle, $log_directory)) {
    warn "Could not open $log_directory: $!";
}
```

The execution of our script continued after the warning which still tried to read the directory where it eventually failed. We would rather have our script exit once the directory is not found.

For that Perl offers the `die` function:

```perl
my $directory_handle;
unless (opendir($directory_handle, $log_directory)) {
    die "Could not open $log_directory: $!";
}
```

Now our script exited when the directory is not found.

Do not forget that Perl is all about writing concise code. So we can actually rewrite the previous script as follows:

```perl
my $directory_handle;
opendir($directory_handle, $log_directory) or die "Could not open $log_directory: $!";
```

Now our script continues the execution when `opendir` returns a true value. If it returns false, the `die` function is called, and the script execution is aborted.

We're using the Perl special variable `$!` to get the original error message from the function, it works with both `die`, and `warn` functions.

---

Perl also offers a few other errors handling functions using the `Carp` module. To use this feature, you must explicitly reference the pragma `use Carp;`. By using this pragma you grant access to a function named `carp`, which is equivalent to `warn`; and a function named `croak`, which is equivalent to `die`.

You may wonder why Perl offers two different functions achieving the same behavior. In a single script program, there is hardly any difference, but when your script invokes other modules, the `carp` function will be very handy, because this function provides you more context to the error messages, giving you insights to the caller program.

We are going to learn more about Perl modules and subroutines later on this course. For now let's have a look at these two functions.

You can imagine subroutines as user-defined functions, whereas functions like `index` and `substr` are defined by Perl itself.

```perl
sub where_am_i {
    warn "Function called from ", (caller)[1], " at ", (caller)[2], "\n";
}

sub where_am_i_carp {
    carp "Function called from ", (caller)[1], " at ", (caller)[2], "\n";
}

where_am_i();
where_am_i_carp();
```

Check out the output provided by them:

```shell
Function called from .\src\module_04\file_handles_error_handling.pl at 15
Function called from .\src\module_04\file_handles_error_handling.pl at 16
 at .\src\module_04\file_handles_error_handling.pl line 12.
        main::where_am_i_carp() called at .\src\module_04\file_handles_error_handling.pl line 16
```

You can see the warning message from the `warn` function provides you no insights from where the error originated, whereas the warning message from the `carp` function gives you the exact line number of the script from where the error originated. This is priceless information for a module and script developer, so remember that, though they both look similar, they solve two different problems altogether.

When working with a single script, `warn` and `die` will work just fine. But when working with multiple modules, the `carp` and `croak` functions will be more useful.

## Summary

- Importance of file handles in file manipulation on directories.
- The six file modes supported by Perl.
- How to read files fully and partially by moving the file pointer to a specific location.
- How to create a file handle for writing an output file and write contents from our script to the output file.
- File operators and how to combine them to write clear, concise code.
- Alternatives for error reporting and error handling.
