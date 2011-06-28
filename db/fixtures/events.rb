require 'open-uri'
require 'date'

#URL = "http://jon.luini.com/thelist/thelist.txt"
URL = "http://localhost:3000/thelist.txt"

LINES = "
jun 25 sat Black Balloon, Electric Chair Repair Co., Weapons Of The Future
       at Starry Plough, 3101 Shattuck, Berkeley 21+ $10 8:30pm **
jun 25 sat An Idol's Plague, Not Again, Betty White, Butt Problems
       at Eli's Mile High Club, Oakland 21+ 7pm ** @
jun 25 sat The Angries (OR), The Stressors, The Paper Bags
       at Tire Beach, Bay End of 24th Street, S.F. a/a free 3pm **
jun 25 sat The Wooden Birds, The Definite Articles, White Cloud
       at the Bottom of the Hill, S.F. a/a $10/$12 8:30pm/10pm **

nov 12 sat Let Zeppelin 2 at Slim's, S.F. 6+ **
nov 19 sat Damage Inc. (tribute), Roses And Guns (tribute), Points North
       at Club Fox, 2223 Broadway, Redwood City 21+ **
nov 21 mon Katy Perry, Jessie J, dj Skeet Skeet at the Arena, Oakland a/a # **
dec 16 fri D.R.I. at Slim's, S.F. 6+ *** @

	*    recommendable Shows		a/a  all ages
	$    will probably sell out		@    pit warning
	^    under 21 must pay more		#    no ins/outs

			Live Radio Shows
			----------------

			Radio/TV Shows
			---------------
Berkeley Liberation Radio 104.1FM	www.berkeleyliberationradio.org

"

  def read_lines
    lines = open(URL).read

#    lines = LINES
  end

  def parse_lines(lines)
    lines.gsub!("\n      ", "")

    lines.split("\n").each do |r|
      return if r.index('recommendable Shows')
      next if not r.index('S.F.')

      begin
        create_event(r)
      rescue ArgumentError
      end
    end
  end

  def create_event(r)
    puts "create_event"

    venue_index = r.index(' at ')
    sf_index = r.index('S.F.')

    values = {}
    values[:starts_at] = DateTime.parse(r[0..5] + " 20:00", "%b %d %H:%M")
    values[:ends_at] = DateTime.parse(r[0..5] + " 22:00", "%b %d %H:%M")
    values[:band] = r[11..venue_index]
    values[:venue] = r[(venue_index+4)..(sf_index-3)]


    # a bit of a hack, but the regex anchor isn't working for me
#    puts values[:venue].sub("/^thee ).*/", "")
#    puts values[:venue].sub("/^the .*/", "")
    if (values[:venue].start_with?("the "))
      values[:venue] = values[:venue][4..-1]
    end
    if (values[:venue].start_with?("thee "))
      values[:venue] = values[:venue][5..-1]
    end

    values[:description] = r

   Event.create(values)

    puts values[:venue]


    #  puts r[11..venue_index]
    #
    #  puts r[(venue_index+4)..(sf_index-3)]

    #  band = r[4..5]
    #  puts month
    #  puts day
    puts "finish create_event"

  end

Event.delete_all

parse_lines(read_lines)
