# frozen_string_literal: true

require_relative "infix/version"
require "ostruct"

# Infix: Include this module to configure your classes
module Infix
  def infix(&block)
    return structurize(@infix ||= {}) unless block_given?

    @infix ||= {}
    @nest = []
    instance_eval(&block)
  end

  def respond_to_missing?(name, include_private); end

  def method_missing(key, val = nil, &block)
    if block_given?
      @nest << key
      instance_eval(&block)
      @nest.pop
    elsif @nest.empty?
      @infix[key] = val
    else
      nested(@infix, @nest, 0, key, val)
    end
  end

  def nested(tree, nest, idx, key, val)
    if idx == (nest.size - 1)
      tree[nest[idx]] ||= {}
      tree[nest[idx]][key] = val
      return tree[nest[idx]]
    end

    tree[nest[idx]] ||= {}
    nested(tree[nest[idx]], nest, idx + 1, key, val)
  end

  def structurize(hash)
    hash.each do |k, v|
      hash[k] = structurize(v) if v.instance_of?(Hash)
    end
    OpenStruct.new(hash)
  end
end
