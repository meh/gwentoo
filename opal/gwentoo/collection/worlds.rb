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

module Gwentoo

class Worlds < Lissio::Collection
	adapter REST, '/world_names.json' do
		parse do |items|
			items.map {|item|
				id       = item[:id]
				name     = item[:name]
				language = nil

				name.match /^(.*?)\s\[(.*?)\]$/ do |m|
					name     = m[1]
					language = m[2].downcase.to_sym
				end

				World.new(id: id, name: name, language: language)
			}
		end
	end

	model World
end

def self.worlds
	Gwentoo::Worlds.fetch
end

end
