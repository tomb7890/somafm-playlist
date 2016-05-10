Somafm-Playlist
===============

Somafm.com is an online website that streams a variety of electronic and other genres of music. At the site they have an automatic web player that launches for the convenience of instant listening, but a graphical web player is not always convenient or desirable for longer term use. However they also publish the details of their streams, so one is free to use a wide variety of alternative music players.

The streaming links that Somafm.com publishes are in a range of styles. Some of the links are in the PLS or M3U format which utilize redirection, which offers protection from the name changes of server hardware that sometimes occur. However not all music players are capable of utilizing PLS and M3U files. SomaFM also provide direct streaming links, but these tend to change more often.

Somfm-Playlist is a utility written in Ruby to make it easier to gather these (potentially frequently changing)  direct streaming links and automatically write them to a new, local M3U playlist file.


#### REQUIREMENTS
Ruby, Rake, and the gems nokogiri and yaml.

#### CONFIGURATION
Set the directory and filename for the output file by editing the `filename` variable  in the config/config.yml file.

#### USAGE
Run rake after you clone, which produces a new `~/Music/somafm.m3u`.


---------
