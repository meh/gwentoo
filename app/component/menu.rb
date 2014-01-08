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

class Menu < Lissio::Component
	element '#menu'

	html do
		div.tab do
			div.content do
				span "English"
			end
		end

		div.side
	end

	css do
		position :fixed
		top      0
		left     0

		rule '.tab' do
			width      350.px
			height     183.px
			background url('img/tab.png')

			float :left

			rule '.content' do
				color   :white
				padding 15.px
				padding left: 30.px
			end
		end

		rule '.side' do
			width      96.px
			height     183.px
			background url('img/tab.side.png')

			float :left
		end
	end
end

end
