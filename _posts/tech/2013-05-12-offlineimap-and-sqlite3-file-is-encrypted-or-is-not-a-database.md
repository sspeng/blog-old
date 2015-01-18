---
layout: post
title: "OfflineIMAP and Sqlite3: file is encrypted or is not a database"
comments: true
categories: tech
tags: [Mutt]
---

When I fetch emails by `offlineimap`, it takes long time to stop it. 
Usually I will invoke `kill` command to kill it immediately. With such an 
violent way, the database sometimes will corrupt, thus showing the 
following error message when you invoke `offlineimap`

    Creating new Local Status db for Local-Gmail:INBOX-journal
    ERROR: While attempting to sync account 'GMail'
           file is encrypted or is not a database

There are two way to fix such kind of problem. 

### Delete the Database
The most simple and effective way is to delete the database (just an index) 
and rerun `offlineimap`, the database will be reconstructed. To delete it, 
you can delete the whole directory `~/.offlineimap` or the database file in 
`.offlineimap/Account-<YourAccountName>/LocalStatus-sqlite`

### Fix the database
The other way is to fix the specific database. First go on 
`.offlineimap/Account-<YourAccountName>/LocalStatus-sqlite`, open the file 
INBOX with sqlite3 by command `sqlite3 INBOX` and type `pragma integrity_check;` (and press Enter):

    SQLite version 3.7.14.1 2012-10-04 19:37:12
    Enter ".help" for instructions
    Enter SQL statements terminated with a ";"
    sqlite> pragma integrity_check;

Now you can quit with `.quit` and restart offlineimap

#### Reference
[OfflineIMAP and Sqlite3: «file is encrypted or is not a 
database»](http://blog.kdecherf.com/2012/12/23/offlineimap-and-sqlite3-file-is-encrypted-or-is-not-a-database/)
