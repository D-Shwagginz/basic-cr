module Basic
  module C64
    class Scanner
      @source : String
      property tokens : Array(Token) = [] of Token

      @start = 0
      @current = 0
      @line : Int32

      def initialize(@source : String, @line : Int32)
      end

      def is_at_end
        return @current >= @source.size - 1
      end

      def scan_tokens
        until is_at_end
          @start = @current
          scan_token
        end

        @tokens << Token.new(TokenType::EOF, "")
        return @tokens
      end

      def advance
        if @current >= @source.size - 1
          raise ScannerException.new("Invalid line on line ##{@line}")
          return '\0'
        else
          return @source[@current += 1]
        end
      end

      def peek
        return '\0' if is_at_end
        return @source[@current]
      end

      def add_token(type : TokenType, literal : Int32 | Float64 | String | Nil = nil)
        text = @source[@start..@current]
        @tokens << Token.new(type, text, literal)
      end

      def match(expected : Char)
        return false if is_at_end || @source[@current] != expected
        @current += 1
        return true
      end

      def scan_token
        c = advance
        case c
        when '+'; add_token(TokenType::Plus)
        when '-'; add_token(TokenType::Minus)
        when '*'; add_token(TokenType::Star)
        when '/'; add_token(TokenType::Slash)
        when '^'; add_token(TokenType::Exponent)
        when '('; add_token(TokenType::LeftParen)
        when ')'; add_token(TokenType::RightParen)
        when '$'; add_token(TokenType::Dollar)
        when '%'; add_token(TokenType::Percent)
        when ':'; add_token(TokenType::Colon)
        when ';'; add_token(TokenType::Semicolon)
        when ','; add_token(TokenType::Comma)
        when '='; add_token(TokenType::Equal)
        when '<'
          add_token(
            match('>') ? TokenType::NotEqual : (match('=') ? TokenType::LessEqual : TokenType::LessThan)
          )
        when '>'
          add_token(match('=') ? TokenType::GreaterEqual : TokenType::GreaterThan)
        when '"'; string
        when ' '
        else
          if c.ascii_number?
            number
          elsif is_alpha(c)
            identifier
          else
            raise ScannerException.new("Unexpected character on line ##{@line}")
          end
        end
      end

      def string
        while peek_next != '"' && !is_at_end
          advance
        end

        value = @source[@start + 2..@current]

        advance

        add_token(TokenType::String, value)
      end

      def number
        while peek.ascii_number? && !is_at_end
          advance
        end

        if peek == '.' && peek_next.ascii_number? && !is_at_end
          advance

          while peek.ascii_number? && !is_at_end
            advance
          end
        end

        num = @source[@start..@current]

        if num.to_i?
          add_token(TokenType::Integer, num.to_i)
        elsif num.to_f?
          add_token(TokenType::Real, num.to_f)
        end
      end

      def peek_next
        return '\0' if @current + 1 >= @source.size
        return @source[@current + 1]
      end

      def identifier
        until KEYWORDS[@source[@start..@current].downcase]? || is_at_end
          advance
        end

        text = @source[@start..@current]
        type = KEYWORDS[text.downcase]?
        raise ScannerException.new("Invalid command \"#{text.upcase}\" on line ##{@line}") unless type
        # I chose to raise instead of letting it go
        # type = TokenType::Identifier if type == nil
        add_token(type)
      end

      def is_alpha(c : Char)
        return (c >= 'a' && c <= 'z') ||
          (c >= 'A' && c <= 'Z')
      end

      def is_alpha_numeric(c : Char)
        return is_alpha(c) || c.ascii_number?
      end
    end
  end
end
