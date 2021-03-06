module Component; class Page < Lissio::Component::Container; module Select

class World < Lissio::Component
	def self.prepare
		Database.worlds.then {|worlds|
			new(worlds)
		}
	end

	def initialize(worlds)
		@worlds = worlds
	end

	tag id: 'select-world'

	html do |_|
		worlds = @worlds.group_by { |w| w.id.to_s[0] }
		na     = worlds["1"] # North American servers
		eu     = worlds["2"] # European servers

		_.h1 T.p('Select a World')

		_.div.group.na do
			_.div.header T.w('North America')

			na.each {|world|
				_.div.world do
					_.a.href(:back).text(world.name).on :click do
						Application.world = world
					end
				end
			}
		end

		_.div.group.eu do
			_.div.header T.w('Europe')

			eu.each {|world|
				_.div.world do
					_.a.href(:back).text(world.name).on :click do
						Application.world = world
					end
				end
			}
		end

		_.div.style(clear: :both)
	end

	css do
		rule 'a' do
			text decoration: :none
		end

		rule '.group' do
			width 47.%

			rule '&.na' do
				float :left
			end

			rule '&.eu' do
				float :right
			end

			rule '.header' do
				font size: 24.px
				text align: :center

				margin bottom: 10.px
			end

			rule '.world' do
				width 50.%
				float :left
			end
		end
	end
end

end; end; end
