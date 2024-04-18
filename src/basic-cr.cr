require "./basic-cr/**"

module Basic
  VERSION = 0.1

  enum Type
    C64
  end

  struct Line
    property number, command

    def initialize(number : Int32 = 0, command : String = "NONE")
      @number = number
      @command = command
    end
  end

  def self.run(type : Type, code : String)
    case type
    when Type::C64
      C64.run(code)
    end
  end
end

Basic.run(Basic::Type::C64,
  %|
1 print "Testing"
|)
