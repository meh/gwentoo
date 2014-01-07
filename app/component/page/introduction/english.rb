module Component; class Page < Lissio::Component::Container; class Introduction

class English < Lissio::Component::Markdown
	content <<-MD.gsub(/^\t{2}/m, '')
		Gwentoo
		=======
		Welcome to the Guild Wars 2® API browser, this site has no affiliation
		whatsoever with ArenaNet and all the content is their property.

		What is this?
		-------------
		This is a completely client-side API browser for Guild Wars 2®.

		This means it provides access to the item database, the recipe database,
		the color database, guild details, world map with events and World vs World
		stats.

		But foremost it is a demo application for
		[lissio](https://github.com/meh/lissio), a framework for
		[Opal](https://github.com/opal/opal).

		What's there now?
		-----------------
		As of now only guild details are available, everything will be implemented
		with time.

		Copyrights
		----------
		© 2014 ArenaNet, Inc. All rights reserved. NCsoft, the interlocking NC
		logo, ArenaNet, Guild Wars, Guild Wars Factions, Guild Wars Nightfall,
		Guild Wars: Eye of the North, Guild Wars 2, and all associated logos and
		designs are trademarks or registered trademarks of NCsoft Corporation. All
		other trademarks are the property of their respective owners.
	MD
end

end; end; end
