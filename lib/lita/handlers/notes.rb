module Lita
  module Handlers
    class Notes < Handler
      config :notes, type: Hash, default: Hash.new

      route(%r{^notes$}, :topics, command: true, help: { "topics": "List available notes"})
      route(%r{^notes\s+(\w+)}, :note, command: true, help: { "topics": "List available notes"})

      def topics(response)
        if config.notes.empty?
          response.reply("No topics available")
        else
          response.reply("Available topics: #{config.notes.keys.join(", ")}")
        end
      end

      def note(response)
        topic = response.args.first.downcase
        info = config.notes.each_with_object({}){|(k,v), hash| hash[k.to_s.downcase] = v }

        if info.has_key?(topic)
          response.reply(info[topic])
        else
          response.reply("Sorry, I don't know anything about that: #{topic}")
        end
      end

      Lita.register_handler(self)
    end
  end
end
