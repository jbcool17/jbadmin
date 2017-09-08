module Jbadmin
  class CLI < Thor
    desc "version | -v | --version", "version"
    def version
      puts "Name: #{Jbadmin.name}"
      puts "Version: #{VERSION}"
      puts "Info: Admin Utility to keep track of machines"
    end
    map "-v" => 'version'
    map "--version" => 'version'

    desc "init", "initialize config & storage"
    def init
      Jbadmin::HostController.initialize_computers_storage
    end

    desc "ping [HOST]", "pings server or all"
    def ping(host='all')
      puts ''

      if host == 'all'
        Jbadmin::HostController.get_list.each do |r|
          if Jbadmin::Ping.up?(r[:ip])
            Jbadmin.message "#{r[:host]} is up!".green
          else
            Jbadmin.message "#{r[:host]} is down!".red
          end
        end
      else
        host = Jbadmin::HostController.get_computer host
        if Jbadmin::Ping.up?(host[:ip])
          Jbadmin.message "#{host[:host]} is up!".green
        else
          Jbadmin.message "#{host[:host]} is down!".red
        end
      end

      puts ''
    end

    desc "add [HOST] [IP] [USER] [TYPE]", "add host"
    def add(host, ip, user, type)
      Jbadmin::HostController.add_host(host, ip, user, type)
    end

    desc "update [HOST] [FIELD] [NEW_VALUE]", "update computer"
    def update(host, field, new_value)
      Jbadmin::HostController.update(host, field, new_value)
    end

    desc "delete [HOST]", "delete computer"
    def delete(host)
      Jbadmin::HostController.delete(host)
    end

    desc "list", "list all computers"
    def list
      puts ''
      Jbadmin::HostController.get_list.each do |r|
        Jbadmin.message "Host: #{r[:host]} | Ip: #{r[:ip]} | User: #{r[:user]} Type: #{r[:type]}"
      end
      puts ''
    end

    desc "local_update", "update local machine"
    def local_update

      # Update Script for macOS
      # Description:
      # checks for any updates, using homebrew, AppStore, and Apple Software Updates
      # Requirements:
      # homebrew - https://brew.sh/
      # mas-cli - https://github.com/mas-cli/mas

      puts "===> Checking for updates..."
      puts "===> Running homebrew..."
      system "brew update"

      puts "===> Outdated homebrew packages"
      system "brew outdated"

      puts "===> Running MAS..."
      system "mas outdated"

      puts "===> Running Apple Software Update"
      system "softwareupdate -l"

    end

    desc "ssh [HOST]", "open ssh connection"
    def ssh(host, port=22)
      host = Jbadmin::HostController.get_computer host

      puts ''
      puts "Connecting to #{host[:host]}..."
      system "ssh #{host[:user]}@#{host[:ip]} -p #{port}"
    end
  end
end
