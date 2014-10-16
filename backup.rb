#!/usr/bin/ruby -w

require 'optparse'
require_relative 'backup'

# Config

options = {}

options[:configdir] = "./config"

# Default value for configuration-file
# If not present default values will be chosen
# configfile will overwrite default values of this script
options[:configfile] = "backup.cfg"

# Logdirectory
# where logfile is bein written
options[:logdir] = "./log"

# If sourcetype is remote: Where to mount the remote directory
options[:mountdir] = "/backupmount"

# Path where the rdiff-backup is gonna be written
options[:backup_dst_basedir] = "/backup"

# Type of media
# if disk is chosen a normal rdiff-backup is bein written
# if tape is chosen there will be backuped the whole options[:backup_dst_basedir]
# for tape records tar is gonna be used
options[:type] = "disk"

# Debugmode on or off
# true | false
options[:debug] = true

# Commandline args parsing...

begin
    OptionParser.new do |opts|
        opts.banner = "Usage: backup.rb [options]"

        opts.on("-c", "--config [configfile]", "Run only backup defined in [configfile]") do |c|
            options[:config] = c
        end

        opts.on("-t", "--type [disk|tape]", "Type of backup:",
                "[disk]: is default, runs rdiff-backup, backup being written on disk",
                "[tape]: writes complete backup directory on tape using tar") do |t|
                    options[:type] = t
                end
    end.parse!
rescue OptionParser::InvalidOption
    p "unknown argument, try again"
end

if options[:debug]
    p options
    p ARGV
end

backup = Backup.new(options)
backup.run
