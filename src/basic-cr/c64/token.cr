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
  end
end
