module Jbadmin
  class Ping
    class << self
      def up?(host)
        check = Net::Ping::External.new(host)
        check.ping?
      end
    end
  end
end
