# util.rb
#   Utility methods
#
# Created 2012-05-20 daveadams@gmail.com
# Last updated 2012-05-20 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

module SakaiInfo
  class Util
    # misc support functions
    FILESIZE_LABELS = ["bytes", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"]
    def self.format_filesize(i_size)
      size = i_size.to_f
      negative = false

      if size < 0
        negative = true
        size = -size
      end

      label = 0
      (FILESIZE_LABELS.size - 1).times do
        if size >= 1024.0
          size = size / 1024.0
          label += 1
        end
      end

      if size >= 100.0 or label == 0
        "#{negative ? "-" : ""}#{size.to_i.to_s} #{FILESIZE_LABELS[label]}"
      else
        "#{negative ? "-" : ""}#{sprintf("%.1f", size)} #{FILESIZE_LABELS[label]}"
      end
    end

    def self.format_entity_date(raw)
      if raw =~ /^(....)(..)(..)(..)(..)(..).*$/
        # I believe these are usually in UTC
        Time.utc($1.to_i, $2.to_i, $3.to_i, $4.to_i, $5.to_i, $6.to_i).getlocal
      else
        raw
      end
    end
  end
end

