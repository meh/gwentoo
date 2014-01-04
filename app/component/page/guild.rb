class Browser::Canvas
	def hue(color)
		# TODO: it all
	end

	def contrast(value)
		d = data
		f = (259 * (value + 255)) / (255 * (259 - value))

		0.upto(d.length - 1).each_slice(4) {|r, g, b, _|
			d[r] = (f * ((d[r] - 128) + 128))
			d[g] = (f * ((d[g] - 128) + 128))
			d[b] = (f * ((d[b] - 128) + 128))
		}

		d.save_to self
	end

	def colorize(r, g, b)
		d = data

		0.upto(d.length - 1).each_slice(4) {|ri, gi, bi, _|
			luminance = d[ri] / 255

			d[ri] = r * luminance;
			d[gi] = g * luminance;
			d[bi] = b * luminance;
		}

		d.save_to self
	end

	def flip(how)
		c = Browser::Canvas.new(width, height)

		if how == :horizontal
			c.translate(width, 0)
			c.scale(-1, 1)
		else
			c.translate(0, height)
			c.scale(1, -1)
		end

		c.draw_image self
		clear
		draw_image c
	end
end

module Component; class Page < Lissio::Component::Container

class Guild < Lissio::Component
	def self.prepare(id)
		Database.colors.then {
			Gwentoo::Guild.fetch(id)
		}.then {|guild|
			new(guild)
		}
	end

	def initialize(guild)
		@guild = guild
	end

	on :render do
		e = @guild.emblem!
		c = Browser::Canvas.new(element.at_css('.emblem'))
		c.clear(0, 0, 256, 256)

		Database.colors.then {|colors|
			Promise.when.tap {|p|
				p.wait Promise.when.tap {|p|
					p.wait colors[e.background!.id].cloth!
					p.wait colors[e.foreground!.primary].cloth!
					p.wait colors[e.foreground!.secondary].cloth!
				}

				p.wait Promise.when.tap {|p|
					p.wait c.load("img/emblem/bg/#{e.background!.id}.png")
					p.wait c.load("img/emblem/fg/#{e.foreground!.id}a.png")
					p.wait c.load("img/emblem/fg/#{e.foreground!.id}b.png")
				}
			}
		}.then {|colors, images|
			colors = {
				background: colors[0],
				primary:    colors[1],
				secondary:  colors[2]
			}

			images = {
				background: Browser::Canvas.new(images[0]),
				primary:    Browser::Canvas.new(images[1]),
				secondary:  Browser::Canvas.new(images[2])
			}

			images[:background].hue(colors[:background])
			images[:primary].hue(colors[:primary])
			images[:secondary].hue(colors[:secondary])

			images[:background].contrast(colors[:background].contrast)
			images[:background].colorize(*colors[:background].rgb)

			images[:primary].contrast(colors[:primary].contrast)
			images[:primary].colorize(*colors[:primary].rgb)

			images[:secondary].contrast(colors[:secondary].contrast)
			images[:secondary].colorize(*colors[:secondary].rgb)

			images[:foreground] = Browser::Canvas.new(images[:primary])
			images[:foreground].draw_image(images[:secondary])

			if e.flags.include? 'FlipBackgroundHorizontal'
				images[:background].flip(:horizontal)
			end

			if e.flags.include? 'FlipBackgroundVertical'
				images[:background].flip(:vertical)
			end

			if e.flags.include? 'FlipForegroundHorizontal'
				images[:foreground].flip(:horizontal)
			end

			if e.flags.include? 'FlipForegroundVertical'
				images[:foreground].flip(:vertical)
			end

			c.draw_image(images[:background])
			c.draw_image(images[:foreground])
		}
	end

	tag id: 'guild'

	html do |_|
		_.h1 do
			_.div.name @guild.name

			_.div do
				_.canvas.width(256).height(256).emblem
				_.span.tag @guild.tag
			end
		end

		_.div "And this is all you'll know since the API for Guilds is rather pointless."
	end

	css do
		rule '#guild' do
			rule '.emblem' do
				width 100.px
				height 100.px

				vertical align: :middle
			end

			rule '.tag' do
				font size: 42.px
				margin left: 15.px
			end

			rule 'div' do
				text align: :center
			end
		end
	end
end

end; end
