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
			element.at_css('.build .gwentoo') << "Gwentoo v#{Gwentoo::VERSION}"
			element.at_css('.build .guildwars') << "Guild Wars b#{build.id}"
		}
	end

	html do
		div.left

		div.right do
			div.build do
				div.gwentoo
				div.guildwars
			end
		end
	end

	css do
		rule '#footer' do
			position :fixed
			bottom   0
			right    0

			color :white

			rule '.right' do
				width      350.px
				height     183.px
				background url('img/tab.black.png')

				float :left

				rule '.content' do
					padding top:  80.px,
					        left: 90.px
				end

				rule '.build' do
					position :absolute
					right    30.px
					bottom   10.px

					text align: :right
				end
			end

			rule '.left' do
				width      96.px
				height     183.px
				background url('img/tab.side.black.png')

				float :left
			end
		end
	end

end

end
