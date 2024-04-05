# Perl 5: the big picture

Perl has been the go-to language of many system administrators to automate most of their mundane and repetitive tasks for more than three decades. It offers support to automate repetitive tasks, server-side CGI scripts, regular expressions, socket programming, web programming, network programming, data and cloud integration, major RDBMS and OS, and also object-oriented programming.

The following lessons will explore the value proposition of the Perl language and understand its features, demystify common myths and misconceptions around the Perl language, check if how Perl remains relevant in current times by exploring the companies that are currently using it, discover some business problems that the language solves at the various stages of a DevOps pipeline, them learn Perl ecosystem and understand the tools and utilities.

After seeing the big picture you're going to acquire the skills and knowledge as to why companies still rely on the Perl language to automate and integrate the many tasks in development and deployment pipelines.

> A course made by [Saravanan Dhandapani](https://www.linkedin.com/in/dsharu/).

## Value proposition of Perl language

Let's start imagining some company, PINES, which is an e-commerce platform specialized in product sales. The team lead (Joane) of this company is currently being assigned a task to automate some of the repetitive daily work in this project like, log processing, file handling, text manipulation, and data integration. 

She is currently evaluating program languages that will help him create a quick prototype that can be easily extended to an enterprise application later. With too many choices on the plate she approachs her chief architect (Tanabe), to explore options and to select one. Let's see how the chief architect helps the team lead determine the correct programming language to cater to the task at hand by answering some of the questions she has, clearing some of her cobwebs, and busting common myths and misconceptions behind the thought process.

When the chief architect comes to know the team lead requirement, she has no hesitation in proposing Perl as the language of choice. But the team lead was surprised to hear this, and she wanted to know if Pearl is still relevant in today's world of containers and clouds. And also questioned what other companies use Perl language today? And what business problems they are using Perl for solving it? And which other languages compete with Perl?

To address all her questions, the chief architect planned to set up three separate meetings with her.

- #1 Meeting: It is worth exploring Perl? The Who, What and Why aspects of the language.
- #2 Meeting: Introducing a typical DevOps pipeline and explore how Perl can be used at various development and deployment stages.
- #3 Meeting: Presenting the rich tools, modules, and utilities offered by the Perl language, and introduce the extensive Perl online resource and community.

## Getting to know Perl (#1 meeting)

During the discussion between Joane and Tanabe, Joane expressed that she is pleasantly surprised that Perl has been around for more than 3.5 decades. Let's explore a brief history of the language and learn from Tanabe how the language has evolved in the last 3.5 decades.

It all started with Larry Wall wanting to create a task involving report generation and file processing using `awk` and soon found out it's limitations. To address it, he developed a new language written in C, and borrowed concepts from other languages like `awk`, `sed`, and `lisp`, resulting in the Perl language. During it's initial days systems administrators heavily used Perl to automate some of the repetitives tasks involving text processing. If you have been in the industry for some time, you might have seen server-side CGI scripts being written in Perl. Later the language was enhanced to use regular expressions and socket programming. Release 5 of Perl made significant improvements introducing object-oriented programming features to it. Today, Perl can be used to develop web programming, network programming, data and cloud integration. It supports major database management systems like Oracle, PostgreSQL, and many more. For a long time, Perl was used in the UNIX environment only, today you will see Perl binaries that can be used in Windows and Mac, which means you can write a Perl program on one platform, and run on another.

When you run a Perl program, the Perl compiles the actual code behind the scenes into a machine-readable byte code format, which is later interpreted by the Perl interpreter. So for all general purpose, you will see Perl is referred to as an interpreted language. Unlike a language like C, which is a compiled language, your Perl program might run slow, still, the language packs a lot of additional features like easier debugging, linear type referencing, and a lot more.

As you continue your Perl journey, you will come across Perl 6, which is now renamed Raku. It is not intended as a replacement for Perl, and has its own set of libraries that can call Perl code, also implements object-oriented programming including generics and roles, and supports multi-core as well.

Joane is very impressed to hear how the Perl language has consistently evolved over a period of time, but she wants to know what features Perl offers that will fit her business requirement. So when evaluating a language, apart from its features, you also need to consider the learning curve and ease of use, and Perl scores high on both these aspects. An important feature that makes Perl stand out is its ability to perform complex file processing, it has no problem handling large binary and text files, breaking large files into individual lines and eventually to words. The regex engine provided by Perl is powerful enough to handle any complex text transformation and manipulation.

Until now, you'se seen some of the prominent Perl features, let's explore some of the not-so-noticiable features that make Perl language stand out. Perl offers a simple syntax that enables any developer learn the program on the fly and use it for quick prototyping. Perl provides a rich support to address many common development problems using pre-built modules. The language also offers additional modules that allow you to reuse programs written in other popular languages like Java, C, Python, PHP, C++, directly in your Perl code without you having to rewrite. Later we gonna discover about CPAN, that shorts for Comprehensive Perl Archive Network, which is a large repository of Perl modules (a concept similar to `npm` or `cargo`). And Perl has been a free language since its initial days, under GNU public license, and has a supporting community.

Joane is excited to hear all the features that Perl has to offer, but she's curious and skeptical to know if there are any limitations or drawbacks that she needs to consider. Perl philosophy is that there is more than one way to achieve a result, so you may see code that does the same thing written entirely differently in multiple places, which may result in unreadable code. Perl is designed to be written as smaller scripts typically less than 200 lines, it's not advisable to write larger programs as it will increase the complexity and it may be difficult to debug. Unlike other languages, Perl language does not have a built-in shell interpreter that lets you test individual commands and small code snippets. 

Though Joane heard about some of the drawbacks and limitations, she wants to equip herself and know the common misconceptions about the language so that she can talk to her team confidently.

1. Many people refer to Pearl programs as Perl scripts, but it is not a scripting language, a Perl program get compiled and interpreted by the Perl interpreter. So when someone refer to a Perl script, they're actually referring to a Perl program. 
2. Some people may say Perl is an ugly language but, in reality, there are no ugly languages but developers who write ugly programs. This is true not just for Perl, but for any other languages like C#, PHP and Java.
3. Since Perl is used extensively in text processing and manipulation, most of the Perl programs use regular expressions, which are not straightforward to comprehend, and this gives a notion that Perl is harder to learn as it deals with regular expressions. 
4. Perl is only used with UNIX operating system, this was true on Perl initial days, but today Perl can be used in all major OS like Mac, Windows and all flavors of Linux.
5. You may hear people say that Perl cannot be used for enterprise-grade software and that is suitable only for one-liners or short scripts, as we've seen before Perl is based on C language, so any program that can be written in C can be written in Perl as well.
6. Another common misconception is that Perl and CGI are the same, they're absolutely not, CGI is just a communication protocol between a program and a web server, and Perl is the language that enables this communication, as a matter of fact you can write CGI programs in C language or any other language of choice.
7. The fact that Perl is not a commercial software has created a lot of misconception that a program written in Perl is not secure, as mentioned before is not the problem with the language, but the problem with developers writing insecure code, and that's applicable for any other language. Perl itself is a highly secure language it has a special "taint" mode that scrutinizes user input and help avoid common security issues.

Let's switch gears and explore how Perl reduces business risks. The fact that Perl is not tied to any single company should give you enough confidence that the language cannot be dictaded by stockholders, or by the health of a company, or by specific vendor's proprietaty tools. With Perl being supported by multiple platforms, you can write portable cross-platform code that seamlessly works. Many security-related issues occur because of poor memory handling in the code, but Perl does memory management internally and you don't have to be focused on allocating and releasing the memory. According to [Coverity](https://www.synopsys.com/software-integrity.html), which scans many open-source projects, Perl has 1.1 million lines of code and a very low defect density of 0.05, the defect density is measured by the number of defects per one thousand lines of code. Perl is also certified free of security flaws. Since Perl is a high-level language, it enables you to quick prototype any large projects and present the core features to the customers.

Joane is thrilled and feels she is equipped well with the knowledge to demystify the commons myths and misconceptions, and now she is curious to know who else uses the language in the industry, is it being used only to manage some legacy projects, or is it being used by startup companies as well? Let's explore some of the top companies that currently use Perl.

Companies like Amazon, Google, Yahoo, 3M, Morgan Stanley, Booking.com, and Shutterstock use Perl today in their day-to-day system administration tasks. Apart from these some popular tools like IBM DB2, Swagger codegen, Nginx unit, Coderunner, and Mojolicius, offer integration with Perl. So is Perl being used only by large companies with some legacy projects, or is it being used by some startups too? Venmo is a popular payment service like [Zelle](https://www.zellepay.com) and it is a peer-to-peer payment application. DuckDuckgo is an anonymous search engine that focuses on your privacy and not your personal data. SendGrid is a popular communication platform that is used for sending and receiving e-mail which is used by some large corporations like Uber, Airbnb, Yelp, and Spotify. TicketMaster is a large marketplace that allows their customers to buy and sell tickets online for any major events like sports and concerts. Zoopla, a british online real estate company similar to Zillow in the US. And many, many, more startups use Perl language today.

## Undestanding how Perl solves business problems (#2 meeting)

Joane learned about key Perl features that helps alleviate business risks, though she started this journey looking only to automate repetitive sysadmin tasks. She is curious to know if there are other places in her project pipeline where Perl can be leveraged. In this meeting with Tanabe she wanted to share her project pipeline so she could get prescriptive suggestions from her. Before we hear Tanabe's recommendations, let's understand Joane's current DevOps pipeline.

Once the requirement gathering is finalized, developers get assigned to user stories and begin their development work, it's a typical web application. Most projects use a web framework to build the front-end part instead of building it from scratch, and Joane's project is no different. They're also using an ORM to connect to their backend Oracle database. Some of the text-based data is kept in AWS ES3 buckets, and that application needs to interact with it to read data. At the end of every day, developers are required to check-in the code to the code repository and the build will be triggered immediately to validade the code and they use Jenkins for the continuous integration. A set of unit testing is run against the code after every successful build completion, all the unit tests are written using JUnit and NUnit, and Sonar is used for the code coverage. At the end of every interation, the code is released to the QA environment for the QA team to perform their functional and integration testing. Once all the features have been developed, the management team will conduct a go/no go meeting to release the features to production. Once the code is released, the customers are alerted to start their validation process. The operation team is kept on high alert to monitor the logs, look for errors, and alert the team if they see any issues. Today, most of this monitoring is happening manually, which needs to be automated eventually. Now that Tanabe has gained insight into Joane's project delivery pipeline let's hear her suggestion.

---

Before providing specific suggestions, Tanabe wanted Joane to understand Perl's CPAN repository, which is a source for all Perl modules like the Apple App Store from where you can download Perl modules, that central repository is CPAN a short form for the Comprehensive Perl Archive Network. It consists of close to a quarter million of Perl modules, so the chances are high that someone in the Perl community has a module already developed for some of the tasks that you're trying to accomplish, so instead of reinventing the wheel, it's a wise idea to always check the CPAN first before developing your own module. There are a couple of ways a Perl module can be downloaded and installed.

You can visit the CPAN website [here](https://metacpan.org) which is a Google-like search engine to explore CPAN modules, with you type `Dancer` you will find a popular Perl web framework that can be leveraged in your UI development, the type ahead feature displays all the matched modules, if we select the `Dancer` option we'll be redirected to the module homepage. All modules will have a similar page that will identify their name, version, and other information, some of these modules will have detailed documentation and is encouraged to you to read them to understand a specific module that you may need. The homepage also presents the module version and the Perl version to which it applies, there's also a coverage measure indicating the test coverage of this module, higher the number means the module is thoroughly tested. Under tools you have the option to jump to any specific version or check the difference with any particular version. When you click the link install instructions, the module install instructions window will show up and it gives you the single-line command to install it from `cpanm` or `CPAN shell`. When you install Perl, a CPAN command-line utility is installed as well, to access this utility, just type the command on any prompt:

```bash
$ cpan
cpan shell -- CPAN exploration and modules installation (version number)
Enter 'h' for help.

cpan[1]>
```

To list the options available just type `h` key. To install a module type `i <module_name>` followed by enter, the modules names are case sensitive.

To quench Joane's thirst, Tanabe planned to show a quick demo on how easy it is to run a web server in Perl.

```bash
$ dancer -a <project-name>
$ cd <project-name>/bin
$ perl app.pl
```

We initialized a new directory with the app name and a bunch of files were installed, move to the application new directory and runned our application.

This web framework can be leveraged to build small sites and applications, however there are other web frameworks like Catalyst, which is a powerful web framework for building large applications. Catalyst is the most mature web framework for Perl. Another framework worth considering is Mojolicius, which has a real-time design based on high performance event handling, it also can help you define well-structures MVC web applications, it's all about CSS3, TLS, web sockets, promises, async/await, connection pooling, and compression support, it also has a JSON and XML parser.

Now let's take a look at some of the commonly used Perl ORMs. `DBIx::class` is one of the top Perl ORMs that provides an API to our database based on the concept of queries and results. This module needs a little bit of a learning curve, especially if you haven't used an ORM before, but the features it offers to enhance the maintanability are worth investing time in learning about this module. Suppose you are using a NoSQL database in your project, in that case the recommendation is to consider the `DBIx::NoSQL` which is a layer over DBI to store and retrieve data.

Joane is excited to learn the minimalistic approach of Perl and how lightweight the Perl modules are that would help her accomplish a task. She can't wait to learn how Perl can be leveraged in QA testing. There are many Perl modules that can be downloaded specifically for testing purposes, the `Test::AtRuntime` is an assertion-like testing, that let's you test your code when it runs. The `Test::Benchmark` helps you compare two functions and test their execution speed. The `Test::More` is the most commonly used test module, with the latest Perl release this module has almost become the testing standard. The `Test::unit` lets you perform unit testing for Perl. Perl also provides database testing modules, `DBD:mock` is a DBI-compliant database driver which allows you to prepare and execute SQL statements and inspect the result sets. Testing has been an integral part of the Perl language since it's initial days, the Test Anything Protocol, called TAP, developed by Larry Wall during Perl initial days is available for any languages. This protocol is used to communicate between the unit tests and test harness. Individual tests, also called TAP producers, communicate the result sets to the testing harness in a language-independent way, TAP consumers are the test harnesses that read TAP and do something useful with that information. Though TAP started with Perl, today it has it implementation in languages like Java, C++, PHP, Python, and Go. The TAP producers and the TAP consumers can be written in entirely two different languages.

Now talking about common sysadmin tasks that can be performed with Perl. For many developers, the sysadmin scripts are the initial introduction to the Perl language as this is the initial reason the language was developed. There are many Perl modules that let you perform file processing and directory traversing. You need to consider `File::spec` which is a core Perl module to handle file and directory paths, there is `File::path` another core module to create and remove directory trees, and `File::copy` that let's you copy files, and `File::find` which is another built-in module used explicitly for traversing a directory tree. When it comes to system monitoring, Perl shines big time, there are many Perl-based monitoring packages available in the marketplace, some of the commonly used ones are `mon`, one of the simpliest monitoring products, though the active development has slowed down, you can consider this package has been developed by sysadmins for sysadmins. Another monitoring package worth considering is `OpenSMART`, this package can be leveraged not just for monitoring, but for report, and asset management as well.

---

Though Tanabe has helped Joane identify many Perl modules and offered prespective guidance, there is an important topic that Joane could not wait to discuss. As you remember, Joane's project leverage AWS S3 (Simple Storage Service) to read data, so she is curious to know if there are ways to leverage integration with AWS, afterall she wanted to avoid using proprietary vendor tools to access data stored in the cloud. As a matter of fact, this is a concern for many corporations, as relying on vendor-specific tools will result in vendor lock-in, and it may not be good for the corporations. Perl provides `AWS::S3` module, a lightweight interface to access Amazon S3 buckets, until `AWS::S3` gets to version 1.000 it will not implement the full S3 interface, also `AWS::S3` is NOT a drop-in replacement for `Net::Amazon::S3`. Here a few code snippets from it:

```perl
use AWS::S3;

my $s3 = AWS::S3->new(
  access_key_id     => 'E654SAKIASDD64ERAF0O',
  secret_access_key => 'LgTZ25nCD+9LiCV6ujofudY1D6e2vfK0R4GLsI4H',
  honor_leading_slashes => 0, # set to allow leading slashes in bucket names, defaults to 0
);

# Add a bucket:
my $bucket = $s3->add_bucket(
  name    => 'foo-bucket',
);

# Add a file:
my $new_file = $bucket->add_file(
  key       => 'foo/bar.txt',
  contents  => \'This is the contents of the file',
);
 
# Get the file:
my $same_file = $bucket->file( 'foo/bar.txt' );

# Delete the file:
$same_file->delete();
```

Also note that this module can be used only to access AWS S3 buckets. If you're using Azure, Perl offers `Net::Azure::StorageClient` module to access the blob storage. But does Perl only have modules to access a storage, or can we access the virtual machines running on AWS as well? Yes, we can do it by using the module `Net::Amazon::EC2`, which provides a Perl interface to Amazon EC2 using EC2's query API. It is encoraged to use this module documentation and check it's usage beforehand, you may refer to a similar module called `VM::EC2`, a few code snippets of this module below and dependency graph [here](https://cpandeps.grinnz.com/?dist=VM-EC2&dist_version=&phase=runtime&perl_version=v5.36.0&style=concentric).

```perl
use VM::EC2;

# get new EC2 object
my $ec2 = VM::EC2->new(-access_key => 'access key id',
                       -secret_key => 'aws_secret_key',
                       -endpoint   => 'http://ec2.amazonaws.com');
 
# fetch an image by its ID
my $image = $ec2->describe_images('ami-12345');
 
# get some information about the image
my $architecture = $image->architecture;
my $description  = $image->description;
my @devices      = $image->blockDeviceMapping;
for my $d (@devices) {
   print $d->deviceName,"\n";
   print $d->snapshotId,"\n";
   print $d->volumeSize,"\n";
}
```

So far, we've looked at Perl at a very high-level. Joane is now more interested in getting to know some final details, the look and feel of Perl code, and learn about tools and utilities offered by Perl.

## Exploring Perl ecosystem (#3 meeting)

Joane has gained many insights on Perl language in her previous two meetings with Tanabe, she's excited to meet her again and explore Perl's utilities and tools.

You already know that Perl is supported by all major OS, and it's prebuilt in UNIX and MacOS, but if you're running Windows you need to download the Perl binaries, and they are provided in two different flavors, there is **Strawberry Perl**, which is very close to the Perl binaries on UNIX systems and is free to download and install, the second one is **ActiveState Perl**, which comes prepackaged with a number of Perl modules that are precompiled and ready to use, the free version of ActiveState lets you run one active runtime only and it has multi-tier pricing options based on your needs, one of the added benefits of using ActiveState is that it provides a program named `PPM`, a short form for Perl Package Manager, that let's you seamlessly download and install Perl modules from CPAN.

When it comes to IDE, you have plenty of choices. Some of commonly used cross-platform IDEs are Eclipse, Komodo, Padre, and Perledit. There is also some cross-platforms text editors that can be used for Perl development because, at least for the basics, you don't need any fancy editors or IDEs to run your Perl programs.

The Perl community recommends a few Perl helper tools to help during your development process. The first one is the `Perl::critic` module, that analyzes Perl code and alerts bad practices followed in your code, as we've saw previously there is more than one way accomplish a task using Perl, so it's very easy for the developers to quickly churn out some code that just gets the job done withour paying attention to the code readability, maintanability, and possible security flaws, that's way the use of a static code analysis tool matters, this module comes prebuilt with a number of standards that keep your code clean and help write high quality code.

`PerlTidy` is a Perl code formatter that can help you maintain a consistent style across your codebase, one comment offten made by developers is that Perl code is not readable, and here is when `PerlTidy` shines, enabling you to solve that problem by maintaining a Perl style guideline, it allows you to write your own guidelines and not just rely on the pre-built ones provided by the tool. 

Now suppose you're going to write a lot of regular expressions in your code, in such a case, consider taking a look at `Regex coach`, which is a graphical application to experiment with regex. And if you're working with databases, you may need to consider `Sqitch` which is a change management tool, not tied to any single database or ORM, it let's you write generic scripts that accomplish common database tasks, and will translate them to database scripts.

---

Now that Joane has a handle on the Perl tools and utilities commonly used in your development environment, let's go one more level deep and look at Perl code.

```perl
#!/user/bin/perl

use strict;
use warnings;

Print "Привет, мир!";
```

The first line of any Perl program always start with a hash mark followed by exclamation mark, aka _shebang_ (#!), it helps to indentify the Perl interpreter location, so be aware because not all Linux environments will have Perl installed at `/user/bin/perl`, so check first the proper installation path using the `which` command to get the Perl location and use that location as a first line in your script. Similar to how Windows uses environments variables to resolve the Perl install location, the _shebang_ operator indicates the Perl location in a Linux environment. You also need to ensure that your Perl program has the `755` permission before running in a Linux environment, if not you can use the `chmod` command and set proper permissions.  

The next two lines are called _pragmas_ in Perl, and you can imagine it like a switch that lets you turn on and off setting features. With the `use strict` pragma, we let the interpreter alert us of any unsafe code, or code that may exhibit unexpected behavior at runtime. The next pragma `use warnings` will help you find mistakes in your program like using a deprecated syntax or modules. An important difference between these two pragmas that you must remember is that `strict` pragma will abort the execution if there are errors, whereas `warning` pragma will continue the execution.

Finally the program prints a hello world string in double quotes to the console. Perl strings can be enclosed in single or double quotes, but you can also use parenthesis or completely omit it.

```perl
#!/user/bin/perl

use strict;
use warnings;

print "1. Привет, мир!";
print '2. Привет, мир!';
print ("3. Привет, мир!");
print ('4. Привет, мир!');
```

It is important to remember that the double-quoted string replaces variables inside it by their values, while the single-quoted string treats them as text. This is known as variable interpolation in Perl.

You may have heard that Perl is an interpreted language, and some may say it is a compiled language. Suppose you are coming from the Java universe, in that case you might expect a two-step process for a compiled language, where the source code gets compiled to a bytecode and generates an intermediated `.class` file, then the interpreter eventually runs this `.class` file. But a Perl program can be run simply by running the `perl` command, followed by the program name.

Perl has only three variable types: scalars, arrays, and hashes. Unlike a strong typed language, you don't need to explicitly define your integers, floats, and strings. Joane is a bit concerned about the lack of variable types, and Tanabe quickly clarified that Perl would automatically convert the variables to appropriate types based on the value assigned to it. All **scalar variables** needs to start with a dollar symbol ($). By default, all Perl variables will have a global scope. You can create a **lexical scoping** to your variable using the `my` keyword. Referring to the code snippet provided below, the variable `cardName` is automatically converted to a String variable, and the variable `cardLength` is converted to an integer variable.

```perl
my $cardName = 'Elo';
my $cardLength = 12;
```

The array variable type represents a list of values. All Perl arrays are prefixed with the at sign (@). All array elements start at index zero, meaning that to access the first element , you need to use the index [0]. A Perl array can contain a string, integer, or a floating point number as it elements. As a matter of fact a Perl array can have another Perl array too.

The hash variable type represents a set of key-value pairs. All Perl hashes must start with a percentage symbol (%). The key-value pairs are separated using `=>`.

Perl provides multiple looping constructs to write branching and conditional logic. You can write a for loop, do loop, and while loop. And you can write conditional logic using if/else statement.

Perl doesn't have a typical switch-case statement, instead, it provides a given/when construct that achieves the same result.

---

Joanne is thrilled to see the Perl language's simplicity and ease of use, she wants to get a feel for how Perl's file handling and regular expressions are performed. Perl let's you perform file read and write operations with a single line of code. Let's move to another code snippet to demonstrate it:

```perl
my $file = 'dummyfile.txt';

open (my $wfh, '<', $file);
```

The statement `my $file = 'dummyfile.txt';` assigns a value of `dummyfile.txt` to a scalar variable file. The `open` command accepts three arguments, the first is a scalar variable and you can think of it as file pointer, the second argument dictates the mode of operation (read, write, or append), the third argument is the actual file variable which the file name is assigned. This single line of Perl code is good enough to open a file in read mode. If you want to write contents to a file, all you need to do is change the file mode from read to write (`'>'`) or append (`'>>'`).

This looked too good to be true to Joane and she wanted to know how to handle the negative cases, like file not being present, file not having the right access, or any other negative cases that may happen. That's simple as well, all you need is a simple if loop that checks if the file exists, which can be achieved using the `-e` switch. You can also check if the file is readable using the `-r` switch.

This is great to handle all compile-time scenarios gracefully. How about gracefully handling runtime errors? What if you want to terminate the program or issue a warning to the user if the file does not exists? You can achieve it using a `die` or `warn` class followed by the Perl special variable `$!`, which prints a system error. The `die` class will cause the program to exit, whereas a warn will continue with execution.

```perl
my $file = 'dummyfile.txt';

if (-e -r $file)

open(my $wfh, '<', $file) or die $!;
```

Now let's see how regular expressions are handled in Perl. The first thing you will notice while using regular expressions is a pattern-binding operator:

- `=~`: checks if the value held by the variable to its left matches the pattern.
- `!~`: checks if the value held by the variable to its left doesn't matches the pattern.

Typically, you will see an if statement surrounding this tests, but there are three different regular expressions in Perl.

- `m//`: the match operator, used to match a string or a statement to a regular expression.
- `s///`: the substitution operator, used to search a string or a statement that matches the given regular expression and replace occurrences of this pattern with the replacement pattern.
- `tr///`: the translation operator, used to convert strings on a character-by-character basis. Useful in situations like when you want to convert all lowercases characters to uppercase.

These operators also come with operator modifiers that can be added at the end, that makes the operation case insensitive `/i`, perform global operations `/g`, and many more.

Joane is aware that Perl has been used primarily as a procedural language during it's beginning days. Now with latest release, Perl supports object-oriented programming. She's curious to know how Perl implements the object-oriented design.

The keyword `package` is used to define a class, and typically all the classes are saved in separated files. A class can contain properties and methods, and those methods are implemented using Perl subroutines. To import our references class in a different program, we need the `use` keyword that exposes the class to the current program and use the `new` keyword to create an instance of an object of this class. Perl supports inheritance that let's you write a class that inherits the properties and methods from the pattern class. Unlike Java and other popular languages, Perl allows multiple inheritance but is strongly recommended against using it. Perl does support other object-oriented features like polymorphism and encapsulation.

---

Joane feels that she learned a lot from the last three meetings with Tanabe. However, there is one thing that is still at the back of her mind that is unanswared. She wants to know how Perl compares with some of the other popular languages like Python, PHP, and Ruby, and also learn what value propositions they offer and how Perl compares with the features offered by other competing languages. Let's dive deep and learn about Perl competition.

You should not be surprised when I say Python is the number one competitor. Just like Perl, it is also compiled and interpreted language, and it is supported on multiple OS like Mac, Linux and Windows. It let's you write both, procedural and object-oriented code. Pytohn is open-source and just like Perl has extensive libraries and modules. An important area where Perl differs from Python is the code readability, you learn that Perl has more than one way to write a code, but Python has a simple, one-answer solution. In the area of machine learning and data science, Python has become the de facto standard.

Though both Perl and PHP are open-source free languages and they support to write procedural and object-oriented code, one of the areas where PHP stands out is its ability to be easily embedded into HTML documents. We saw that Perl has only three data types, and all the primitive data types are grouped as scalar variables, but in PHP you have the primitive types. Perl was developed as a general purpose scripting language, thus PHP was developed to be used for scripting web pages, so a lot of web-related things like sending an e-mail from your web page of fetching a document from HTTP or FTP server are baked inside the language, in contrast, you may need to rely on modules to achieve the same tasks in Perl. When it comes to text processing PHP cannot beat the features offered by Perl.

Like Perl CPAN module system, Ruby has RubyGems, which is a common package repository. Both excel when it comes to regular expressions because regex is built right into the language. Ruby is a strict object-oriented language, thus everything is considered as object. You've saw that Perl was heavily influenced by languages like C, AWK, Sed, and Lisp, whereas Ruby is influenced by C++ and Java. Ruby is extensively used in meta programming and functional programming. It can be leveraged in designing web applications that cater to heavy traffic, but Ruby has less support for Unicode compared to Perl.

When evaluating a language for your project, the 'one size fits all' approach doesn't work. Select a language that suits your business requirement.

## Your next steps

- [Perl official site](perl.org)
- [Perl official documentation](perldoc.perl.org)
- [Perl debugging tools](debugger.perl.org)
- [Perl FAQ](learn.perl.org/faq)
- [Regex 101](regex101.com)
