require 'colorize'
require 'ruby-progressbar'
require 'thor'
require 'net/ssh'
require 'fileutils'
require 'csv'
require 'net/ping'
require 'colorize'

require "jbadmin/version"
require 'jbadmin/cli'
require 'jbadmin/host_controller'
require 'jbadmin/ping'


module Jbadmin
  def self.message(m)
    puts "===> #{m}"
  end

  def self.main_dir
    Dir.home
  end

  def self.hosts
    "#{Jbadmin.main_dir}/.jbadmin/hosts.csv"
  end
end
