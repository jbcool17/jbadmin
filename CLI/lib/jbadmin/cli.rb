module Jbadmin
  class CLI < Thor
    desc "version | -v | --version", "version"
    def version
      puts "Name: #{Jbadmin.name}"
      puts "Version: #{VERSION}"
      puts "Info: CLI Utility for running commands on remote machines / downloading & uploading files via SSH/SCP"
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
  end
end
