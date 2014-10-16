#!/usr/bin/ruby -w

require 'optparse'
require_relative 'backup'

# Config

options = {}
options[:mailrcpts] = []
options[:configdir] = "."
options[:
