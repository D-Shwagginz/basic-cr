module Basic
  module C64
    def self.run(code : String)
      lines = [] of Line

      code.each_line.with_index do |line, i|
        next if line == ""

        begin
          line_number = line.split(' ', 2)[0].to_i
          line_command = line.split(' ', 2)[1]

          raise LineParsingException.new("Error on parse line ##{i}: Line Number can not be negative! : #{line_number}") if line_number < 0

          lines << Line.new(line_number, line_command)
        rescue ArgumentError
          raise LineParsingException.new("Error on parse line ##{i}: Line did not start with a valid number!")
        end
      end

      lines = lines.sort_by { |line| line.number }

      lines.each do |line|
        scanner = Scanner.new(line.command, line.number)
        scanner.scan_tokens
        current_index = 0

        until current_index == scanner.tokens.size - 1
          case scanner.tokens[current_index].type
          when TokenType::Print
          end

          puts scanner.tokens[current_index].type
          current_index += 1
        end
      end
    end
  end
end
