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

class Database
	def self.clear
		@worlds  = nil
		@maps    = nil
		@colors  = nil
		@items   = nil
		@recipes = nil
		@events  = nil
	end

	def self.worlds
		@worlds ||= Gwentoo.worlds
	end

	def self.maps
		@maps ||= Gwentoo.maps
	end

	def self.colors
		@colors ||= Gwentoo.colors
	end

	def self.items
		@items ||= Gwentoo.items
	end

	def self.recipes
		@recipes ||= Gwentoo.recipes
	end

	def self.events
		@events ||= Gwentoo.events
	end
end
