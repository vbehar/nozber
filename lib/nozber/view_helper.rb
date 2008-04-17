module Nozber
  module ViewHelper
    
    def just(value, size, side = 'l')
      value = value.to_s
      if value.size > size
        value = value[0, size]
      end
      if side == 'r'
        return value.rjust(size)
      else
        return value.ljust(size)
      end
    end
    
    def alinea(value, size, fill = ' ')
      ret = ''
      size.times { |i| ret += fill }
      ret + value
    end
    
  end
end