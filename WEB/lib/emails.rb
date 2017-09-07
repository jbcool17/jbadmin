module JbAdmin
  class Emails
    def self.process(f)
      upload = './public/uploads/'
      download = './public/downloads'
      # Pull emails from PDF
      # script
      file_name = File.basename(f, File.extname(f))
      full_file_name = f

      # Parse to Arrays from text file
      new_emails = File.readlines(full_file_name)
      new_emails = new_emails.map { |line| line.gsub("\n", '')}.sort

      sent = File.readlines('sent-db.txt')
      sent = sent.map { |line| line.gsub("\n", '')}.sort


      # Filter Dups and Add to sent db list
      output = []
      new_emails.each do |line|
        if ( !sent.include?(line) )
          puts "processing #{line}"
          output << line
          sent << line
        end
      end

      # Output Files

      puts "Outputing files..."
      File.open("#{file_name}-output.txt", "w+") do |f|
        output.each { |element| f.puts(element) }
      end

      FileUtils.cp 'sent-db.txt', 'sent-db.backup.txt'

      File.open("sent-db.txt", "w+") do |f|
        sent.each { |element| f.puts(element) }
      end

      CSV.open("#{file_name}-output.csv", "w") do |csv|
        csv << ["Email", "Date Emailed"]
        output.each { |email| csv << [email, Time.now.strftime("%m/%d/%Y")]}
      end
    end
  end
end
