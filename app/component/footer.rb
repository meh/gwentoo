# Copyleft meh. [http://meh.schizofreni.co | meh@schizofreni.co]
#
# This file is part of Gwentoo.
#
# Gwentoo is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published
# by the Free Software Foundation, either version 3 of the License,
# or (at your option) any later version.
#
# Gwentoo is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with Gwentoo. If not, see <http://www.gnu.org/licenses/>.

module Component

class Footer < Lissio::Component
	on :click, 'a', :hide
	on :click, '.arrow > div', :toggle

	def show
		element.style.height = 205.px
		element.at_css('.arrow div').remove_class(:up).add_class(:down)
	end

	def hide
		element.style.height = 150.px
		element.at_css('.arrow div').remove_class(:down).add_class(:up)
	end

	def toggle
		if element.style.height.to_u == 150.px
			show
		else
			hide
		end
	end

	element '#footer'

	on :render do
		Gwentoo::Build.fetch.then {|build|
			element.at_css('.build') << build.id.to_s
		}
	end

	html do
		div.build

		div.gwentoo do
			span.name "GWENTOO"
			span.version Gwentoo::VERSION.to_s
		end

		div.arrow do
			div.down
		end

		div.menu do
			a.href('/').text('Home')
			a.href('/select/guild').text('Guild')
		end
	end

	css do
		rule '#footer' do
			position :fixed
			bottom   0
			left     0

			width  100.%
			height 205.px

			background url('img/footer.jpg'), 50.%, 0.%, 'no-repeat'

			cursor :default

			rule '.build' do
				position :absolute
				top      107.px
				left     30.%

				color '#bbb'
				font size: 18.px
			end

			rule '.gwentoo' do
				position :absolute
				left     50.%
				top      90.px

				margin left: 210.px

				color '#bbb'

				rule '.name' do
					font family: 'Title',
					     size:   42.px

					letter spacing: -2.px
				end

				rule '.version' do
					font size: 18.px
					margin left: 7.px
				end
			end

			rule '.arrow' do
				width  100.%
				margin top: 75.px

				text align: :center

				rule '& > div' do
					width  13.px
					height 8.px

					display 'inline-block'

					rule '&.up' do
						background url('img/arrow.up.png')
					end

					rule '&.down' do
						background url('img/arrow.down.png')
					end
				end
			end

			rule '.menu' do
				position :absolute
				top      165.px
				left     0

				width 100.%
				text align: :center

				font size: 23.px

				rule 'a' do
					margin 0, 10.px
				end
			end
		end
	end
end

end
