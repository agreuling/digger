class Digger
  def self.dig_chain(data, *key_list, &block)
    key_list.inject(data) { |current, key| current.respond_to?(:fetch) ? current.fetch( key ) { yield if block_given? } : nil }
  end 
end
