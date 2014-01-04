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

require 'opal'
require 'gwentoo'

require 'browser/console'
require 'browser/storage'

require 'lissio/component/container'
require 'lissio/component/markdown'

require 'translate'
require 'database'

require 'component/tab'
require 'component/page'
require 'component/footer'

require 'component/page/introduction'
require 'component/page/guild'

require 'component/page/select/world'
require 'component/page/select/language'
require 'component/page/select/guild'

class Application < Lissio::Application
	Page = Component::Page

	def language=(language)
		$window.storage[:language] = language
		@tab.language              = language
		Gwentoo.language           = language

		Database.clear
		Database.worlds.then {|worlds|
			current = world
			new     = worlds.find { |w| w.id === current.id }

			if current.name != new.name
				self.world = new
			end
		}
	end
	expose :language=

	def language
		$window.storage[:language]
	end
	expose :language

	def world=(w)
		$window.storage[:world] = w
		@tab.world              = w.name

		unless language
			self.language = w.language
		end
	end
	expose :world=

	def world
		$window.storage[:world]
	end
	expose :world

	def initialize
		super

		router.fragment!

		@tab    = Component::Tab.new(self)
		@page   = Component::Page.new(self)
		@footer = Component::Footer.new(self)

		if language
			Gwentoo.language = language
		end

		route '/' do
			@page.render Page::Introduction.new
		end

		route '/select/world' do
			@page.loading!

			Page::Select::World.prepare.then {|page|
				@page.render page
			}
		end

		route '/select/language' do
			@page.loading!

			Page::Select::Language.prepare.then {|page|
				@page.render page
			}
		end

		route '/select/guild' do
			@page.render Page::Select::Guild.new
		end

		route '/guild/:name' do |params|
			Page::Guild.prepare(params[:name]).then {|page|
				@page.render page
			}
		end
	end

	on :render do
		@tab.render
		@footer.render

		if w = world
			@tab.world = w.name
		else
			Database.worlds.then {|worlds|
				self.world = worlds.first
			}
		end

		if l = language
			@tab.language = l
		end
	end

	html do
		div.tab!
		div.page!
		div.footer!

		div do
			%Q{<a href="https://github.com/you"><img style="position: absolute; top: 0; right: 0; border: 0;" src="https://s3.amazonaws.com/github/ribbons/forkme_right_red_aa0000.png" alt="Fork me on GitHub"></a>}
		end
	end

	css do
		rule 'body' do
			font size: 14.px,
			     family: 'Text'

			color :black

			rule 'a' do
				color :black
				text decoration: :none

				rule '&:hover' do
					color '#9b1e1d'
				end
			end
		end
	end
end
