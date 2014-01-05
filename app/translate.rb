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

class Translate
	@phrases = {}
	@words   = {}

	class << self
		def phrase(phrase, to = Application.language || :en)
			return phrase if to == :en || @phrases[phrase].nil?

			@phrases[phrase][to]
		end

		alias p phrase

		def word(word, to = Application.language || :en)
			return word if to == :en || @words[word].nil?

			@words[phrase][to]
		end

		alias w word
	end
end

T = Translate
