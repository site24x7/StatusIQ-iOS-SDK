# update_author.rb

# New author details to be added
new_author = 's.author = { "Site24x7" => "support@site24x7.com" }'

# Search and update all .podspec files
Dir.glob("**/*.podspec").each do |podspec|
  text = File.read(podspec)

  # Replace any s.author = {...} with the new author details
  new_text = text.gsub(/s\.author\s*=\s*\{.*?\}/m, new_author)

  # Write the changes back to the podspec file
  File.write(podspec, new_text)
  puts "Updated author in #{podspec}"
end

puts "All podspec files updated successfully!"

