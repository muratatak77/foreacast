# frozen_string_literal: true

class CacheUtil
  def self.expire?(key)
    return true unless key

    key = key.to_s
    cache = fetch_data(key) # get cache content
    return false if !Rails.cache.read(key).blank? && !cache.blank?

    true
  end

  def self.update(key, data)
    return nil unless key

    key = key.to_s
    Rails.cache.write(key, data)
    Rails.cache.write("cache_fresh#{key}", 'fresh')
    Rails.logger.info "Cache updated by #{key} key"
  end

  def self.fetch_data(cache_id)
    return nil unless cache_id

    Rails.cache.read(cache_id.to_s)
  end
end
