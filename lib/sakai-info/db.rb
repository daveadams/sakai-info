# sakai-info/db.rb
#   SakaiInfo::DB library
#
# Created 2012-02-16 daveadams@gmail.com
# Last updated 2012-02-16 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

#require 'oci8'

module SakaiInfo
  class DB
    @@db = {}
  #   def self.connect(instance = Instance.default)
  #     if @@db[instance]
  #       begin
  #         ok = false
  #         @@db[instance].exec("select 1 from dual") do |row|
  #           if row[0] == 1
  #             ok = true
  #           end
  #         end
  #       rescue
  #         ok = false
  #       end
  #       if ok
  #         return @@db[instance]
  #       else
  #         @@db[instance] = nil
  #       end
  #     end
  #     begin
  #       (dbspec = Config.dbspec(instance)) or raise "No such instance '#{instance}'"
  #       @@db[instance] = OCI8.new(*dbspec)
  #     rescue => e
  #       STDERR.puts "Could not connect: #{e}"
  #       @@db[instance] = nil
  #     end
  #   end

  #   at_exit {
  #     @@db.each do |key, db|
  #       begin
  #         if db.methods.include? :ping
  #           db.logoff if db.ping
  #         else
  #           db.logoff
  #         end
  #       rescue
  #         # it's ok
  #       end
  #     end
  #   }
  end
end

