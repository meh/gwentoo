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
#require 'color'

require 'browser/console'
require 'browser/storage'
require 'browser/canvas'

require 'lissio/component/alert'
require 'lissio/component/container'
require 'lissio/component/markdown'

require 'translate'
require 'database'

require 'component/alert'
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

		route '/guild' do
			@page.render Page::Select::Guild.new
		end

		route '/guild/:name' do |params|
			@page.loading!

			Page::Guild.prepare(params[:name]).then {|page|
				@page.render page
			}.rescue {
				@page.render Component::Error.new("No Guild named #{params[:name]} was found.")
			}
		end

		route '/map' do
			@page.render Component::Error.new('Maps not implemented yet.')
		end

		route '/items' do
			@page.render Component::Error.new('Item database not implemented yet.')
		end

		route '/recipes' do
			@page.render Component::Error.new('Recipe database not implemented yet.')
		end

		route '/dyes' do
			@page.render Component::Error.new('Dye database not implemented yet.')
		end

		route '/wvw' do
			@page.render Component::Error.new('World vs World stats not implemented yet.')
		end
	end

	on :render do
		@tab.render
		@footer.render

		if w = world
			@tab.world = w.name
		end

		if l = language
			@tab.language = l
		end
	end

	html do
		div.tab!
		div.page!
		div.footer!

		div { <<-HTML }
			<a href="https://github.com/meh/gwentoo">
				<img style="position: fixed; top: 0; right: 0; border: 0;" src="https://s3.amazonaws.com/github/ribbons/forkme_right_red_aa0000.png" alt="Fork me on GitHub">
			</a>
		HTML
	end

	css do
		font size: 14.px,
			   family: 'Text'

		color :black
		background :white

		rule 'a' do
			color :black

			rule '&:hover' do
				color '#9b1e1d'
				text decoration: :none
			end
		end
	end

	css! do
		rule 'html', 'body' do
			width  100.%
			height 100.%
		end
	end
end
