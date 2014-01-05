module Component; class Page < Lissio::Component::Container; module Select

class Guild < Lissio::Component
	tag id: 'select-guild'

	html do
		h1 T.p('Select a Guild')

		input.type(:text).place_holder(T.p('Name or ID'))
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
