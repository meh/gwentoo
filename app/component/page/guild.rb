module Component; class Page < Lissio::Component::Container

class Guild < Lissio::Component
	def self.prepare(id)
		Database.colors.then {
			Gwentoo::Guild.fetch(id)
		}.trace {|colors, guild|
			canvas = Browser::Canvas.new(256, 256)
			canvas.clear(0, 0, 256, 256)

			Promise.when.tap {|p|
				p.wait canvas
				p.wait guild

				p.wait Promise.when.tap {|p|
					p.wait colors[guild.emblem!.background!.id].cloth!
					p.wait colors[guild.emblem!.foreground!.primary].cloth!
					p.wait colors[guild.emblem!.foreground!.secondary].cloth!
				}

				p.wait Promise.when.tap {|p|
					p.wait canvas.load("img/emblem/bg/#{guild.emblem!.background!.id}.png")
					p.wait canvas.load("img/emblem/fg/#{guild.emblem!.foreground!.id}a.png")
					p.wait canvas.load("img/emblem/fg/#{guild.emblem!.foreground!.id}b.png")
				}
			}
		}.then {|canvas, guild, colors, images|
			background = Browser::Canvas.new(images[0])
			primary    = Browser::Canvas.new(images[1])
			secondary  = Browser::Canvas.new(images[2])

			colorize(background, colors[0])
			colorize(primary, colors[1])
			colorize(secondary, colors[2])

			foreground = Browser::Canvas.new(primary)
			foreground.draw_image(secondary)

			if guild.emblem!.flags.include? 'FlipBackgroundHorizontal'
				flip(background, :horizontal)
			end

			if guild.emblem!.flags.include? 'FlipBackgroundVertical'
				flip(background, :vertical)
			end

			if guild.emblem!.flags.include? 'FlipForegroundHorizontal'
				flip(foreground, :horizontal)
			end

			if guild.emblem!.flags.include? 'FlipForegroundVertical'
				flip(foreground, :vertical)
			end

			canvas.draw_image(background)
			canvas.draw_image(foreground)

			new(guild, canvas)
		}
	end

	def self.colorize(canvas, color)
		r, g, b = color.rgb
		d       = canvas.data

		0.upto(d.length - 1).each_slice(4) {|ri, gi, bi, _|
			luminance = d[ri] / 255

			d[ri] = r * luminance
			d[gi] = g * luminance
			d[bi] = b * luminance
		}

		d.save
	end

	def self.flip(canvas, how)
		flipped = Browser::Canvas.new(canvas.width, canvas.height)

		if how == :horizontal
			flipped.translate(canvas.width, 0)
			flipped.scale(-1, 1)
		else
			flipped.translate(0, canvas.height)
			flipped.scale(1, -1)
		end

		flipped.draw_image canvas
		canvas.clear
		canvas.draw_image flipped
	end

	attr_reader :guild, :emblem

	def initialize(guild, emblem)
		@guild  = guild
		@emblem = emblem
	end

	tag id: 'guild'

	html do |_|
		_.h1 do
			_.div.name @guild.name

			_.div do
				_ << @emblem
				_.span.tag @guild.tag
			end
		end

		_.div T.p("And this is all you'll know since the API for Guilds is rather pointless.")
	end

	css do
		rule '#guild' do
			rule 'canvas' do
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
