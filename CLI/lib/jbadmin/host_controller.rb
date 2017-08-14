module Jbadmin
  class HostController
      class << self
        def initialize_computers_storage
          data_dir = "#{Jbadmin.main_dir}/.jbadmin"
          if !Dir.exists? data_dir
            Dir.mkdir data_dir
            puts "Directory created..."
          end

          if !File.exists? Jbadmin.hosts
            CSV.open(Jbadmin.hosts, "wb") do |csv|
              csv << ["host", "ip", "user", "type"]
            end
            File.chmod(0700,Jbadmin.hosts)
            puts "File created..."
          end
            
        end

        def get_computer(host)
          table = CSV.table(Jbadmin.hosts)

          host = table.select { |row| "#{row[:host]}" == "#{host}" }

          {host: host[0][0], ip: host[0][1], user: host[0][2], type: host[0][3] }
        end

        def add_host(host, ip, user, type)

          if check_uniq("#{host}")
            CSV.open(Jbadmin.hosts, "a+") do |csv|
              csv << ["#{host}", ip, user, type]
            end
            puts "Computer has been added."
          else
            puts "Host is not unique. Please try again."
          end

        end

        def delete(host)
          table = CSV.table(Jbadmin.hosts)

          table.delete_if do |row|
            "#{row[:host]}" == "#{host}"
          end

          File.open(Jbadmin.hosts, 'w') do |f|
            f.write(table.to_csv)
          end

          puts "#{host} has been deleted."
        end

        def update(host, field, new_value)
          table = CSV.table(Jbadmin.hosts)

          table.each do |row|
            if "#{row[:host]}" == "#{host}"
              row[field.to_sym] = new_value
            end
          end

          File.open(Jbadmin.hosts, 'w') do |f|
            f.write(table.to_csv)
            puts "#{host} has been updated."
          end


        end

        def get_list
          get_csv_hash
        end

        private

        def check_uniq(host)
          get_csv_hash.each do |r|
            return false if "#{r[:host]}" == host
          end

          true
        end

        def get_csv_hash
          data = CSV.read(Jbadmin.hosts,  { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all})

          data.map { |d| d.to_hash }
        end
      end
  end
end
