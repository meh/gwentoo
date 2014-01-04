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

class Map < Lissio::Model
	class Level < Lissio::Model
		property :min, as: Integer
		property :max, as: Integer

		def self.parse(data)
			new min: data[:min_level],
			    max: data[:max_level]
		end
	end

	class Floor < Lissio::Model
		property :default, as: Integer
		property :list, as: Array

		def self.parse(data)
			new default: data[:default_floor],
			    list:    data[:floors]
		end
	end
	
	class Region < Lissio::Model
		property :id, as: Integer
		property :name, as: String

		def self.parse(data)
			new id:   data[:region_id],
			    name: data[:region_name]
		end
	end

	class Continent < Lissio::Model
		property :id, as: Integer
		property :name, as: String
		property :area, as: Array

		def self.parse(data)
			new id:   data[:continent_id],
			    name: data[:continent_name],
			    area: data[:continent_rect]
		end
	end

	class Details < Lissio::Model
		property :level, as: Level
		property :floor, as: Floor
		property :region, as: Region
		property :continent, as: Continent
		property :area, as: Array

		def self.parse(data)
			new level:     Level.parse(data),
			    floor:     Floor.parse(data),
			    region:    Region.parse(data),
			    continent: Continent.parse(data),
			    area:      data[:map_rect]
		end

		adapter REST do
			endpoint fetch: -> id {
				"/maps.json?map_id=#{id}"
			}

			parse do |data|
				Details.parse(data[:maps].first[1])
			end
		end
	end

	property :id, as: Integer, primary: true
	property :name, as: String

	def details
		Details.fetch(id)
	end
end

end
