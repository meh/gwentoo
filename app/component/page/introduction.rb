require 'component/page/introduction/english'
require 'component/page/introduction/spanish'
require 'component/page/introduction/french'
require 'component/page/introduction/german'

module Component; class Page < Lissio::Component::Container

class Introduction
	def self.new
		case Application.language
		when :en, nil then English.new
		when :fr      then French.new
		when :es      then Spanish.new
		when :de      then German.new
		end
	end
end

end; end
