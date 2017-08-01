require "spec_helper"

RSpec.describe Jbadmin::CLI, :type => :aruba do
  it "calls version info with version" do
    run_simple 'bundle exec Jbadmin version'
    version = Jbadmin::VERSION
    expect(last_command_started.stdout.chomp.match(/Version: #{version}/)[0]).to eq "Version: #{version}"
  end
  it "calls version info with -v" do
    run_simple 'bundle exec Jbadmin version'
    version = Jbadmin::VERSION
    expect(last_command_started.stdout.chomp.match(/Version: #{version}/)[0]).to eq "Version: #{version}"
  end
  it "calls version info with --version" do
    run_simple 'bundle exec Jbadmin version'
    version = Jbadmin::VERSION
    expect(last_command_started.stdout.chomp.match(/Version: #{version}/)[0]).to eq "Version: #{version}"
  end

  it "add / list / com / upload / download / delete computer" do
    expect { Jbadmin::CLI.start(%w(add master1 192.168.56.110 vagrant vagrant)) }.to output("Computer master1 has been created.\n").to_stdout
    expect { Jbadmin::CLI.start(['list']) }.to output("master1: 1 | 192.168.56.110 | vagrant\n").to_stdout
    expect { Jbadmin::CLI.start(%w(com master1 -c uname -q)) }.to output("Linux\n").to_stdout
    expect { Jbadmin::CLI.start(%w(upload master1 ./spec/support/test.txt test.txt)) }.to output("").to_stdout
    expect { Jbadmin::CLI.start(%w(download master1 test.txt ./spec/support/test_download.txt)) }.to output("").to_stdout
    expect { Jbadmin::CLI.start(%w(delete master1)) }.to output("Computer master1 has been deleted.\n").to_stdout
  end

end
