Aims to be the smallest, easiest to use ruby Atom feed generator.

Currently supports only a subset of the most frequently used Atom fields. This
example shows everything it can do.

```ruby
require 'tinyatom'

feed = TinyAtom::Feed.new(
  'http://mysite.com/blog/',
  'My Blog',
  'http://mysite.com/blog/atom.xml',

  # optional

  :author_name => 'me',
  :author_email => 'me@mysite.com',
  :author_uri => 'http://mysite.com/',

  :hubs => ['http://pubsubhubbub.appspot.com/']
  )

feed.add_entry(
  1,
  'post 1',
  Time.now,
  'http://mysite.com/blog/1',

  # optional

  :summary => 'the summary',
  :content => 'the content',

  :author_name => 'me',
  :author_email => 'me@mysite.com',
  :author_uri => 'http://mysite.com/',

  :enclosure_type => 'image/png',
  :enclosure_href => 'http://mysite.com/image.png',
  :enclosure_title => 'photo',
  :enclosure_length => 6227, # optional within enclosure

  :via_type => 'text/html',
  :via_href => 'http://anotherblog.com/posts/999',
  :via_title => 'Look at this photo',

  :media_thumbnail_url => 'http://mysite.com/thumbnails/1.jpg',
  :media_thumbnail_width => 100,
  :media_thumbnail_height => 100,
  :media_thumbnail_time => '00:00:00.000'
  )

puts feed.make(:indent => 2)
# open('atom.xml', 'w') { |f| feed.make(:target => f) }
```

Output:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<feed xmlns:media="http://search.yahoo.com/mrss/" xmlns="http://www.w3.org/2005/Atom">
  <title>My Blog</title>
  <link rel="self" href="http://mysite.com/blog/atom.xml"/>
  <updated>2010-11-14T11:36:03-05:00</updated>
  <id>http://mysite.com/blog/</id>
  <author>
    <name>me</name>
    <email>me@mysite.com</email>
    <uri>http://mysite.com/</uri>
  </author>
  <link rel="hub" href="http://pubsubhubbub.appspot.com/"/>
  <entry>
    <title>post 1</title>
    <link href="http://mysite.com/blog/1"/>
    <id>tag:mysite.com,2010-11-14:1</id>
    <updated>2010-11-14T11:36:03-05:00</updated>
    <summary>the summary</summary>
    <content>the content</content>
    <author>
      <name>me</name>
      <email>me@mysite.com</email>
      <uri>http://mysite.com/</uri>
    </author>
    <link type="image/png" rel="enclosure" length="6227" title="photo" href="http://mysite.com/image.png"/>
    <media:thumbnail url="http://mysite.com/thumbnails/1.jpg" height="100" time="00:00:00.000" width="100"/>
    <link type="text/html" rel="via" title="Look at this photo" href="http://anotherblog.com/posts/999"/>
  </entry>
</feed>
```

Questions and comments: <matthewm@boedicker.org>
