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

