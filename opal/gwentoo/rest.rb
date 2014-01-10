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

class REST < Lissio::Adapter::REST
	def initialize(model, point = nil, options = {}, &block)
		super(model, options) do
			base     'https://api.guildwars2.com/v1'
			endpoint point if point

			http do |req|
				req.headers.clear
				
				if lang = Gwentoo.language
					req.query[:lang] = lang
				end
			end

			error do |res|
				res.json
			end

			instance_exec(&block) if block
		end
	end
end

end
