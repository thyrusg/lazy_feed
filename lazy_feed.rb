require 'rss'
require 'open-uri'

FEED_URLS = ["https://old.reddit.com/r/ruby.rss",
             "https://old.reddit.com/r/programming.rss"]

Entry = Struct.new('Entry', :title, :author, :content, :updated, keyword_init: true) do
  def to_s
    "Title: #{title}\n
     Author: #{author}\n
     Published At: #{updated}\n
     Content: #{content}\n"
  end
end

PARSED_ENTRIES = []

def process_feed
  FEED_URLS.each do |url|
    begin
      retries = 0
      rss = URI.open(url).read
    rescue OpenURI::HTTPError
      puts "Hit Reddit rate limit. Sleeping then trying again."
      sleep 5
      retry if ( retries += 1 ) < 3
    end
    feed = RSS::Parser.parse(rss)
    feed.items.each do |f|
      parsed = generate_entry(f)
      PARSED_ENTRIES << parsed
    end
  end
end

def generate_entry(entry)
  Entry.new(title: entry.title.content, author: entry.author.name.content,
            content: entry.content.content, updated: entry.updated.content)
end

process_feed()
file = File.open("feed.html", "w+")
PARSED_ENTRIES.each do |i|
  file.write(i)
end
file.close
