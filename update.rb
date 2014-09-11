#!/usr/bin/env ruby

# item definition
def I(l)
    l.match(/^- .*$/)
end

# Sort the readme
readme = File.read('Readme.md')
readme_sections = readme.split("\n\n")
readme_sections.map! do |section|
  lines = section.split("\n")
  heading = lines.shift
  if /"^## "/ =~ heading
    ([heading] + lines.sort).join("\n")
  else
    ([heading] + lines).join("\n")
  end
end
File.write('Readme.md', readme_sections.join("\n\n")+"\n")

# Update the sink
sink = File.readlines('kitchensink.md')
sink_header = sink.take(sink.index{|l| I(l)})
sink_footer = sink.slice(sink.rindex{|l| I(l)} + 1, sink.size)
all = File.readlines('Readme.md') + File.readlines('kitchensink.md')
all.select!{|l| I(l)}
File.write('kitchensink.md', (sink_header + all.uniq.sort + sink_footer).join(''))
