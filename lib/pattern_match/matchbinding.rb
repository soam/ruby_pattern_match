module PatternMatch

# A binding is a result of a pattern match.  This is exactly a hash,
# with the mix method added so we can combine two bindings.
class MatchBinding < Hash
  def mix(other)
    other.each { |k,v|
      if self.has_key? k
        raise "Duplicate key #{k} in pattern"
      else
        self[k] = v
      end
    }
  end
end

end
