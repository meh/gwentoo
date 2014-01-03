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

module Component

class Tab < Lissio::Component
	element '#tab'

	html do
		div.left do
			div.content do
				div.world do
					a.href('/select/world').text('None')
				end

				div.language do
					a.href('/select/language').text('English')
				end
			end
		end

		div.right
	end

	def world=(name)
		element.at_css('.world a').inner_text = name
	end

	def language=(lang)
		element.at_css('.language a').inner_text = Gwentoo.languages[lang]
	end

	css do
		rule '#tab' do
			pointer events: :none

			position :fixed
			top      0
			left     0

			color :white

			rule 'a' do
				color :white
				text decoration: :none
			end

			rule '.left' do
				width      350.px
				height     183.px
				background url('img/tab.png')

				float :left

				pointer events: :auto

				rule '.content' do
					padding top:   10.px,
					        left:  30.px,
					        right: 50.px

					font size: 24.px

					rule '.world' do
						font size: 32.px

						rule '.current' do
							display 'inline-block'
						end
					end

					rule '.language' do
						rule '.current' do
							display 'inline-block'
						end
					end
				end
			end

			rule '.right' do
				width      96.px
				height     183.px
				background url('img/tab.side.png')

				float :left
			end
		end
	end
end

end
