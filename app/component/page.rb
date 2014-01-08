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
			div.spinner.yellow
		end
	end

	element '#page'

	css do
		width 45.%
		margin 0, :auto
		padding bottom: 195.px

		font size: 16.px

		rule 'h1' do
			font size:   3.em,
				   weight: :normal,
				   family: 'Title'

			text align: :center

			margin 0
			padding 25.px
		end

		rule '.spinner' do
			width  100.px
			height 100.px

			position :absolute
			top      50.%
			left     50.%

			margin top:  -120.px,
				     left: -50.px

			background size: [100.%, 100.%]
			animation :spin, 1.s, :linear, 0.s, :infinite

			rule '&.yellow' do
				background image: url('img/spinner.yellow.png')
			end
		end
	end

	css! <<-CSS
		@keyframes spin {
			from {
				transform: rotate(0deg);
			}
			to {
				transform: rotate(360deg);
			}
		}
		
		@-webkit-keyframes spin {
			from {
				-webkit-transform: rotate(0deg);
			}
			to {
				-webkit-transform: rotate(360deg);
			}
		}
	CSS
end

end
