module Component; class Page < Lissio::Component::Container

class Introduction < Lissio::Component::Markdown
	content <<-MD.gsub(/^\t{2}/m, '')
		Install Gwentoo
		===============
		&gt;1970+44<br/>
		&gt;not installing gwentoo
	MD
end

end; end
