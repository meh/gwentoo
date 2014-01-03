module Component; class Page < Lissio::Component::Container

class Guild < Lissio::Component
	def self.prepare(id)
		Gwentoo::Guild.fetch(id).then {|guild|
			new(guild)
		}
	end

	def initialize(guild)
		@guild = guild
	end

	tag id: 'guild'

	html do |_|
		_.h1 "#{@guild.name} [#{@guild.tag}]"

		_.div "And this is all you'll know since the API for Guilds is rather pointless."
	end

	css do
		rule '#guild' do
			rule 'div' do
				text align: :center
			end
		end
	end
end

end; end
