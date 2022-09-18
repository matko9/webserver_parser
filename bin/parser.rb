#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../lib/webserver_log_parser'

abort 'You need to provide webserver log file as an argument.' if ARGV.empty?
abort 'You need to provide only one argument.' if ARGV.length != 1
abort "Cannot open file #{ARGV[0]}." unless File.exist?(ARGV[0])

WebserverLogParser.new(File.open(ARGV[0])).call
