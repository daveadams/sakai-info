# sakai-info/forum.rb
#   SakaiInfo::Forum library
#
# Created 2012-04-01 daveadams@gmail.com
# Last updated 2012-09-25 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

module SakaiInfo
  class Forum < SakaiObject
    attr_reader :title, :dbrow

    include ModProps
    created_by_key :created_by
    created_at_key :created
    modified_by_key :modified_by
    modified_at_key :modified

    def self.clear_cache
      @@cache = {}
    end
    clear_cache

    def self.find(id)
      if @@cache[id.to_s].nil?
        row = DB.connect[:mfr_open_forum_t].where(:id => id).first
        if row.nil?
          raise ObjectNotFoundException.new(Forum, id)
        end
        @@cache[id.to_s] = Forum.new(row)
      end
      @@cache[id.to_s]
    end

    def initialize(dbrow)
      @dbrow = dbrow

      @id = dbrow[:id].to_i
      @title = dbrow[:title]
      @area_id = dbrow[:surrogatekey]

      @site_id_is_nil = false
    end

    def site_id
      return nil if @site_id_is_nil

      if @site_id.nil?
        result = DB.connect[:mfr_area_t].
          select(:context_id).where(:id => @area_id).first
        if result.nil?
          @site_id_is_nil = true
          return nil
        else
          @site_id = result[:context_id]
        end
      end
      @site_id
    end

    def site
      if self.site_id.nil?
        return nil
      end

      @site ||= Site.find(self.site_id)
    end

    def thread_count
      @thread_count ||= ForumThread.count_by_forum_id(self.id)
    end

    def threads
      @threads ||= ForumThread.find_by_forum_id(self.id)
    end

    def self.query_by_site_id(site_id)
      db = DB.connect
      db[:mfr_open_forum_t].
        where(:surrogatekey =>
              db[:mfr_area_t].select(:id).where(:context_id => site_id)).
        where(:forum_dtype => "DF")
    end

    def self.count_by_site_id(site_id)
      Forum.query_by_site_id(site_id).count
    end

    def self.find_by_site_id(site_id)
      Forum.query_by_site_id(site_id).all.
        collect { |row| @@cache[row[:id].to_i.to_s] = Forum.new(row) }
    end

    def default_serialization
      {
        "id" => self.id,
        "title" => self.title,
        "site" => self.site.serialize(:summary),
        "thread_count" => self.thread_count,
      }
    end

    def threads_serialization
      {
        "threads" => self.threads.collect { |t| t.serialize(:summary) }
      }
    end

    def summary_serialization
      {
        "id" => self.id,
        "title" => self.title
      }
    end

    def self.all_serializations
      [ :default, :threads ]
    end
  end

  class ForumThread < GenericThread
    attr_reader :title, :dbrow

    include ModProps
    created_by_key :created_by
    created_at_key :created
    modified_by_key :modified_by
    modified_at_key :modified

    def self.clear_cache
      @@cache = {}
    end
    clear_cache

    def self.find(id)
      if @@cache[id.to_s].nil?
        row = DB.connect[:mfr_topic_t].where(:id => id, :topic_dtype => "DT").first
        if row.nil?
          raise ObjectNotFoundException.new(ForumThread, id)
        end
        @@cache[id.to_s] = ForumThread.new(row)
      end
      @@cache[id.to_s]
    end

    def initialize(dbrow)
      @dbrow = dbrow

      @id = dbrow[:id].to_i
      @title = dbrow[:title]
    end

    def post_count
      @post_count ||= ForumPost.count_by_thread_id(self.id)
    end

    def posts
      @posts ||= ForumPost.find_by_thread_id(self.id)
    end

    def self.query_by_forum_id(forum_id)
      DB.connect[:mfr_topic_t].where(:of_surrogatekey => forum_id)
    end

    def self.count_by_forum_id(forum_id)
      ForumThread.query_by_forum_id(forum_id).count
    end

    def self.find_by_forum_id(forum_id)
      ForumThread.query_by_forum_id(forum_id).all.collect { |r| ForumThread.new(r) }
    end

    def default_serialization
      {
        "id" => self.id,
        "title" => self.title,
        "post_count" => self.post_count,
      }
    end

    def posts_serialization
      if self.post_count > 0
        {
          "posts" => self.posts.collect { |p| p.serialize(:summary) }
        }
      else
        { }
      end
    end

    def summary_serialization
      {
        "id" => self.id,
        "title" => self.title,
      }
    end

    def self.all_serializations
      [ :default, :posts ]
    end
  end

  class ForumPost < GenericMessage
    attr_reader :id, :title, :dbrow

    include ModProps
    created_by_key :created_by
    created_at_key :created
    modified_by_key :modified_by
    modified_at_key :modified

    def self.clear_cache
      @@cache = {}
    end
    clear_cache

    def self.find(id)
      if @@cache[id.to_s].nil?
        row = DB.connect[:mfr_message_t].where(:id => id, :message_dtype => "ME").first
        if row.nil?
          raise ObjectNotFoundException.new(ForumPost, id)
        end
        @@cache[id.to_s] = ForumPost.new(row)
      end
      @@cache[id.to_s]
    end

    def initialize(dbrow)
      @dbrow = dbrow

      @dbrow[:body] = dbrow[:body].read

      @id = dbrow[:id].to_i
      @title = dbrow[:title]
    end

    def author
      @author ||= User.find(@dbrow[:created_by])
    end

    def thread
      @thread ||= ForumThread.find(@dbrow[:surrogatekey])
    end

    def body
      @dbrow[:body]
    end

    def self.query_by_thread_id(thread_id)
      DB.connect[:mfr_message_t].where(:surrogatekey => thread_id)
    end

    def self.count_by_thread_id(thread_id)
      ForumPost.query_by_thread_id(thread_id).count
    end

    def self.find_by_thread_id(thread_id)
      ForumPost.query_by_thread_id(thread_id).all.collect { |r| ForumPost.new(r) }
    end

    def self.count_by_date(d)
      count_by_date_and_message_type(d, "ME")
    end

    def default_serialization
      {
        "id" => self.id,
        "title" => self.title,
        "author" => self.author.serialize(:summary),
        "thread" => self.thread.serialize(:summary),
        "body" => self.body,
      }
    end

    def summary_serialization
      {
        "id" => self.id,
        "title" => self.title,
      }
    end
  end
end

