# Lazy Feeds
A small ruby script that pulls down some RSS feeds, extracts data and presents it in a new format.

This was originally used to make scanning reddit headlines easier.

I don't use this anymore since the rate limits for reddit's RSS feeds are very long in between requests.

## How To Use

1. Update the list of RSS feeds on line 3.

```ruby
FEED_URLS = ["https://old.reddit.com/r/ruby.rss",
             "https://old.reddit.com/r/programming.rss"]
```
2. Run `ruby lazy_feed.rb`.
3. Open `feed.html`