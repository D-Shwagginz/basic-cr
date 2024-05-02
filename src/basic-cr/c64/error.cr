module Basic
  module C64
    class BasicCompileException < Exception
    end

    class LineParsingException < BasicCompileException
    end

    class ScannerException < BasicCompileException
    end
  end
end
