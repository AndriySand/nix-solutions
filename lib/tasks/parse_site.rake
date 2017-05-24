namespace :global do
  task :scrap_site => :environment do
    puts ParserWorker.perform_in(1.seconds)
  end
end

task parse_html: ["global:scrap_site"]
