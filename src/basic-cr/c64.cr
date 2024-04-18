module Basic
  module C64
    KEYWORDS = {
      "abs"     => TokenType::Abs,
      "and"     => TokenType::And,
      "asc"     => TokenType::Asc,
      "atn"     => TokenType::Atn,
      "chr$"    => TokenType::Chr,
      "close"   => TokenType::Close,
      "clr"     => TokenType::Clr,
      "cmd"     => TokenType::Cmd,
      "cont"    => TokenType::Cont,
      "cos"     => TokenType::Cos,
      "data"    => TokenType::Data,
      "def"     => TokenType::Def,
      "dim"     => TokenType::Dim,
      "end"     => TokenType::End,
      "exp"     => TokenType::Exp,
      "fn"      => TokenType::Fn,
      "for"     => TokenType::For,
      "fre"     => TokenType::Fre,
      "get"     => TokenType::Get,
      "get#"    => TokenType::GetHash,
      "gosub"   => TokenType::GoSub,
      "goto"    => TokenType::Goto,
      "if"      => TokenType::If,
      "input"   => TokenType::Input,
      "input#"  => TokenType::InputHash,
      "int"     => TokenType::Int,
      "left$"   => TokenType::Left,
      "len"     => TokenType::Len,
      "let"     => TokenType::Let,
      "list"    => TokenType::List,
      "load"    => TokenType::Load,
      "log"     => TokenType::Log,
      "mid$"    => TokenType::Mid,
      "new"     => TokenType::New,
      "next"    => TokenType::Next,
      "not"     => TokenType::Not,
      "on"      => TokenType::On,
      "open"    => TokenType::Open,
      "or"      => TokenType::Or,
      "peek"    => TokenType::Peek,
      "pi"      => TokenType::Pi,
      "poke"    => TokenType::Poke,
      "pos"     => TokenType::Pos,
      "print"   => TokenType::Print,
      "?"       => TokenType::Print,
      "print#"  => TokenType::PrintHash,
      "read"    => TokenType::Read,
      "rem"     => TokenType::Rem,
      "restore" => TokenType::Restore,
      "return"  => TokenType::Return,
      "right$"  => TokenType::Right,
      "rnd"     => TokenType::Rnd,
      "run"     => TokenType::Run,
      "save"    => TokenType::Save,
      "sgn"     => TokenType::Sgn,
      "sin"     => TokenType::Sin,
      "spc"     => TokenType::Spc,
      "sqr"     => TokenType::Sqr,
      "status"  => TokenType::Status,
      "st"      => TokenType::Status,
      "step"    => TokenType::Step,
      "stop"    => TokenType::Stop,
      "str$"    => TokenType::Str,
      "sys"     => TokenType::Sys,
      "tab"     => TokenType::Tab,
      "tan"     => TokenType::Tan,
      "then"    => TokenType::Then,
      "time"    => TokenType::Time,
      "ti"      => TokenType::Time,
      "time$"   => TokenType::TimeDollar,
      "ti$"     => TokenType::TimeDollar,
      "to"      => TokenType::To,
      "usr"     => TokenType::Usr,
      "val"     => TokenType::Val,
      "verify"  => TokenType::Verify,
      "wait"    => TokenType::Wait,
    }

    enum TokenType
      Plus
      Minus
      Star
      Slash
      Exponent
      LeftParen
      RightParen
      Dollar
      Percent
      Colon
      Semicolon
      Comma

      Equal
      NotEqual
      LessThan
      GreaterThan
      LessEqual
      GreaterEqual

      String
      Integer
      Real
      Identifier

      Abs
      And
      Asc
      Atn
      Chr
      Close
      Clr
      Cmd
      Cont
      Cos
      Data
      Def
      Dim
      End
      Exp
      Fn
      For
      Fre
      Get
      GetHash
      GoSub
      Goto
      If
      Input
      InputHash
      Int
      Left
      Len
      Let
      List
      Load
      Log
      Mid
      New
      Next
      Not
      On
      Open
      Or
      Peek
      Pi
      Poke
      Pos
      Print
      PrintHash
      Read
      Rem
      Restore
      Return
      Right
      Rnd
      Run
      Save
      Sgn
      Sin
      Spc
      Sqr
      Status
      Step
      Stop
      Str
      Sys
      Tab
      Tan
      Then
      Time
      TimeDollar
      To
      Usr
      Val
      Verify
      Wait

      EOF
    end

    class Token
      property type : TokenType
      property lexeme : String
      property literal : Int32 | Float64 | String | Nil

      def initialize(@type : TokenType, @lexeme : String, @literal : Int32 | Float64 | String | Nil = nil)
      end

      def to_string
        return @type + " " + @lexeme + " " + @literal
      end
    end

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
          raise "Invalid line on line ##{@line}"
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
            raise "Unexpected character on line ##{@line}"
          end
        end
      end

      def string
        while peek_next != '"' && !is_at_end
          advance
        end

        value = @source[@start + 2..@current]

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
        raise "Invalid command \"#{text.upcase}\" on line ##{@line}" unless type
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

    def self.run(code : String)
      lines = [] of Line

      code.each_line.with_index do |line, i|
        next if line == ""

        begin
          line_number = line.split(' ', 2)[0].to_i
          line_command = line.split(' ', 2)[1]

          raise "Error on parse line ##{i}: Line Number can not be negative! : #{line_number}" if line_number < 0

          lines << Line.new(line_number, line_command)
        rescue ArgumentError
          raise "Error on parse line ##{i}: Line did not start with a valid number!"
        end
      end

      lines = lines.sort_by { |line| line.number }

      lines.each do |line|
        scanner = Scanner.new(line.command, line.number)
        scanner.scan_tokens
        current_index = 0

        case scanner.tokens[current_index].type
        when TokenType::Print
          puts scanner.tokens[current_index += 1].literal
        end

        current_index += 1
      end
    end
  end
end
