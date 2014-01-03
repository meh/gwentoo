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

	property :id, as: String, primary: true
	property :name, as: String
	property :tag, as: String
	property :emblem, as: Hash

	adapter REST do
		endpoint fetch: -> id {
			if Guild.id?(id)
				"/guild_details.json?guild_id=#{id.encode_uri_component}"
			else
				"/guild_details.json?guild_name=#{id.encode_uri_component}"
			end
		}

		parse do |data|
			{
				id:     data[:guild_id],
				name:   data[:guild_name],
				tag:    data[:tag],
				emblem: data[:emblem]
			}
		end
	end
end

end
