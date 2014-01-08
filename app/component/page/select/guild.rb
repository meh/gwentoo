module Component; class Page < Lissio::Component::Container; module Select

class Guild < Lissio::Component
	on :keydown, 'input' do |e|
		next unless e.key == :Enter

		unless e.target.value.empty?
			Application.navigate("/guild/#{e.target.value.encode_uri_component}")
		end
	end

	tag id: 'select-guild'

	html do
		h1 T.p('Select a Guild')

		input.type(:text).place_holder(T.p('Name or ID'))
	end

	css do
		text align: :center

		rule 'input' do
			background :white
			border :none
			border bottom: [1.px, :dashed, :black]

			font size: 23.px
			width 80.%
			color :black
		end
	end
end

end; end; end
