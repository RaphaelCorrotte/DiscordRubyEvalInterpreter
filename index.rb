require "json"
require "discordrb"

file = File.open "./config.json"
config = JSON.load file

client = Discordrb::Bot.new token: config["token"]

puts "Connecté !"
puts "Préfixe : #{config["prefix"]}"

client.message(start_with: config["prefix"]) do |message|

    if message.content.start_with?"#{config["prefix"]}irb"
        if config["authorized"].include? message.author.id.to_s
            message.content.sub! "ruby irb", ""
            begin
            evaled = eval message.content
            rescue RuntimeError => error
                evaled = error.to_s
            end
            message.respond "```rb\n#{evaled}```"
        else
            message.respond "Tu n'es pas autorisé !"
        end
    end # <- Replace this by an elsif to create new command
end

client.run

