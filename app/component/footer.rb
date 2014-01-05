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
	end

	css do
		rule '#footer' do
			position :fixed
			bottom   0
			left     0

			width    100.%
			height 150.px

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
				right 15.%
				top 90.px
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
		end
	end

end

end
