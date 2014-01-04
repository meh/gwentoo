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

class Color < Lissio::Model
	class Details < Lissio::Model
		def self.parse(data)
		end

		property :brightness, as: Float
		property :contrast, as: Float
		property :saturation, as: Float
		property :lightness, as: Float

		property :hsl, as: Integer
		property :rgb, as: Array
	end

	property :id, as: Integer, primary: true
	property :name, as: String
	property :rgb, as: Array

	property :cloth, as: Details
	property :leather, as: Details
	property :metal, as: Details

	def self.parse(data)
		new id: data[:id], name: data[:name], rgb: data[:base_rgb],
			cloth:   Details.parse(data[:cloth]),
			leather: Details.parse(data[:leather]),
			metal:   Details.parse(data[:metal])
	end
end

end
