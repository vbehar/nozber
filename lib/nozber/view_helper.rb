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
    
  end
end