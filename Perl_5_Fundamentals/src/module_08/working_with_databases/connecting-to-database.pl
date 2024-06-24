#!/usr/bin/perl

use strict;
use warnings;
use Config::Properties;
use DBI;

# Subroutine to connect to PostgreSQL and execute insert
sub connect_and_insert {
    my ($db_name, $db_user, $db_pass, $db_host, $db_port, $sql) = @_;

    # DBI connection string
    my $dbh = DBI->connect(
        "dbi:Pg:dbname=$db_name;host=$db_host;port=$db_port",
        $db_user,
        $db_pass,
        { AutoCommit => 1, RaiseError => 1 }
    ) or die "Failed to connect to database: " . DBI->errstr;

    # Prepare and execute query
    my $sth = $dbh->prepare($sql);
    $sth->execute() or die "Failed to execute query: " . $sth->errstr;
    $sth->finish();

    # Disconnect from the database
    $dbh->disconnect();
}

# Subroutine to connect to PostgreSQL and execute query
sub connect_and_query {
    my ($db_name, $db_user, $db_pass, $db_host, $db_port, $sql) = @_;

    # DBI connection string
    my $dbh = DBI->connect(
        "dbi:Pg:dbname=$db_name;host=$db_host;port=$db_port",
        $db_user,
        $db_pass,
        { AutoCommit => 1, RaiseError => 1 }
    ) or die "Failed to connect to database: " . DBI->errstr;

    # Prepare and execute query
    my $sth = $dbh->prepare($sql);
    $sth->execute() or die "Failed to execute query: " . $sth->errstr;

    # Process results
    while (my $row = $sth->fetchrow_hashref) {
        print "ID: $row->{id}, Name: $row->{name}, Price: $row->{price}\n";
    }
    $sth->finish();

    # Disconnect from the database
    $dbh->disconnect();
}

# PostgreSQL database credentials
open (my $dbfh, '<', 'db_credentials.txt') or die $!;
my $properties = Config::Properties->new();
$properties->load($dbfh);
my $db_name = $properties->getProperty('POSTGRES_DB');
my $db_user = $properties->getProperty('POSTGRES_USER');
my $db_pass = $properties->getProperty('POSTGRES_PASSWORD');
my $db_host = $properties->getProperty('POSTGRES_HOST');
my $db_port = $properties->getProperty('POSTGRES_PORT');

# Connect to the PostgreSQL database informing the PostgreSQL driver
my $dsn = "DBI:Pg:dbname=$db_name;host=$db_host;port=$db_port";
print "Connecting to $dsn\n";
my $dbh = DBI->connect($dsn, $db_user, $db_pass, {
    PrintError       => 0,
    RaiseError       => 1,
    AutoCommit       => 1,
    FetchHashKeyName => 'NAME_lc',
});

my $insert = "INSERT INTO houses (name, price) VALUES ('House 11', 9999990.00);";
connect_and_insert($db_name, $db_user, $db_pass, $db_host, $db_port, $insert);

my $query = "SELECT * FROM houses";
connect_and_query($db_name, $db_user, $db_pass, $db_host, $db_port, $query);
