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

class Page < Lissio::Component::Container
	def loading!
		render do
			h1 'Loading...'
		end
	end

	element '#page'

	css do
		rule '#page' do
			width 45.%
			margin 25.px, :auto

			font size: 16.px

			rule 'h1' do
				font size:   3.em,
				     weight: :normal

				text align: :center

				margin bottom: 25.px
			end
		end
	end
end

end
