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
			a.href('/').text(T.w('Home'))
			a.href('/map').text(T.w('Map'))
			a.href('/items').text(T.w('Items'))
			a.href('/recipes').text(T.w('Recipes'))
			a.href('/dyes').text(T.w('Dyes'))
			a.href('/guild').text(T.w('Guild'))
			a.href('/wvw').text(T.w('WvW'))
		end
	end

	css do
		rule '#footer' do
			position :fixed
			bottom   0
			left     0

			width  100.%
			height 195.px

			transition :height, 0.8.s

			background url('img/footer.jpg'), 50.%, -15.px, 'no-repeat'

			cursor :default

			rule '.build' do
				position :absolute
				top      107.px
				left     50.%

				margin left: -255.px

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

			rule '.menu' do
				position :absolute
				top      155.px
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
