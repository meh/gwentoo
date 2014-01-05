module Component; class Page < Lissio::Component::Container; module Select

class Language < Lissio::Component
	def self.prepare
		Promise.value(new)
	end

	tag id: 'select-language'

	html do
		h1 'Select the Language'

		div.languages do
			Gwentoo.languages.each {|code, name|
				div do
					a.href(:back).text(name).on :click do
						Application.language = code
					end
				end
			}
		end
	end

	css do
		rule '#select-language' do
			rule '.languages' do
				rule 'div' do
					float :left
					width 25.%
					text align: :center

					font size: 24.px
				end
			end
		end
	end
end

end; end; end
