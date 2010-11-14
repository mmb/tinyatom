require 'uri'
require 'builder'

module TinyAtom

  class Feed

    def initialize(site_url, title, feed_url, options={})
      @site_url, @title, @feed_url, @feed_options = site_url, title, feed_url,
        options

      @site_domain = URI(@site_url).domain

      @entries = []
    end

    # Add an entry to the feed
    def add_entry(id, title, updated, link, options={})
      entries << {
        :id => id,
        :title => title,
        :updated => updated,
        :link => link
        }.merge(options)
    end

    # Build the feed and return a Builder::XmlMarkup
    def make(options={})
      xm = Builder::XmlMarkup.new(options)
      xm.instruct!(:xml)

      xm.feed(:xmlns => 'http://www.w3.org/2005/Atom',
        :'xmlns:media' => 'http://purl.org/syndication/atommedia') {
        xm.title(title)
        xm.link(:href => feed_url, :rel => 'self')
        xm.updated(updated.xmlschema)
        xm.id(site_url)
        TinyAtom::author(xm, feed_options)
        feed_options.fetch(:hubs, []).each do |hub|
          xm.link(:rel => 'hub', :href => hub)
        end

        entries.each do |e|
          xm.entry {
            xm.title(e[:title])
            xm.link(:href => e[:link])
            xm.id(entry_id(e))
            xm.updated(e[:updated].xmlschema)
            xm.summary(e[:summary]) if e[:summary]
            xm.content(e[:content]) if e[:content]

            (e[:authors] || [e]).each { |h| TinyAtom::author(xm, h) }
            (e[:enclosures] || [e]).each { |h| TinyAtom::enclosure(xm, h) }
            (e[:media_thumbnails] || [e]).each do |h|
              TinyAtom::media_thumbnail(xm, h)
            end
            TinyAtom::via(xm, e)
          }
        end
      }
    end

    # Return the last update time of the feed
    def updated; entries.map { |e| e[:updated] }.max; end

    # Build an entry id
    def entry_id(e)
      # http://diveintomark.org/archives/2004/05/28/howto-atom-id
      "tag:#{site_domain},#{e[:updated].strftime('%Y-%m-%d')}:#{e[:id]}"
    end

    attr_reader :site_url
    attr_reader :title
    attr_reader :feed_url
    attr_reader :feed_options
    attr_reader :site_domain
    attr_reader :entries
  end

  module_function

  # Add author tags if present
  def author(markup, h)
    if h[:author_name]
      markup.author {
        markup.name(h[:author_name])
        markup.email(h[:author_email]) if h[:author_email]
        markup.uri(h[:author_uri]) if h[:author_uri]
      }
    end
  end

  # param name => tag name
  EnclosureOptionalAttrs = {
    :enclosure_length => :length,
    }

  # Add enclosure tags if present
  def enclosure(markup, h)
    if h[:enclosure_type] and h[:enclosure_href] and h[:enclosure_title]
      options = {}
      h.each do |k,v|
        if EnclosureOptionalAttrs.include?(k)
          options[EnclosureOptionalAttrs[k]] = v
        end
      end

      link(markup, 'enclosure', h[:enclosure_type], h[:enclosure_href],
        h[:enclosure_title], options)
    end
  end

  # param name => tag name
  MediaThumbnailOptionalAttrs = {
    :media_thumbnail_height => :height,
    :media_thumbnail_width => :width,
    :media_thumbnail_time => :time,
    }

  # Add media:thumbnail tags if present.
  def media_thumbnail(markup, h)
    if h[:media_thumbnail_url]
      options = {}
      h.each do |k,v|
        if MediaThumbnailOptionalAttrs.include?(k)
          options[MediaThumbnailOptionalAttrs[k]] = v
        end
      end

      markup.media(:thumbnail,
        { :url => h[:media_thumbnail_url] }.merge(options))
    end
  end

  # Add via tags if present
  def via(markup, h)
    if h[:via_type] and h[:via_href] and h[:via_title]
      link(markup, 'via', h[:via_type], h[:via_href], h[:via_title])
    end
  end

  # Create link tag
  def link(markup, rel, type, href, title, options={})
    markup.link({
      :rel => rel,
      :type => type,
      :href => href,
      :title => title
      }.merge(options))
  end

end
