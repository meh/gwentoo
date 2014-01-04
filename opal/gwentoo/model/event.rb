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

class Event < Lissio::Model
	class Location < Lissio::Model
		def self.new(data)
			return super unless self == Location

			case data[:type]
			when :sphere   then Sphere.new(data)
			when :cylinder then Cylinder.new(data)
			when :poly     then Poly.new(data)

			else raise ArgumentError, "unknown location type: #{data[:type]}"
			end
		end

		property :type, as: Symbol
		property :center, as: Array

		class Sphere < self
			property :radius, as: Float
			property :rotation, as: Integer
		end

		class Cylinder < self
			property :height, as: Float
			property :radius, as: Float
			property :rotation, as: Integer
		end

		class Poly < self
			property :z, as: Array
			property :points, as: Array
		end
	end

	class Details < Lissio::Model
		property :level, as: Integer
		property :map, as: Integer
		property :flags, as: Array
		property :location, as: Location

		def group?
			flags.include? :group_event
		end

		def map?
			flags.include? :map_wide
		end

		def map
			Gwentoo.maps.then {|maps|
				maps.find { |m| m.id == @map }
			}
		end

		adapter REST do
			endpoint fetch: -> id {
				"/event_details.json?event_id=#{id}"
			}

			parse do |data|
				data[:events].first[1].tap {|h|
					h[:map] = h.delete(:map_id)
				}
			end
		end
	end

	class State < Lissio::Model
		property :value, as: Symbol

		def inactive?
			value == :inactive
		end

		def active?
			value == :active
		end

		def success?
			value == :success
		end

		def fail?
			value == :fail
		end

		def warmup?
			value == :warmup
		end

		def preparation?
			value == :preparation
		end

		adapter REST do
			endpoint fetch: -> id, world {
				"/events.json?world_id=#{world}&event_id=#{id}"
			}

			parse do |data|
				new value: data[:events][0][:state].downcase
			end
		end
	end

	class States < Lissio::Collection
		model State

		adapter REST do
			endpoint fetch: -> id {
				"/events.json?event_id=#{id}"
			}

			parse do |data|
				data[:events].map {|item|
					State.new(value: item[:state].downcase)
				}
			end
		end
	end

	property :id, as: String, primary: true
	property :name, as: String

	def details
		Details.fetch(id)
	end

	def state(world = nil)
		if world
			State.fetch(id, world)
		else
			States.fetch(id)
		end
	end
end

end
