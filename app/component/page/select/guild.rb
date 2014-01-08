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

module Component; class Page < Lissio::Component::Container; module Select

class Guild < Lissio::Component
	on :keydown, 'input' do |e|
		next unless e.key == :Enter

		unless e.target.value.empty?
			Application.navigate("/guild/#{e.target.value.encode_uri_component}")
		end
	end

	tag id: 'select-guild'

	html do
		h1 T.p('Select a Guild')

		input.type(:text).place_holder(T.p('Name or ID'))
	end

	css do
		text align: :center

		rule 'input' do
			background :white
			border :none
			border bottom: [1.px, :dashed, :black]

			font size: 23.px
			width 80.%
			color :black
		end
	end
end

end; end; end
