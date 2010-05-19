require 'uri'
require 'builder'

class URI::Generic

  # Add domain method to URI
  def domain
    if (host and (d = host[/[a-z\d-]+\.[a-z]{2,}(\.[a-z]{2})?$/]))
      d.downcase
    end
  end

end

module TinyAtom

  class Feed

    def initialize(site_url, title, feed_url, options={})
      @site_url, @title, @feed_url = site_url, title, feed_url

      @site_domain = URI(@site_url).domain

      @hubs = options[:hubs] || []

      @entries = []
    end

    # Add an entry to the feed.
    def add_entry(id, title, updated, link, options={})
      entries << {
        :id => id,
        :title => title,
        :updated => updated,
        :link => link
        }.merge(options)
    end

    def make(options={})
      xm = Builder::XmlMarkup.new(options)
      xm.instruct!(:xml)

      xm.feed(:xmlns => 'http://www.w3.org/2005/Atom') {
        xm.title(title)
        xm.link(:href => feed_url, :rel => 'self')
        xm.updated(updated.xmlschema)
        xm.id(site_url)
        hubs.each { |hub| xm.link(:href => hub, :rel => 'hub') }

        entries.each do |e|
          xm.entry {
            xm.title(e[:title])
            xm.link(:href => e[:link])
            xm.id(entry_id(e))
            xm.updated(e[:updated])
            xm.summary(e[:summary]) if e[:summary]

            TinyAtom::author(xm, e)
            TinyAtom::enclosure(xm, e)
            TinyAtom::via(xm, e)
          }
        end
      }
    end

    # Return the last update time of the feed,
    def updated; entries.map { |e| e[:updated] }.max; end

    # Build an entry id.
    def entry_id(e)
      # http://diveintomark.org/archives/2004/05/28/howto-atom-id
      "tag:#{site_domain},#{e[:updated].strftime('%Y-%m-%d')}:#{e[:id]}"
    end

    attr_reader :site_url
    attr_reader :title
    attr_reader :feed_url
    attr_reader :site_domain
    attr_reader :hubs
    attr_reader :entries
  end

  module_function

  # Add author tags if present.
  def author(markup, h)
    if h[:author_name] or h[:author_email] or h[:author_uri]
      markup.author {
        markup.name(h[:author_name]) if h[:author_name]
        markup.name(h[:author_email]) if h[:author_email]
        markup.name(h[:author_uri]) if h[:author_uri]
      }
    end
  end

  # Add enclosure tags if present.
  def enclosure(markup, h)
    if h[:enclosure_type] and h[:link] and h[:enclosure_title]
      xm.link(:rel => 'enclosure', :type => h[:enclosure_type],
        :href => h[:link], :title => h[:enclosure_title])
    end
  end

  # Add via tags if present.
  def via(markup, h)
    if h[:via_type] and h[:via_url] and h[:via_title]
      markup.link(:rel => 'via', :type => h[:via_type],
        :href => h[:via_url], :title => h[:via_title])
    end
  end

end
