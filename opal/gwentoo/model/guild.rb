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

class Guild < Lissio::Model
	def self.id?(string)
		string.length == 36 && string.count('-') == 4
	end

	class Emblem < Lissio::Model
		class Background < Lissio::Model
			property :id, as: Integer, primary: true
			property :color, as: Integer

			def self.parse(data)
				new id: data[:background_id], color: data[:background_color_id]
			end
		end

		class Foreground < Lissio::Model
			property :id, as: Integer, primary: true
			property :primary, as: Integer
			property :secondary, as: Integer

			def self.parse(data)
				new id:        data[:foreground_id],
				    primary:   data[:foreground_primary_color_id],
				    secondary: data[:foreground_secondary_color_id]
			end
		end

		property :background, as: Background
		property :foreground, as: Foreground
		property :flags, as: Array

		def self.parse(data)
			new flags:      data[:flags],
			    background: Background.parse(data),
			    foreground: Foreground.parse(data)
		end
	end

	property :id, as: String, primary: true
	property :name, as: String
	property :tag, as: String
	property :emblem, as: Emblem

	def self.parse(data)
		new id: data[:guild_id], name: data[:guild_name], tag: data[:tag],
			emblem: Emblem.parse(data[:emblem])
	end

	adapter REST do
		endpoint fetch: -> id {
			if Guild.id?(id)
				"/guild_details.json?guild_id=#{id}"
			else
				"/guild_details.json?guild_name=#{id.encode_uri_component}"
			end
		}

		parse do |data|
			Guild.parse(data)
		end
	end
end

end
