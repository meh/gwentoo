module Component; class Page < Lissio::Component::Container; module Select

class Guild < Lissio::Component
	tag id: 'select-guild'

	html do
		h1 'Select the Guild'

		input.type(:text)
	end

	css do
		rule '#select-guild' do
			rule 'input' do
				background :white
				border 1.px, :solid, :black
			end
		end
	end
end

end; end; end
